remote_state {
  backend = "s3"
  config = {
    bucket         = "chandra-terragrunt-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-west-2" # Change to your desired AWS region
    encrypt        = true
    dynamodb_table = "chandra-terragrunt-state-lock"
  }
}

include {
  path = "live/${get_env()}"
}
