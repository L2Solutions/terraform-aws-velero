locals {
  values = yamlencode({
    configuration = {
      provider = "aws"
      backupStorageLocation = {
        bucket = data.aws_s3_bucket.this.id
        config = {
          region = data.aws_region.current.name
          s3Url  = "https://s3.us-east-2.amazonaws.com"
        }
      }
      volumeSnapshotLocation = {
        name = "default"
        config = {
          region = data.aws_region.current.name
        }
      }
    }
    initContainers = [{
      name  = "velero-plugin-for-aws"
      image = "velero/velero-plugin-for-aws:v1.2.0"
      volumeMounts = [{
        mountPath = "/target"
        name      = "plugins"
      }]
    }]
    tolerations  = local.tolerations
    nodeSelector = local.nodeSelector

    serviceAccount = {
      server = {
        annotations = {
          "eks.amazonaws.com/role-arn" = aws_iam_role.this.arn
        }
      }
    }
    credentials = {
      useSecret = false
    }
  })

}



resource "helm_release" "velero" {
  name             = "velero"
  namespace        = "velero" # we should hard code this here
  version          = local.velero_version
  repository       = "https://vmware-tanzu.github.io/helm-charts"
  chart            = "velero"
  create_namespace = true

  values = [local.values]

}
