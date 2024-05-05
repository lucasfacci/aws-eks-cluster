module "eks_managed_node_group" {
  source            = "./modules/managed-node-group"
  project_name      = var.project_name
  cluster_name      = module.eks_cluster.cluster_name
  private_subnet_1a = module.eks_network.private_subnet_1a
  private_subnet_1b = module.eks_network.private_subnet_1b
  tags              = var.tags
}
