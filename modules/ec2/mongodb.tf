resource "aws_security_group" "mongodb_sg" {
  name        = "${var.project_name}-mongodb-sg"
  description = "Allow MongoDB from EKS nodes."
  vpc_id      = var.vpc

  ingress {
    description = "SSH from bastion."
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [
      aws_security_group.bastion_sg.id
    ]
  }

  ingress {
    description = "MongoDB from EKS nodes."
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    security_groups = [
      var.cluster_sg
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # semantically equivalent to all ports
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-mongodb-sg"
    }
  )
}

resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.mongodb_ubuntu.id
  instance_type = "t3.micro"

  key_name  = aws_key_pair.bastion_ssh.id
  subnet_id = var.private_subnet_1a
  vpc_security_group_ids = [
    aws_security_group.mongodb_sg.id
  ]

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-mongodb"
    }
  )
}
