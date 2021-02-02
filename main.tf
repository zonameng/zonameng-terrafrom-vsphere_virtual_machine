data "vsphere_datacenter" "dc" {
  name = var.pro_datacenter
}

/*
module "Windows_virtual_machine" {
  source                     = "./modules/windows_vm"
  prod_datacenter            = "sunshineit"
  prod_datastore             = "iscsi_lun"
  prod_cluster               = "cluster"
  network_name               = "VM Network"
  template_name              = "windows server 2012 r2 template"
  vm_name                    = ["WIN2012DDC","WIN2012CSF"]
  #folder                     = "mygtest/管理端"
  vm_annotation              = ""                                #虚拟机描述,默认值为无注释
  vm_firmware                = "bios"                            #固件接口。可以是bios或EFI。默认值：bios
  vm_efi_secure_boot_enabled = "false"                           #当firmware类型设置为is时 efi，这将启用EFI安全引导。默认值：false。
  vm_cpus                    = "1"                               #虚拟机的虚拟处理器数
  vm_vpus                    = "1"                               #要在此虚拟机中的CPU之间分配的核心数。
  vm_cpu_hot_add_enabled     = "true"                            #CPU热插拔
  vm_memory_hot_add_enabled  = "true"                            #内存热插拔
  vm_memory                  = "4096"                            #内存大小   

  #vm_disk1_size              = "1"                               #vdisk1硬盘容量的大小
  #vm_eagerly_scrub           = "false"
  #vm_thin_provisioned        = "true"

  # 厚置延迟置零：无论eagerly_scrub和 thin_provisioned应设置为false。
  # 厚置备置零： eagerly_scrub应设置为true，并thin_provisioned应设置为false。
  # 精简置备： eagerly_scrub应设置为false，并 thin_provisioned应设置为true。
  # terrafrom 默认为精简置备
  computer_name = “test”
  admin_password = "P@ssw0rd"
  vm_ipv4         = "192.168.20.0/24"
  vm_ip_start     = "50"
  vm_mask         = "24"
  vm_ipv4_gateway = "192.168.20.254"
  vm_dns          = ["192.168.20.240", "114.114.114.114"]
}
*/

module "linux_virtual_machine" {
  source                     = "./modules/linux_vm/"
  prod_datacenter            = "sunshineit"
  prod_datastore             = "iscsi_lun"
  prod_cluster               = "cluster01"
  network_name               = "VM Network"
  template_name              = "Centos 7 64位"
  vm_name                    = ["myapp_89"]
  folder                     = "/MYG"  #虚拟机在所在的文件夹
  vm_annotation              = ""      #虚拟机描述,默认值为无注释
  vm_firmware                = "bios"  #固件接口。可以是bios或EFI。默认值：bios
  vm_efi_secure_boot_enabled = "false" #当firmware类型设置为is时 efi，这将启用EFI安全引导。默认值：false。
  vm_cpus                    = "2"     #虚拟机的虚拟处理器数
  vm_vpus                    = "1"     #要在此虚拟机中的CPU之间分配的核心数。核心数不能大于处理器个数
  vm_cpu_hot_add_enabled     = "true"  #CPU热插拔
  vm_memory_hot_add_enabled  = "true"  #内存热插拔
  vm_memory                  = "4096"  #内存大小   

  #vm_disk1_size             = "2"                               #vdisk1硬盘容量的大小
  #vm_eagerly_scrub          = "false"
  #vm_thin_provisioned       = "true"

  #厚置延迟置零：无论eagerly_scrub和 thin_provisioned应设置为false。
  #厚置备置零： eagerly_scrub应设置为true，并thin_provisioned应设置为false。
  #精简置备： eagerly_scrub应设置为false，并 thin_provisioned应设置为true。
  #terrafrom 默认为精简置备
  host_name       = ["myapp_89"]
  vm_domain       = "sun.com"
  vm_ipv4         = "192.168.20.0/24"
  vm_ip_start     = "89"
  vm_mask         = "24"
  vm_ipv4_gateway = "192.168.20.254"
  vm_dns          = ["210.22.70.3", "114.114.114.114"]
  vm_dns_suffix   = ["sun.com"]
}

