variable "s3_bucket_id" {
  type        = string
  default     = null
  description = "Existing s3 bucket id. If none passed, will create s3 bucket"
}

variable "logging_s3_id" {
  type        = string
  default     = null
  description = "Id for s3 bucket logging."
}

variable "bucket_prefix" {
  type        = string
  default     = "velero-backups"
  description = "Name prefix for the s3 bucket."
}

variable "cluster_oidc_issuer_url" {
  type        = string
  description = "The url generated when OIDC is configured with EKS."
}

variable "velero_version" {
  type        = string
  description = "Velero helm chart verison"
  default     = "2.23.3"
}

variable "tolerations" {
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  description = "Tolerations on velero helm release"
  default     = []
}

variable "nodeSelector" {
  type        = map(string)
  description = "Node selector on velero helm release"
  default     = {}
}

variable "values" {
  type        = string
  description = "Values override for velero helmrelease."
  default     = null
}
