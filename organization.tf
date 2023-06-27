resource "github_organization_settings" "organization_settings" {
    for_each = local.organization
    billing_email                                            = "test@example.com"
    company                                                  = "A company"
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
    for_each                                                 = local.organization_members
    username                                                 = each.value.username
    role                                                     = each.value.role
}