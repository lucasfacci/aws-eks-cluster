resource "aws_eks_node_group" "eks_managed_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.project_name}-node-group"
  node_role_arn   = aws_iam_role.eks_mng_role.arn
  subnet_ids = [
    var.private_subnet_1a,
    var.private_subnet_1b
  ]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-node-group"
    }
  )

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks_mng_role_policy_attachment_worker,
    aws_iam_role_policy_attachment.eks_mng_role_policy_attachment_cni,
    aws_iam_role_policy_attachment.eks_mng_role_policy_attachment_ecr,
  ]
}
