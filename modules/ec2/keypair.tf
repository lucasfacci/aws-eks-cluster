resource "aws_key_pair" "bastion_ssh" {
  key_name   = "${var.project_name}-keypair"
  public_key = file("~/.ssh/bastion_id_rsa.pub")
  tags       = var.tags
}
