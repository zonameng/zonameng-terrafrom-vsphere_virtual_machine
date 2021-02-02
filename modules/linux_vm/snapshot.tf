resource "vsphere_virtual_machine_snapshot" "init" {
  count                = length(var.vm_name)
  virtual_machine_uuid = vsphere_virtual_machine.linux_vm[count.index].uuid
  snapshot_name        = "init"
  description          = "This is init Snapshot"
  memory               = "false"
  quiesce              = "true"
  remove_children      = "true"
  consolidate          = "true"
   depends_on = [
    vsphere_virtual_machine.linux_vm,
  ]
}
