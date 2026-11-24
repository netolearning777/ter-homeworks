resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tftpl", {
    # Если ВМ созданы через count:
    web_vms = yandex_compute_instance.web
    
    # Если ВМ созданы через for_each, используйте values():
    db_vms = values(yandex_compute_instance.db)
    
    storage_vms  = [yandex_compute_instance.storage]
    
    # Берем значение по ключу "ssh-keys", делим строку по двоеточию ":" и забираем первый элемент [0]
    ssh_user     = split(":", local.vms_metadata["ssh-keys"])[0]
    ssh_key_path = "~/.ssh/id_rsa"
  })

  filename        = "${path.module}/inventory.ini"
  file_permission = "0644"
}

