module "eks_network" {
  source       = "./modules/network"
  project_name = var.project_name
  cidr_block   = var.cidr_block
  tags         = var.tags
}

module "eks_ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
}

module "eks_cluster" {
  source           = "./modules/cluster"
  project_name     = var.project_name
  public_subnet_1a = module.eks_network.public_subnet_1a
  public_subnet_1b = module.eks_network.public_subnet_1b
  tags             = var.tags
}

module "eks_managed_node_group" {
  source            = "./modules/managed-node-group"
  project_name      = var.project_name
  cluster_name      = module.eks_cluster.cluster_name
  private_subnet_1a = module.eks_network.private_subnet_1a
  private_subnet_1b = module.eks_network.private_subnet_1b
  tags              = var.tags
}

module "eks_add_ons" {
  source       = "./modules/add-ons"
  project_name = var.project_name
  cluster_name = module.eks_cluster.cluster_name
  oidc         = module.eks_cluster.oidc
  tags         = var.tags
}

module "eks_ec2" {
  source            = "./modules/ec2"
  project_name      = var.project_name
  vpc               = module.eks_network.vpc
  public_subnet_1a  = module.eks_network.public_subnet_1a
  private_subnet_1a = module.eks_network.private_subnet_1a
  cluster_sg        = module.eks_cluster.cluster_sg
  tags              = var.tags
}
