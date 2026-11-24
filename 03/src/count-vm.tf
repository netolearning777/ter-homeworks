data "yandex_compute_image" "debian" {
  family = "debian-12"
}

resource "yandex_compute_instance" "web" {
  count = 2

depends_on = [yandex_compute_instance.db]

  name        = "web-${count.index + 1}"
  platform_id = "standard-v2"
  zone        = "ru-central1-a"
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }
  scheduling_policy {
    preemptible = true
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian.image_id
      type     = "network-ssd"
      size     = 5
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  metadata = local.vms_metadata
}
