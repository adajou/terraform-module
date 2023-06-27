resource "github_organization_settings" "organization_settings" {
  billing_email                                            = "test@example.com"
  company                                                  = "A company"
  email                                                    = var.email
  description                                              = var.description
  name                                                     = var.name
  members_can_fork_private_repositories                    = var.members_can_fork_private_repositories
  default_repository_permission                            = var.default_repository_permission
  dependabot_security_updates_enabled_for_new_repositories = var.dependabot_security_updates_enabled_for_new_repositories
  dependabot_alerts_enabled_for_new_repositories           = var.dependabot_alerts_enabled_for_new_repositories
  dependency_graph_enabled_for_new_repositories            = var.dependency_graph_enabled_for_new_repositories
  members_can_create_repositories                          = false # members should create via ex. Terraform or IssueOps
  members_can_create_public_repositories                   = false
  members_can_create_private_repositories                  = false
  members_can_create_internal_repositories                 = false
  members_can_create_private_pages                         = false
  members_can_create_public_pages                          = false
}
