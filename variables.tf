variable "vpc_id" {
  type = string
  description = "VPC ID"
}

variable "nat_gateway_id" {
  default = ""
  description = "Identifier of a VPC NAT gateway"
}

variable "instance_id" {
  default = ""
  description = "Identifier of an EC2 instance"
}

variable "gateway_id" {
  default = ""
  description = "Internet Gateway ID that is used as a default route when creating public subnets"
}

variable "subnet_name" {
  type = string
  default = "dynamic"
  description = "Subnets name"
}

variable "subnet_cidrs" {
  type        = string
  description = "The CIDR block of the subnets"
}

variable "azs" {
  type = string
  default     = "ap-northeast-1a,ap-northeast-1c"
  description = "Availability Zones"
}

variable "map_public_ip_on_launch" {
  type = bool
  default = "false"
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address."
}

variable "network_acl_id" {
  type        = string
  description = "Network ACL ID that is added to the private subnets. If empty, a new ACL will be created"
  default     = ""
}

variable "network_acl_egress" {
  description = "Egress network ACL rules"
  type        = list(map(string))

  default = [
    {
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
    },
  ]
}

variable "network_acl_ingress" {
  description = "Egress network ACL rules"
  type        = list(map(string))

  default = [
    {
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
    },
  ]
}

variable "subnet_tags" {
  default = {}
  description = "A map of tags to assign to the resource"
}
