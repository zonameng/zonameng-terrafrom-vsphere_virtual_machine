data "vsphere_datacenter" "prod_datacenter" {
  name = var.prod_datacenter
}

data "vsphere_datastore" "prod_datastore" {
  name          = var.prod_datastore
  datacenter_id = "${data.vsphere_datacenter.prod_datacenter.id}"
}

data "vsphere_compute_cluster" "prod_cluster" {
  name          = var.prod_cluster
  datacenter_id = "${data.vsphere_datacenter.prod_datacenter.id}"
}

#data "vsphere_resource_pool" "pool" {
#  name          = "/vm/mytest"
# datacenter_id = "${data.vsphere_datacenter.prod_datacenter.id}"
#}
data "vsphere_network" "network" {
  name          = var.network_name
  datacenter_id = "${data.vsphere_datacenter.prod_datacenter.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = var.template_name
  datacenter_id = "${data.vsphere_datacenter.prod_datacenter.id}"
}

resource "vsphere_virtual_machine" "windows_vm" {
  count                   = length(var.vm_name)
  name                    = var.vm_name[count.index]
  resource_pool_id        = "${data.vsphere_compute_cluster.prod_cluster.resource_pool_id}"
  datastore_id            = "${data.vsphere_datastore.prod_datastore.id}"
  folder                  = var.folder
  annotation              = var.vm_annotation
  firmware                = var.vm_firmware 
  efi_secure_boot_enabled = var.vm_efi_secure_boot_enabled                            #当firmware类型设置为is时 efi，这将启用EFI安全引导
  num_cpus                = var.vm_cpus
  num_cores_per_socket    = var.vm_vpus
  cpu_hot_add_enabled     = var.vm_cpu_hot_add_enabled
  memory_hot_add_enabled  = var.vm_memory_hot_add_enabled
  memory                  = var.vm_memory
  guest_id                = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  /*
              disk {
                label            = "disk1"
                size             = var.vm_disk1_size
                unit_number      = 1
                eagerly_scrub    = var.vm_eagerly_scrub
                thin_provisioned = var.vm_thin_provisioned

                /*
                Terraform中的默认值相当于精简配置。
                厚置备延迟置零：无论eagerly_scrub和 thin_provisioned应设置为false。
                厚置备 置零： eagerly_scrub应设置为true，并thin_provisioned应设置为false。
                精简配置： eagerly_scrub应设置为false，并 thin_provisioned应设置为true。
               
              }
             */
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    timeout = "60"

    customize {
      windows_options {
        computer_name  = var.computer_name[count.index]
        admin_password = var.admin_password
        time_zone      = "210"

        /*
        workgroup             = var.workgroup}"
        join_domain           = "sun.com"
        domain_admin_user     = "administrator"
        domain_admin_password = "P@ssw0rd"
      */
      }

      network_interface {
        ipv4_address    = cidrhost(var.vm_ipv4,var.vm_ip_start+ count.index)
        ipv4_netmask    = var.vm_mask
        dns_server_list = var.vm_dns
      }

      ipv4_gateway = var.vm_ipv4_gateway
    }
  }
}
