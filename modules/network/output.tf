output "public_subnet_1a" {
  value = aws_subnet.eks_public_subnet_1a.id
}

output "public_subnet_1b" {
  value = aws_subnet.eks_public_subnet_1b.id
}

output "private_subnet_1a" {
  value = aws_subnet.eks_private_subnet_1a.id
}

output "private_subnet_1b" {
  value = aws_subnet.eks_private_subnet_1b.id
}
