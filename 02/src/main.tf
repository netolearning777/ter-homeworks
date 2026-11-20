resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop_web" {
  name           = "${var.vpc_name}_web"
  zone           = var.default_zone_web
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_web
}
resource "yandex_vpc_subnet" "develop_db" {
  name           = "${var.vpc_name}_db"
  zone           = var.default_zone_db
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_db
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}

resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_full_name
  platform_id = var.vm_web_platform_id
  zone        = var.default_zone_web
  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_web.id
    nat       = var.vm_web_nat
  }
  metadata    = var.vms_metadata["common"]
#  metadata = {
#    serial-port-enable = var.vm_web_serial_port_enable
#    ssh-keys           = "${var.vm_web_ssh_user}:${var.vms_ssh_root_key}"
#  }
}
resource "yandex_compute_instance" "platform-db" {
  name        = local.vm_db_full_name
  platform_id = var.vm_db_platform_id
  zone        = var.default_zone_db
  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = var.vm_db_nat
  }
  metadata    = var.vms_metadata["common"]
#  metadata = {
#    serial-port-enable = var.vm_db_serial_port_enable
#    ssh-keys           = "${var.vm_db_ssh_user}:${var.vms_ssh_root_key}"
#  }
}
