data "terraform_remote_state" "main_vpc" {
  backend = "s3"

  config = {
    bucket                  = "oddai-fv-terraform-state-file-storage"
    key                     = "global/vpc/terraform.tfstate"
    region                  = "ap-northeast-1"
    shared_credentials_file = "~/.aws/config"
    profile                 = "oddai-fv"
  }
}

module "base_public_subnets" {
  source = "../../"


  vpc_id       = data.terraform_remote_state.main_vpc.outputs.vpc_id
  gateway_id   = [data.terraform_remote_state.main_vpc.outputs.gateway_id]
  subnet_name  = "test"
  subnet_cidrs = "10.23.100.0/24,10.23.101.0/24,10.23.102.0/24,10.23.103.0/24,10.23.104.0/24"
  azs          = "ap-northeast-1a,ap-northeast-1c,ap-northeast-1d"
}

