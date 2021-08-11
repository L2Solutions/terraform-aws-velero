
// Policy Docs

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts"
    ]
    resources = [
      "${data.aws_s3_bucket.this.arn}/*"
    ]
  }

  statement {
    actions = [
      "s3:ListBucket"
    ]
    resources = [data.aws_s3_bucket.this.arn]
  }

  statement {
    actions = [
      "ec2:DescribeVolumes",
      "ec2:DescribeSnapshots",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:CreateSnapshot",
      "ec2:DeleteSnapshot"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "this_oidc" {
  // checkov:skip=CKV_AWS_111: Ensure IAM policies does not allow write access without constraints
  statement {
    sid     = "ClusterOIDC"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_id}"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_id}:sub"
      values   = local.serviceaccounts
    }
  }
}

// Policies 

resource "aws_iam_policy" "this" {
  name_prefix = "velero_backups_policy"
  policy      = data.aws_iam_policy_document.this.json
  description = "Velero s3 IAM access"
}

// Roles 

resource "aws_iam_role" "this" {
  name_prefix        = "velero_backups"
  assume_role_policy = data.aws_iam_policy_document.this_oidc.json
}

// Attachments

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
