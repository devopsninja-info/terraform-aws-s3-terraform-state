resource "aws_kms_key" "main" {
  description = "CMK for TERRAFORM STATE encryption"
  is_enabled  = true
  key_usage   = "ENCRYPT_DECRYPT"
  policy      = data.aws_iam_policy_document.kms.json
  tags        = local.tags
}

resource "aws_kms_alias" "main" {
  name          = "alias/${var.name}"
  target_key_id = aws_kms_key.main.key_id
}

# Resource – (Required) In a key policy, the value of the Resource element is "*", which means "this CMK." The asterisk ("*") identifies the CMK to which the key policy is attached.
# https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html
data "aws_iam_policy_document" "kms" {
  statement {
    sid = "Enable IAM User Permissions"

    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type = "AWS"

      identifiers = ["arn:aws:iam::${var.account_id}:root"]
    }
  }
}
