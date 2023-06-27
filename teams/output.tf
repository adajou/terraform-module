output "team_info" {
  value = tomap({
    for k, team in github.all : k => {
        id   = team.id
        slug = team.slug
        name = team.name 
    }
  })
}