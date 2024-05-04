resource "aws_subnet" "eks_public_subnet_1a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 0)
  availability_zone       = "${data.aws_region.current.name}a"
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-public-subnet-1a"
    }
  )
}

resource "aws_subnet" "eks_public_subnet_1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 1)
  availability_zone       = "${data.aws_region.current.name}b"
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-public-subnet-1b"
    }
  )
}

resource "aws_route_table_association" "eks_route_table_association_1a" {
  subnet_id      = aws_subnet.eks_public_subnet_1a.id
  route_table_id = aws_route_table.eks_public_route_table.id
}

resource "aws_route_table_association" "eks_route_table_association_1b" {
  subnet_id      = aws_subnet.eks_public_subnet_1b.id
  route_table_id = aws_route_table.eks_public_route_table.id
}
