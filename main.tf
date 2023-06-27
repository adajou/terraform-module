module "organization" {
  source                                                   = "./organization"
  for_each = local.organization
  description                                              = each.value.description
  email                                                    = each.value.email
  members_can_fork_private_repositories                    = each.value.members_can_fork_private_repositories
  name                                                     = each.value.name
  default_repository_permission                            = each.value.default_repository_permission
  dependabot_alerts_enabled_for_new_repositories           = each.value.dependabot_alerts_enabled_for_new_repositories
  dependabot_security_updates_enabled_for_new_repositories = each.value.dependabot_security_updates_enabled_for_new_repositories
  dependency_graph_enabled_for_new_repositories            = each.value.dependency_graph_enabled_for_new_repositories
}

module "organization-members" {
  source                                                   = "./organization-members"
  for_each = local.organization_members
  username                                                 = each.value.username
  role                                                     = each.value.role
}

module "teams" {
  source                                                   = "./teams"
  for_each = local.teams
  name                                                     = each.value.name
  description                                              = each.value.description
  privacy                                                  = each.value.privacy
}

module "team-members" {
  source                                                   = "./team-members"
  for_each = local.team_membership
  team_id                                                  = each.value.team_id
  username                                                 = each.value.username
  role                                                     = each.value.role
  team_info_list                                           = module.team.team_info   #Error Unsupported argument, An argument named "team_info_list" is not expected here.
}
