resource "github_team" "all" {
    name                        = var.name
    description                 = var.description
    privacy                     = var.privacy
    create_default_maintainer   = true
}