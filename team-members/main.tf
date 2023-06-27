resource "github_team_membership" "members" {
    team_id  = var.team_id
    username = var.username
    role     = var.role
}