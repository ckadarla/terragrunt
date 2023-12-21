remote_state {
  backend = "s3"
  config = {
    bucket         = "your-dev-terraform-state-bucket"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "your-dev-lock-table"
  }
}
