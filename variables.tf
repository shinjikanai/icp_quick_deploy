##### SoftLayer Access Credentials ######
variable "sl_username" { default = "" }
variable "sl_api_key" { default = "" }

variable "key_name" {
  description = "Name or reference of SSH key to provision softlayer instances with"
  default = "icp-key"
}

variable "key_file" {
  description = "Path to private key on for above public key"
  default = "/home/username/id_rsa"
}

##### Common VM specifications ######
variable "datacenter" { default = "syd01" }
variable "domain" { default = "example.com" }

##### ICP version #####
variable "icp_version" { default = "ibmcom/icp-inception:2.1.0" }

# Name of the ICP installation, will be used as basename for VMs
variable "instance_name" { default = "master" }

##### ICP Instance details ######
variable "master" {
  type = "map"
  default = {
    nodes       = "1"
    cpu_cores   = "2"
    disk_size   = "25" // GB
    local_disk  = false
    memory      = "8192"
    network_speed= "1000"
    private_network_only=false
    hourly_billing=true
  }

}
data "ibm_compute_image_template" "img_tpl" {
    name = "ICP21_installer(allinone)"
}
variable image_id {
  #image id = 1781531
  description = "${data.ibm_compute_image_template.img_tpl.id}"
}
