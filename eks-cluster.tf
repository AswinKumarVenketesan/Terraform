module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp3"
  }
node_groups = {
eks-kube-nodes = {
  desired_capacity = 1
  max_capacity     = 2
  min_capacity     = 1
  instance_types = ["t3a.medium"]
  disk_size = "50"
  disk_type = "gp3"
  disk_encrypted = true
  #disk_kms_key_id = aws_kms_key.eksCmk.arn
  create_launch_template = true
  launch_template_id      = aws_launch_template.eks-kube-nodes.id
  launch_template_version = aws_launch_template.eks-kube-nodes.default_version
  k8s_labels = {
    name = "kubenodes"
  }
  additional_tags = {
  Name = "eks-gpms-prod-nodes"

  }

  tags_all = {
  Name = "eks-gpms-prod-nodes"

      }
    }
 }

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
