locals {
  vm_web_full_name = "${var.project_name}-${var.environment}-${var.vm_web_role}"
  vm_db_full_name  = "${var.project_name}-${var.environment}-${var.vm_db_role}"
}

