resource "aws_eip" "eks_nat_gateway_elastic_ip_1a" {
  domain = "vpc"
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-elastic-ip-1a"
    }
  )
}

resource "aws_eip" "eks_nat_gateway_elastic_ip_1b" {
  domain = "vpc"
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-elastic-ip-1b"
    }
  )
}

resource "aws_nat_gateway" "eks_nat_gateway_1a" {
  allocation_id = aws_eip.eks_nat_gateway_elastic_ip_1a.id
  subnet_id     = aws_subnet.eks_public_subnet_1a.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-nat-gateway-1a"
    }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.eks_igw]
}

resource "aws_nat_gateway" "eks_nat_gateway_1b" {
  allocation_id = aws_eip.eks_nat_gateway_elastic_ip_1b.id
  subnet_id     = aws_subnet.eks_public_subnet_1b.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-nat-gateway-1b"
    }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.eks_igw]
}

resource "aws_route_table" "eks_private_route_table_1a" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks_nat_gateway_1a.id
  }

  tags = {
    Name = "${var.project_name}-private-route-table-1a"
  }
}

resource "aws_route_table" "eks_private_route_table_1b" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks_nat_gateway_1b.id
  }

  tags = {
    Name = "${var.project_name}-private-route-table-1b"
  }
}
