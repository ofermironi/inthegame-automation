

data "azurerm_subnet" "vm_subnet" {
  name                 = "${var.vm_subnet}"
  virtual_network_name = "${var.vnet_01_name}"
  resource_group_name  = "${var.resource_group_name}"
}

resource "azurerm_network_interface" "nic01" {
  name                = "${var.vm_name}-nic01"
  location            = "${var.Location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "IPConfig1"
    subnet_id                     = data.azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.vm_name}"
  location              = "${var.Location}"
  resource_group_name   = "${var.resource_group_name}"
  network_interface_ids = [azurerm_network_interface.nic01.id]
  vm_size               = "${var.vm_size}"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "${var.managed_disk_type}"
  }
  os_profile {
    computer_name  = "${var.vm_name}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }
  os_profile_windows_config {
    provision_vm_agent = "true"
  }
  boot_diagnostics  {
    enabled     = true
    storage_uri = "" 
  }
}

# Enable backup for VM (un\comment this part by your needs)
/*
data "azurerm_backup_policy_vm" "policy" {
  name                = "DefaultPolicy"
  recovery_vault_name = "${var.backup_vault_name}"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_backup_protected_vm" "vm_backup" {
  resource_group_name = "${var.resource_group_name}"
  recovery_vault_name = "${var.backup_vault_name}"
  source_vm_id        = azurerm_virtual_machine.vm.id
  backup_policy_id    = data.azurerm_backup_policy_vm.policy.id
}

*/