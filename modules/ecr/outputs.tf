output "repository_name" {
  description = "Repository Name"
  value       = aws_ecr_repository.this.name
}

output "repository_arn" {
  description = "Repository ARN"
  value       = aws_ecr_repository.this.arn
}

output "repository_url" {
  description = "Repository URL"
  value       = aws_ecr_repository.this.repository_url
}