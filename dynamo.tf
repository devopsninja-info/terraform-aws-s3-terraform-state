resource "aws_dynamodb_table" "main" {
  name = var.name

  // billing
  //   in general PAY_PER_REQUEST mode is slighlty cheaper, just a few cents per month
  //   but provisioned is free-tier eligible, so you pay nothing during your first year
  //
  // billing_mode     = "PAY_PER_REQUEST"
  read_capacity  = 20
  write_capacity = 20

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}
