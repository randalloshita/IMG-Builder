packer {
  required_plugins {
    vsphere = {
      version = ">= 1.1.1"
      source = "github.com/hashicorp/vsphere"
    }
  }
}

variable "os_iso_path" {
  type    = string
  default = "[Play-Datastore-02] ISO-Windows/Windows_2019_64Bit_English_X22-02970.ISO"
}

variable "vm-cpu-num" {
  type    = string
  default = "2"
}

variable "vm-disk-size" {
  type    = string
  default = "40960"
}

variable "vm-mem-size" {
  type    = string
  default = "4096"
}

variable "vm-name" {
  type    = string
  default = "Win2019-Template-Base"
}

variable "vsphere-cluster" {
  type    = string
  default = "Kopi-Cluster"
}

variable "vsphere-datacenter" {
  type    = string
  default = "KopiCloud"
}

variable "vsphere-datastore" {
  type    = string
  default = "Kopi-Datastore"
}

variable "vsphere-folder" {
  type    = string
  default = "Templates"
}

variable "vsphere-network" {
  type    = string
  default = "VM Network"
}

variable "vsphere-password" {
  type    = string
  default = "Ins3cur3P@ssw0rd"
}

variable "vsphere-server" {
  type    = string
  default = "kopi-vsphere-01"
}

variable "vsphere-user" {
  type    = string
  default = "administrator@kopicloud.local"
}

variable "winadmin-password" {
  type    = string
  default = "S3cr3t0!"
}

source "vsphere-iso" "autogenerated_1" {
  CPUs                  = "${var.vm-cpu-num}"
  RAM                   = "${var.vm-mem-size}"
  RAM_reserve_all       = true
  cluster               = "${var.vsphere-cluster}"
  communicator          = "winrm"
  convert_to_template   = "true"
  datacenter            = "${var.vsphere-datacenter}"
  datastore             = "${var.vsphere-datastore}"
  disk_controller_type  = "lsilogic-sas"
  disk_size             = "${var.vm-disk-size}"
  disk_thin_provisioned = true
  firmware              = "bios"
  floppy_files          = ["autounattend.xml", "../scripts/disable-network-discovery.cmd", "../scripts/enable-rdp.cmd", "../scripts/enable-winrm.ps1", "../scripts/install-vm-tools.cmd", "../scripts/set-temp.ps1"]
  folder                = "${var.vsphere-folder}"
  guest_os_type         = "windows9Server64Guest"
  insecure_connection   = "true"
  iso_paths             = ["${var.os_iso_path}", "[] /vmimages/tools-isoimages/windows.iso"]
  network               = "${var.vsphere-network}"
  network_adapter          = "vmxnet3"
  password              = "${var.vsphere-password}"
  username              = "${var.vsphere-user}"
  vcenter_server        = "${var.vsphere-server}"
  vm_name               = "${var.vm-name}"
  winrm_password        = "${var.winadmin-password}"
  winrm_username        = "Administrator"
}

build {
  sources = ["source.vsphere-iso.autogenerated_1"]

  provisioner "windows-shell" {
    inline = ["ipconfig"]
  }

}
