output "subnet_ids" {
  value       = aws_subnet.default.*.id
  description = "List of subnet IDs"
}

output "subnet_arns" {
  value       = aws_subnet.default.*.arn
  description = "List of subnet ARNs"
}

output "route_table_ids" {
  value       = aws_route_table.default.*.id
  description = "List of route table IDs"
}
