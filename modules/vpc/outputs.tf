output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "aws_public_subnet" {
  value = [for subnet in aws_subnet.public_subnet : subnet.id]
}

output "aws_private_subnet" {
  value = [for subnet in aws_subnet.private_subnet : subnet.id]
}

output "public_route_table" {
  value = aws_route_table.public_route_table.id
}

output "private_routetable" {
  value = aws_route_table.private_route_table.id
}