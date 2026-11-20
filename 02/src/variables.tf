variable "cloud_id" {
  type        = string
  #default     = b1ghj0t1ivbs4rhd1efk
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}
variable "folder_id" {
  type        = string
  #default     = b1gk8h2tv72651gd7rdv
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}
variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}
variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}
