variable "name" {
  type = string
}


variable "resource_group_name" {
  type = string
}


variable "location" {
  type = string
}


variable "subnet_id" {
  type = string
}


variable "size" {
  type    = string
  default = "Standard_B2s"
}


variable "admin_username" {
  type    = string
  default = "azureuser"
}


variable "admin_ssh_public_key" {
  type      = string
  sensitive = true
}


variable "private_ip_address_allocation" {
  type    = string
  default = "Dynamic"
}


variable "os_disk" {
  type = object({
    caching              = optional(string, "ReadWrite"),
    storage_account_type = optional(string, "Premium_LRS"),
    disk_size_gb         = optional(number, 64)
  })
  default = {}
}


variable "image" {
  type = object({
    publisher = string,
    offer     = string,
    sku       = string,
    version   = optional(string, "latest")
  })
  default = {
    publisher = "Canonical",
    offer     = "0001-com-ubuntu-server-jammy",
    sku       = "22_04-lts",
    version   = "latest",
  }
}


variable "data_disks" {
  type = map(object({
    disk_size_gb         = number,
    storage_account_type = optional(string, "Premium_LRS"),
    lun                  = number,
    caching              = optional(string, "ReadOnly")
  }))
  default = {}
}


variable "extensions" {
  type = map(object({
    publisher            = string,
    type                 = string,
    type_handler_version = string,
    settings             = optional(string, "{}"),
    protected_settings   = optional(string, "{}")
  }))
  default = {}
}


variable "tags" {
  type    = map(string)
  default = {}
}
