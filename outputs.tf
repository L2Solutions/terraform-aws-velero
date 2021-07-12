output "s3_arn" {
  value       = data.aws_s3_bucket.this.arn
  description = "ARN for the velero backup s3 bucket"
  depends_on = [
    data.aws_s3_bucket.this
  ]
}

output "role_arn" {
  value       = aws_iam_role.this.arn
  description = "ARN for the velero role"
}

