variable "github_teams" {
  type = list(object({
    name        = string
    description = string
    privacy     = string
  }))
}

variable "github_team_members" {
  type = map(list(object({
    username = string
    role     = string
  })))
}

resource "github_team" "teams" {
  for_each                  = { for team in var.github_teams : team.name => team }
  name                      = each.value.name
  description               = each.value.description
  privacy                   = each.value.privacy
  create_default_maintainer = true
}

resource "github_team_membership" "team-members" {
  for_each = {
    for item in flatten([
      for team_name, team_members in var.github_team_members : [
        for member in team_members : {
          team_name = team_name
          username  = member.username
          role      = member.role
        }
      ]
    ])
    : "${item.team_name}-${item.username}" => item
  }

  team_id  = github_team.teams[each.value.team_name].id
  username = each.value.username
  role     = each.value.role
}
