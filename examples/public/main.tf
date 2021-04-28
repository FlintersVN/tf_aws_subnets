module "base_public_subnets" {
  source = "../../"


  vpc_id       = "vpc-9ab640fcfsdfds"
  gateway_ids  = ["igw-362ad8fsdf3"]
  subnet_name  = "test"
  subnet_cidrs = "10.23.100.0/24,10.23.101.0/24,10.23.102.0/24,10.23.103.0/24,10.23.104.0/24"
  azs          = "ap-northeast-1a,ap-northeast-1c,ap-northeast-1d"
}

