Deploys and configures Velero helm release and CRDs for bootstrapping your EKS cluster. Configured to use IAM roles over injecting IAM secrets into a kubernetes secret.

- [Registry](https://registry.terraform.io/modules/skyfjall/velero/aws/latest)

### Charts

- [velero](https://github.com/vmware-tanzu/helm-charts)

## terraform-docs usage

`sed -i '/^<!--- start terraform-docs --->/q' README.md && terraform-docs md . >> README.md`

<!--- start terraform-docs --->

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.15  |
| <a name="requirement_helm"></a> [helm](#requirement_helm)                | >= 2.0.0 |

## Providers

| Name                                                | Version  |
| --------------------------------------------------- | -------- |
| <a name="provider_aws"></a> [aws](#provider_aws)    | n/a      |
| <a name="provider_helm"></a> [helm](#provider_helm) | >= 2.0.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                          | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                 | resource    |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                     | resource    |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource    |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                   | resource    |
| [helm_release.velero](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                   | resource    |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)                 | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)            | data source |
| [aws_iam_policy_document.this_oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)       | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region)                                   | data source |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket)                                | data source |

## Inputs

| Name                                                                                                   | Description                                                  | Type                                                                                     | Default            | Required |
| ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------ | ---------------------------------------------------------------------------------------- | ------------------ | :------: |
| <a name="input_bucket_prefix"></a> [bucket_prefix](#input_bucket_prefix)                               | Name prefix for the s3 bucket.                               | `string`                                                                                 | `"velero-backups"` |    no    |
| <a name="input_cluster_oidc_issuer_url"></a> [cluster_oidc_issuer_url](#input_cluster_oidc_issuer_url) | The url generated when OIDC is configured with EKS.          | `string`                                                                                 | n/a                |   yes    |
| <a name="input_logging_s3_id"></a> [logging_s3_id](#input_logging_s3_id)                               | Id for s3 bucket logging.                                    | `string`                                                                                 | `null`             |    no    |
| <a name="input_nodeSelector"></a> [nodeSelector](#input_nodeSelector)                                  | Node selector on velero helm release                         | `map(string)`                                                                            | `{}`               |    no    |
| <a name="input_s3_bucket_id"></a> [s3_bucket_id](#input_s3_bucket_id)                                  | Existing s3 bucket id. If none passed, will create s3 bucket | `string`                                                                                 | `null`             |    no    |
| <a name="input_tolerations"></a> [tolerations](#input_tolerations)                                     | Tolerations on velero helm release                           | <pre>list(object({<br> key = string<br> value = string<br> effect = string<br> }))</pre> | `[]`               |    no    |
| <a name="input_values"></a> [values](#input_values)                                                    | Values override for velero helmrelease.                      | `string`                                                                                 | `null`             |    no    |
| <a name="input_velero_version"></a> [velero_version](#input_velero_version)                            | Velero helm chart verison                                    | `string`                                                                                 | `"2.23.3"`         |    no    |

## Outputs

| Name                                                        | Description                         |
| ----------------------------------------------------------- | ----------------------------------- |
| <a name="output_role_arn"></a> [role_arn](#output_role_arn) | ARN for the velero role             |
| <a name="output_s3_arn"></a> [s3_arn](#output_s3_arn)       | ARN for the velero backup s3 bucket |
