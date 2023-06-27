locals {
  organization = {
    for idx, org in var.github_organization : idx => org
  }

   organization_members = {
     for mem in var.github_organization_members : "${mem.username}-${mem.role}" => mem
   }

  teams = {
    for team in var.github_teams : team.name => team
  }

  team_membership = {
    for tm in local.team_members : tm.name => tm
  }

# Create temp object that has team ID and CSV contents
  team_members_temp = flatten([
    for team, members in var.github_team_members : [
      for tn, t in github_team.all : {
        name    = t.name
        id      = t.id
        slug    = t.slug
        members = members
      } if t.slug == team
    ]
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
}