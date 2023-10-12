variable "github_organization" {
  type = list(object({
    name                                                     = string
    email                                                    = string
    description                                              = optional(string, "")
    default_repository_permission                            = optional(string, "read")
    members_can_fork_private_repositories                    = optional(bool, false)
    dependabot_alerts_enabled_for_new_repositories           = optional(bool, true)
    dependabot_security_updates_enabled_for_new_repositories = optional(bool, true)
    dependency_graph_enabled_for_new_repositories            = optional(bool, true)
  }))
}

variable "github_organization_members" {
  type = list(object({
    username = string
    role     = string
  }))
}

resource "github_organization_settings" "organization_settings" {
  for_each                                                 = { for idx, org in var.github_organization : idx => org }
  billing_email                                            = "test@example.com"
  company                                                  = "Skandinaviska Enskilda Banken AB"
  description                                              = each.value.description
  email                                                    = each.value.email
  members_can_fork_private_repositories                    = each.value.members_can_fork_private_repositories
  name                                                     = each.value.name
  default_repository_permission                            = each.value.default_repository_permission
  dependabot_alerts_enabled_for_new_repositories           = each.value.dependabot_alerts_enabled_for_new_repositories
  dependabot_security_updates_enabled_for_new_repositories = each.value.dependabot_security_updates_enabled_for_new_repositories
  dependency_graph_enabled_for_new_repositories            = each.value.dependency_graph_enabled_for_new_repositories
  members_can_create_repositories                          = false # members should create via ex. Terraform or IssueOps
  members_can_create_public_repositories                   = false
  members_can_create_private_repositories                  = false
  members_can_create_internal_repositories                 = false
  members_can_create_private_pages                         = false
  members_can_create_public_pages                          = false
}

resource "github_membership" "organization_memberships" {
  for_each = { for mem in var.github_organization_members : "${mem.username}" => mem }
  username = each.value.username
  role     = each.value.role
}
