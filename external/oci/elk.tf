# Copyright (c) 2023, Oracle and/or its affiliates.

resource "oci_core_instance" "elk" {
  depends_on          = [oci_core_instance.homebase]
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_id
  display_name        = "elk-${var.engagement_name}"
  shape               = var.elk_shape
  freeform_tags       = local.tags

  source_details {
    source_id               = data.oci_core_images.ubuntu-20-04.images.0.id
    source_type             = "image"
    boot_volume_size_in_gbs = var.boot_volume_size_in_gbs
  }

  create_vnic_details {
    subnet_id      = oci_core_subnet.utility.id
    hostname_label = "elk-${var.engagement_name}"

    private_ip       = cidrhost(var.subnet_cidr_blocks["utility"], 13)
    assign_public_ip = false
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_provisioning_public_key)
  }

  agent_config {
    are_all_plugins_disabled = true
    is_monitoring_disabled   = true
    plugins_config {
      name          = "Compute Instance Monitoring"
      desired_state = "DISABLED"
    }
  }

  preserve_boot_volume = var.preserve_boot_volume
}
