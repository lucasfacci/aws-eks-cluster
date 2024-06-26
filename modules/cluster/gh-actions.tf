data "tls_certificate" "gh_actions_tls_certificate" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "gh_actions_oidc" {
  url = data.tls_certificate.gh_actions_tls_certificate.url

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = data.tls_certificate.gh_actions_tls_certificate.certificates[*].sha1_fingerprint

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-gh-actions-oidc"
    }
  )
}

resource "aws_iam_role" "gh_actions_oidc_role" {
  name = "${var.project_name}-gh-actions-oidc-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "${aws_iam_openid_connect_provider.gh_actions_oidc.arn}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": "repo:${var.github_account_and_repository}:ref:refs/heads/${var.github_repository_branch_name}"
                },
                "StringEquals": {
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
EOF

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-gh-actions-oidc-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "gh_actions_oidc_ecr_full_role_attachment" {
  role       = aws_iam_role.gh_actions_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_policy" "gh_actions_eks_ro" {
  name = "${var.project_name}-eks-ro"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:DescribeCluster",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "gh_actions_oidc_eks_ro_role_attachment" {
  role       = aws_iam_role.gh_actions_oidc_role.name
  policy_arn = aws_iam_policy.gh_actions_eks_ro.arn
}
