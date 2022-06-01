// {{{ variables
variable "account_id" {
  type = string
}

variable "name" {
  type = string
}

variable "extra_tags" {
  type    = map(any)
  default = {}
}
// }}}
// {{{ locals
locals {
  tags = merge(
    {
      "Name"            = var.name
      "user:managed_by" = "terraform"
    },
    var.extra_tags,
  )
}
// }}}
