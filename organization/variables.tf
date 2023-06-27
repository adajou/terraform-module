variable "description" {
  type = string
}

variable "email" {
  type = string
}

variable "members_can_fork_private_repositories" {
  type = bool
}

variable "name" {
  type = string
}

variable "default_repository_permission" {
  type = string
}

variable "dependabot_alerts_enabled_for_new_repositories" {
  type = bool
}

variable "dependabot_security_updates_enabled_for_new_repositories" {
  type = bool
}

variable "dependency_graph_enabled_for_new_repositories" {
  type = bool
}