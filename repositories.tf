variable "github_team_repositories" {
  type = map(list(object({
    name     = string
    template = string
  })))
}

resource "github_repository" "repository" {
  for_each = {
    for item in flatten([
      for team_repos in var.github_team_repositories : [
        for repo in team_repos : {
          name = repo.name
        }
      ]
    ])
    : item.name => item
  }
  name               = each.value.name
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true

  template {
    owner                = "Life-Terraform"
    repository           = "default"
    include_all_branches = false
  }
}

resource "github_team_repository" "repository" {
  for_each = {
    for item in flatten([
      for team_name, team_repos in var.github_team_repositories : [
        for repo in team_repos : {
          team_name = team_name
          name      = repo.name
        }
      ]
    ])
    : "${item.team_name}-${item.name}" => item
  }
  team_id    = github_team.teams[each.value.team_name].id
  repository = github_repository.repository[each.value.name].id
  permission = "admin"
}
