locals {
  ssh_public_key = trimspace(file("~/.ssh/id_rsa.pub"))

  # Объединяем common из переменной с актуальным ssh-keys
  vms_metadata = merge(
    var.vms_metadata.common,
    {
      ssh-keys = "ubuntu:${local.ssh_public_key}"
    }
  )
}

