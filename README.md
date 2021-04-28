# tf_aws_subnets

Simple terraform module for AWS private and public subnets

- Switching between NAT gateway and NAT instances easily
- Multi-AZ support

#### Requirements

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.12 |

#### Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | n/a     |

#### Modules

No modules.

#### Resources

| Name                                                                                                                                       | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| [aws_network_acl.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl)                          | resource |
| [aws_route.gateway_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route)                                  | resource |
| [aws_route.nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route)                                 | resource |
| [aws_route.nat_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route)                                | resource |
| [aws_route_table.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)                         | resource |
| [aws_route_table_association.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                   | resource |

#### Inputs

| Name                                                                                                   | Description                                                                                              | Type                | Default                                                                                                                                                            | Required |
| ------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------- | ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :------: |
| <a name="input_azs"></a> [azs](#input_azs)                                                             | Availability Zones                                                                                       | `string`            | `"ap-northeast-1a,ap-northeast-1c"`                                                                                                                                |    no    |
| <a name="input_gateway_ids"></a> [gateway_ids](#input_gateway_ids)                                     | Internet Gateway IDs that is used as default routes when creating public subnets                         | `list`              | `[]`                                                                                                                                                               |    no    |
| <a name="input_instance_ids"></a> [instance_ids](#input_instance_ids)                                  | List identifier of EC2 instances                                                                         | `list`              | `[]`                                                                                                                                                               |    no    |
| <a name="input_map_public_ip_on_launch"></a> [map_public_ip_on_launch](#input_map_public_ip_on_launch) | Specify true to indicate that instances launched into the subnet should be assigned a public IP address. | `bool`              | `"false"`                                                                                                                                                          |    no    |
| <a name="input_nat_gateway_ids"></a> [nat_gateway_ids](#input_nat_gateway_ids)                         | List identifier of a VPC NAT gateway                                                                     | `list`              | `[]`                                                                                                                                                               |    no    |
| <a name="input_network_acl_egress"></a> [network_acl_egress](#input_network_acl_egress)                | Egress network ACL rules                                                                                 | `list(map(string))` | <pre>[<br> {<br> "action": "allow",<br> "cidr_block": "0.0.0.0/0",<br> "from_port": 0,<br> "protocol": "-1",<br> "rule_no": 100,<br> "to_port": 0<br> }<br>]</pre> |    no    |
| <a name="input_network_acl_ingress"></a> [network_acl_ingress](#input_network_acl_ingress)             | Egress network ACL rules                                                                                 | `list(map(string))` | <pre>[<br> {<br> "action": "allow",<br> "cidr_block": "0.0.0.0/0",<br> "from_port": 0,<br> "protocol": "-1",<br> "rule_no": 100,<br> "to_port": 0<br> }<br>]</pre> |    no    |
| <a name="input_subnet_cidrs"></a> [subnet_cidrs](#input_subnet_cidrs)                                  | The CIDR block of the subnets                                                                            | `string`            | n/a                                                                                                                                                                |   yes    |
| <a name="input_subnet_name"></a> [subnet_name](#input_subnet_name)                                     | Subnets name                                                                                             | `string`            | `"dynamic"`                                                                                                                                                        |    no    |
| <a name="input_subnet_tags"></a> [subnet_tags](#input_subnet_tags)                                     | A map of tags to assign to the resource                                                                  | `map`               | `{}`                                                                                                                                                               |    no    |
| <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id)                                                    | VPC ID                                                                                                   | `string`            | n/a                                                                                                                                                                |   yes    |

#### Outputs

| Name                                                                             | Description             |
| -------------------------------------------------------------------------------- | ----------------------- |
| <a name="output_route_table_ids"></a> [route_table_ids](#output_route_table_ids) | List of route table IDs |
| <a name="output_subnet_arns"></a> [subnet_arns](#output_subnet_arns)             | List of subnet ARNs     |
| <a name="output_subnet_ids"></a> [subnet_ids](#output_subnet_ids)                | List of subnet IDs      |
