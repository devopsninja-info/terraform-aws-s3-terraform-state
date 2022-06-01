// {{{ s3 bucket
resource "aws_s3_bucket" "main" {
  bucket = var.name

  tags = local.tags
}

resource "aws_s3_bucket_acl" "main" {
  bucket = var.name

  acl = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = var.name

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = var.name

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "main" {
  bucket = var.name

  rule {
    id     = "main"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 7
    }

    expiration {
      expired_object_delete_marker = true
    }
  }
}
// }}}
// {{{ s3 bucket policy
resource "aws_s3_bucket_public_access_block" "main" {
  bucket = var.name

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "main" {
  bucket = var.name

  policy = data.aws_iam_policy_document.s3.json
}

data "aws_iam_policy_document" "s3" {
  statement {
    sid = "DenyUnEncryptedObjectUploads"

    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.name}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["aws:kms"]
    }
  }
}
// }}}
