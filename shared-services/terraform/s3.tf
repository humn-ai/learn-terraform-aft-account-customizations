data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "shared_services_bucket" {
  bucket = "shared-services-${data.aws_caller_identity.current.account_id}-test"
  acl    = "private"
}
