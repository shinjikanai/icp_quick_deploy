provider "ibm" {
  bluemix_api_key = "${var.bxapikey}"
  softlayer_username = "${var.sl_username}"
  softlayer_api_key = "${var.sl_api_key}"
}


#A way to get image id by name programatically (shinji).
#data "ibm_compute_image_template" "img_tpl" {
#    name = "ICP21_installer(allinone)"
#}

resource "ibm_compute_vm_instance" "icpmaster" {
    count       = "${var.master["nodes"]}"

    datacenter  = "${var.datacenter}"
    domain      = "${var.domain}"
    #hostname    = "${format("${lower(var.instance_name)}-master%01d", count.index + 1) }"
    hostname          = "${var.instance_name}"
    
    #os_reference_code = "UBUNTU_16_64"
    image_id          = "${var.image_id}"
    cores       = "${var.master["cpu_cores"]}"
    memory      = "${var.master["memory"]}"
    disks       = ["${var.master["disk_size"]}"]
    local_disk  = "${var.master["local_disk"]}"
    network_speed         = "${var.master["network_speed"]}"
    hourly_billing        = "${var.master["hourly_billing"]}"
    private_network_only  = "${var.master["private_network_only"]}"
    #post_install_script_uri = "${var.post_install_script_uri}"
    #user_metadata = "{\"value\":\"newvalue\"}"

    #ssh_key_ids = ["${data.softlayer_ssh_key.public_key.id}"]
}




