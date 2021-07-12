locals {
  create_s3_bucket = var.s3_bucket_id == null
  s3_bucket_id     = var.s3_bucket_id
  enable_logging   = var.logging_s3_id != null
  logging_s3_id    = var.logging_s3_id
  bucket_prefix    = var.bucket_prefix
  cluster_id       = var.cluster_id
  oidc_id          = trimprefix(var.cluster_oidc_issuer_url, "https://")
  velero_version   = var.velero_version
  tolerations      = var.tolerations
  nodeSelector     = var.nodeSelector

  logging_map = var.logging_s3_id != null ? {
    log = {
      target_bucket = local.logging_s3_id
      target_prefix = "velero/"
    }
  } : {}
}
