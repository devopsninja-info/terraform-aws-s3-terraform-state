# version 
0.1.0  ([changelog](./CHANGELOG.md))

# usage
```
module "template" {
  source = "git@github.com:devopsninja-info/terraform-aws-s3-terraform-state.git?ref=0.1.0

  account_id = "..."  // required,
  name       = "..."  // required,


  extra_tags = {}  // default,
}
```

# backend config reference
```
terraform {

  // ...version constraints and other configs

  backend "s3" {
    key = "PATH/TO/YOUR/TERRAFORM/CONFIG/name.tfstate"

    region         = "..."
    profile        = "..."
    bucket         = "..."
    dynamodb_table = "..."
    kms_key_id     = "alias/..."
    encrypt        = true
  }

}
```
