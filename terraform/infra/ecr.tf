resource "aws_ecr_repository" "movies-on-demand-api" {
  name = "movies-on-demand-api"
}

resource "aws_ecr_repository" "auth-api" {
  name = "auth-api"
}

resource "aws_ecr_repository" "admin-panel" {
  name = "admin-panel"
}

resource "aws_ecr_repository" "postgres-to-es" {
  name = "postgres-to-es"
}

resource "aws_ecr_repository" "search-api" {
  name = "search-api"
}

output "movies-on-demand-api-ecr-url" {
  value = aws_ecr_repository.movies-on-demand-api.repository_url
}

output "auth-api-ecr-url" {
  value = aws_ecr_repository.auth-api.repository_url
}

output "admin-panel-ecr-url" {
  value = aws_ecr_repository.admin-panel.repository_url
}

output "postgres-to-es-ecr-url" {
  value = aws_ecr_repository.postgres-to-es.repository_url
}

output "search-api-ecr-url" {
  value = aws_ecr_repository.search-api.repository_url
}
