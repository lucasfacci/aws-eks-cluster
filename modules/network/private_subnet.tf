resource "aws_subnet" "eks_private_subnet_1a" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 2)
  availability_zone = "${data.aws_region.current.name}a"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private-subnet-1a"
    }
  )
}

resource "aws_subnet" "eks_private_subnet_1b" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 3)
  availability_zone = "${data.aws_region.current.name}b"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private-subnet-1b"
    }
  )
}