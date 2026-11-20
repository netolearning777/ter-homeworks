variable "project_name" {
  type        = string
  default     = "netology"
  description = "Название проекта"
}
variable "environment" {
  type        = string
  default     = "develop"
  description = "Окружение (develop, stage, prod)"
}
variable "vm_web_role" {
  type        = string
  default     = "platform-web"
  description = "Роль первой виртуальной машины"
}
variable "vm_db_role" {
  type        = string
  default     = "platform-db"
  description = "Роль второй виртуальной машины"
}
variable "default_zone_web" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_zone_db" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr_web" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "default_cidr_db" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Семейство образов ОС для веб-сервера"
}
variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 50
    },
    db = {
      cores         = 2
      memory        = 4
      core_fraction = 20
    }
  }
  description = "Вычислительные ресурсы для виртуальных машин web и db"
}
variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Платформа процессоров ВМ веб-сервера"
}

#variable "vm_web_name" {
#  type        = string
#  default     = "netology-develop-platform-web"
#  description = "Имя виртуальной машины веб-сервера"
#}
#variable "vm_web_cores" {
#  type        = number
#  default     = 2
#  description = "Количество ядер vCPU веб-сервера"
#}
#variable "vm_web_memory" {
#  type        = number
#  default     = 1
#  description = "Объем оперативной памяти в ГБ веб-сервера"
#}
#variable "vm_web_core_fraction" {
#  type        = number
#  default     = 50
#  description = "Гарантированная доля vCPU в процентах веб-сервера"
#}
variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Флаг прерываемой ВМ веб-сервера"
}
variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "Включение публичного IP-адреса (NAT) веб-сервера"
}
#variable "vm_web_serial_port_enable" {
#  type        = number
#  default     = 1
#  description = "Включение доступа к серийной консоли веб-сервера (1 - вкл, 0 - выкл)"
#}
#variable "vm_web_ssh_user" {
#  type        = string
#  default     = "ubuntu"
#  description = "Имя пользователя ОС для проброса SSH-ключа веб-сервера"
#}
variable "vm_db_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Семейство образов ОС для DB-сервера"
}
#variable "vm_db_name" {
#  type        = string
#  default     = "netology-develop-platform-db"
#  description = "Имя виртуальной машины DB-сервера"
#}
variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Платформа процессоров ВМ DB-сервера"
}
#variable "vm_db_cores" {
#  type        = number
#  default     = 2
#  description = "Количество ядер vCPU DB-сервера"
#}
#variable "vm_db_memory" {
#  type        = number
#  default     = 2
#  description = "Объем оперативной памяти в ГБ DB-сервера"
#}
#variable "vm_db_core_fraction" {
#  type        = number
#  default     = 20
#  description = "Гарантированная доля vCPU в процентах DB-сервера"
#}
variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "Флаг прерываемой ВМ DB-сервера"
}
variable "vm_db_nat" {
  type        = bool
  default     = false
  description = "Включение публичного IP-адреса (NAT) DB-сервера"
}
variable "vms_metadata" {
  type = map(object({
    serial-port-enable = number
    ssh-keys           = string
  }))
  default = {
    common = {
      serial-port-enable = 1
      ssh-keys           = "ubuntu:ssh-ed25519 AAAAAC3NzaC1lZDI1NTE5AAAAIAElHgfJ43Mx5yfim2u0jV+Ao7x6h732KWcfX2Fya0lX"
    }
  }
  description = "Общие метаданные для всех виртуальных машин"
}

#variable "vm_db_serial_port_enable" {
#  type        = number
#  default     = 1
#  description = "Включение доступа к серийной консоли DB-сервера (1 - вкл, 0 - выкл)"
#}
#variable "vm_db_ssh_user" {
#  type        = string
#  default     = "ubuntu"
#  description = "Имя пользователя ОС для проброса SSH-ключа DB-сервера"
#}
#variable "vms_ssh_root_key" {
#  type        = string
#  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAElHgfJ43Mx5yfim2u0jV+Ao7x6h732KWcfX2Fya0lX"
#  description = "ssh-keygen -t ed25519"
#}
