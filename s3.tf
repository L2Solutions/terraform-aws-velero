resource "aws_s3_bucket" "this" {
  count = local.create_s3_bucket ? 1 : 0

  // checkov:skip=CKV_AWS_52: AWS+TF do not properly support mfa_delete
  bucket_prefix = local.bucket_prefix
  acl           = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  dynamic "logging" {
    foreach = local.logging_map

    target_bucket = each.value.target_bucket
    target_prefix = each.value.target_prefix
  }
}

data "aws_s3_bucket" "this" {
  name = local.create_s3_bucket ? aws_s3_bucket.this[0].id : local.s3_bucket_id

  depends_on = [
    aws_s3_bucket.this
  ]
}
