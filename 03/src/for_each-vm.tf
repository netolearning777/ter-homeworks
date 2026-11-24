variable "each_vm" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))
  default = [
    {
      vm_name     = "main"
      cpu         = 2
      ram         = 4
      disk_volume = 6
    },
    {
      vm_name     = "replica"
      cpu         = 2
      ram         = 2
      disk_volume = 5
    }
  ]
}
resource "yandex_compute_instance" "db" {
  # Преобразуем список объектов в словарь (map), где ключом выступает vm_name
  for_each = { for vm in var.each_vm : vm.vm_name => vm }
  name        = each.value.vm_name
  platform_id = "standard-v2"
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = 5
  }
  scheduling_policy {
    preemptible = true
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian.image_id
      type     = "network-hdd"
      size     = each.value.disk_volume
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    #nat       = true
  }
  metadata = local.vms_metadata
}

