module "eks_cluster" {
  source           = "./modules/cluster"
  project_name     = var.project_name
  public_subnet_1a = module.eks_network.public_subnet_1a
  public_subnet_1b = module.eks_network.public_subnet_1b
  tags             = var.tags
}
