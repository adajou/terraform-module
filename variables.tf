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