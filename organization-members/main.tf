resource "github_membership" "organization_memberships" {
  username = var.username
  role     = var.role
}
