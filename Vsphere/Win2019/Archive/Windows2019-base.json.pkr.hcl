packer {
  required_plugins {
    vsphere = {
      version = ">= 1.1.1"
      source = "github.com/hashicorp/vsphere"
    }
  }
}

variable "cpu_num" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "32768"
}

variable "mem_size" {
  type    = string
  default = "4096"
}

variable "os_iso_path" {
  type    = string
  default = "[ISO-Container] Server2019/SW_DVD9_Win_Server_STD_CORE_2019_1809.2_64Bit_English_DC_STD_MLF_X22-18452.ISO"
}

variable "vmtools_iso_path" {
  type    = string
  default = ""
}

variable "vsphere_compute_cluster" {
  type    = string
  default = "DC-WLV-HQ"
}

variable "vsphere_datastore" {
  type    = string
  default = "Production-Server-Container"
}

variable "vsphere_dc_name" {
  type    = string
  default = ""
}

variable "vsphere_folder" {
  type    = string
  default = "WindowsServer2019-Base"
}

variable "vsphere_host" {
  type    = string
  default = ""
}

variable "vsphere_password" {
  type      = string
  default   = ""
  sensitive = true
}

variable "vsphere_portgroup_name" {
  type    = string
  default = "VMC-DS-SERVER"
}

variable "vsphere_server" {
  type    = string
  default = "ntx-vcenter.velocitycommercial.int"
}

variable "vsphere_template_name" {
  type    = string
  default = "WindowsServer2019-Base"
}

variable "vsphere_user" {
  type    = string
  default = "administrator@vsphere.local"
}

variable "winadmin_password" {
  type      = string
  default   = ""
  sensitive = true
}

source "vsphere-iso" "autogenerated_1" {
  CPUs                  = "${var.cpu_num}"
  RAM                   = "${var.mem_size}"
  RAM_reserve_all       = true
  cluster               = "${var.vsphere_compute_cluster}"
  communicator          = "winrm"
  convert_to_template   = "true"
  datacenter            = "${var.vsphere_dc_name}"
  datastore             = "${var.vsphere_datastore}"
  disk_controller_type  = "lsilogic-sas"
  disk_size             = "${var.disk_size}"
  disk_thin_provisioned = true
  firmware              = "bios"
  floppy_files          = ["setup/autounattend.xml", "setup/setup.ps1", "setup/vmtools.cmd"]
  folder                = "${var.vsphere_folder}"
  guest_os_type         = "windows9Server64Guest"
  host                  = "${var.vsphere_host}"
  insecure_connection   = "true"
  iso_paths             = ["${var.os_iso_path}", "${var.vmtools_iso_path}"]
  network               = "${var.vsphere_portgroup_name}"
  network_card          = "vmxnet3"
  password              = "${var.vsphere_password}"
  username              = "${var.vsphere_user}"
  vcenter_server        = "${var.vsphere_server}"
  vm_name               = "${var.vsphere_template_name}"
  winrm_password        = "${var.winadmin_password}"
  winrm_username        = "Administrator"
}

build {
  sources = ["source.vsphere-iso.autogenerated_1"]

  provisioner "windows-shell" {
    inline = ["dir c:\\"]
  }

}
