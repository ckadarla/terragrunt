remote_state {
  backend = "s3"

  config = {
    bucket         = "chandra-terragrunt-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"  # Specify the region of your S3 bucket
    encrypt        = true
    dynamodb_table = "chandra-terragrunt-state-lock"
  }
}

include {
  path = "../terraform/global"
}

inputs = {
  region = "us-west-2"  # Specify your dev region
}


generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "aws" {
    region = "us-east-1"
}
EOF
}
