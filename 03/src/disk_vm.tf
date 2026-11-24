resource "yandex_compute_disk" "disks" {
  count = 3
  name  = "disk-${count.index}"
  type  = "network-hdd"
  size  = 1
  zone  = var.default_zone
}
resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v2"
  zone        = var.default_zone
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  scheduling_policy {
    preemptible = true
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian.image_id
      type     = "network-hdd"
      size     = 5
    }
  }
# Динамическое подключение дисков
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disks
    content {
      disk_id = secondary_disk.value.id
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
  }
  metadata = local.vms_metadata
}
