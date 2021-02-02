variable "prod_datacenter" {
  description = "description"
  type        = string
}

variable "prod_datastore" {
  description = "description"
  type        = string
}

variable "prod_cluster" {
  description = "description"
}

variable "network_name" {
  description = "description"
  type        = string
}

variable "template_name" {
  description = "description"
  type        = string
}

variable "vm_name" {
  description = "description"
  type        = list
}

variable "folder" {
  description = "description"
  type        = string
}

variable "vm_annotation" {
  description = "description"
  type        = string
}

variable "vm_firmware" {
  description = "description"
  type        = string
}

variable "vm_efi_secure_boot_enabled" {
  description = "description"
  type        = string
}

variable "vm_cpus" {
  description = "description"
  type        = string
}

variable "vm_vpus" {
  description = "description"
  type        = string
}

variable "vm_cpu_hot_add_enabled" {
  description = "description"
  type        = string
}

variable "vm_memory_hot_add_enabled" {
  description = "description"
  type        = string
}

variable "vm_memory" {
  description = "description"
  type        = string
}

/*
variable "vm_disk1_size" {
  description = "description"
  type        = string
}

variable "vm_eagerly_scrub" {
  description = "description"
  type        = string
}

variable "vm_thin_provisioned" {
  description = "description"
  type        = string
}
*/
variable "host_name" {
  description = "description"
  type        = list
}

variable "vm_domain" {
  description = "description"
  type        = string
}

variable "vm_ipv4" {
  description = "description"
  type        = string
}

variable "vm_ip_start" {
  description = "description"
  type        = string
}

variable "vm_mask" {
  description = "description"
  type        = string
}

variable "vm_ipv4_gateway" {
  description = "description"
  type        = string
}

variable "vm_dns" {
  description = "description"
  type        = list
}

variable "vm_dns_suffix" {
  description = "description"
  type        = list
}
