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
    username                                                 = string
    role                                                     = string
    }))
}

variable "github_teams" {
  type = list(object({
    name                                                     = string
    description                                              = string
    privacy                                                  = string
    }))
}

variable "github_team_members" {
  type = map(list(object({
    username                                                 = string
    role                                                     = string
    })))
}

variable "team_info_list" {
  type    = list(object({
    id                                                       = string
    slug                                                     = string
    name                                                     = string
  }))
}

locals {
  organization = {
    for idx, org in var.github_organization : idx => org
  }

  organization_members = {
    for _, mem in var.github_organization_members : "${mem.username}-${mem.role}" => mem
  }

  teams = {
    for _, team in var.github_teams : team.name => team
  }

# Create temp object that has team ID and CSV contents
  team_members_temp = flatten([
    for team_info in var.team_info_list : {
      name    = team_info.name
      id      = team_info.id
      slug    = team_info.slug
      members = members
    } if team_info.slug == team
  ])

  # Create object for each team-user relationship
  team_members = flatten([
    for team in local.team_members_temp : [
      for member in team.members : {
        name     = "${team.slug}-${member.username}"
        team_id  = team.id
        username = member.username
        role     = member.role
      }
    ]
  ])

  team_membership = {
    for tm in local.team_members : tm.name => tm
  }
}