provider "softlayer" {
    username = "${var.sl_username}"
    api_key = "${var.sl_api_key}"
}

data "softlayer_ssh_key" "public_key" {
  label = "${var.key_name}"
}

resource "softlayer_virtual_guest" "icpmaster" {
    count       = "${var.master["nodes"]}"

    datacenter  = "${var.datacenter}"
    domain      = "${var.domain}"
    hostname    = "${format("${lower(var.instance_name)}-master%01d", count.index + 1) }"

    #os_reference_code = "UBUNTU_16_64"
    image_id          = "${var.image_id}"
    cores       = "${var.master["cpu_cores"]}"
    memory      = "${var.master["memory"]}"
    disks       = ["${var.master["disk_size"]}"]
    local_disk  = "${var.master["local_disk"]}"
    network_speed         = "${var.master["network_speed"]}"
    hourly_billing        = "${var.master["hourly_billing"]}"
    private_network_only  = "${var.master["private_network_only"]}"

    #user_metadata = "{\"value\":\"newvalue\"}"

    ssh_key_ids = ["${data.softlayer_ssh_key.public_key.id}"]
}


