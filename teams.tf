resource "github_team" "all" {
    for_each                    = local.teams
    name                        = each.value.name
    description                 = each.value.description
    privacy                     = each.value.privacy
    create_default_maintainer   = true
}

resource "github_team_membership" "members" {
    #for_each                    = local.team_membership
    for_each                    = { for team-membership in var.github_team_members : "var.github_team.name-${team-membership.username}" => team-membership }
    team_id                     = each.value.team_id
    username                    = each.value.username
    role                        = each.value.role
    depends_on = [
        github_team.all
    ]
}