resource "aws_security_group" "bastion_sg" {
  name        = "${var.project_name}-bastion-sg"
  description = "Allow SSH from outside."
  vpc_id      = var.vpc

  ingress {
    description = "SSH from outside."
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
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
      Name = "${var.project_name}-bastion-sg"
    }
  )
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.bastion_ubuntu.id
  instance_type = "t3.micro"

  associate_public_ip_address = true
  key_name                    = aws_key_pair.bastion_ssh.id
  subnet_id                   = var.public_subnet_1a
  vpc_security_group_ids = [
    aws_security_group.bastion_sg.id
  ]
  user_data = <<EOF
#!/bin/bash

apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install ansible -y
EOF

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-bastion"
    }
  )
}
