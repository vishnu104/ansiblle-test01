terraform {
  backend "s3" {
    bucket = "vishnu-terraform-state-bucket-02"
    key    = "statefiles/EC2-without_modules/ansible/terraform/tfstate.tfstate"
    region = "ap-southeast-2"
    #dynamodb_table = "vishnu-terraform-state-lock-table-01"
    encrypt        = true
  }
}