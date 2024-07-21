terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
}



module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "demo-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1", "eu-west-1"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway   = true
  enable_dns_hostnames = true
  single_nat_gateway   = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}



module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "democluster"
  cluster_version = "1.30"

  cluster_endpoint_public_access = true



  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets //["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]
  #   control_plane_subnet_ids = ["subnet-xyzde987", "subnet-slkjf456", "subnet-qeiru789"]

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t2.medium"]
  }

  eks_managed_node_groups = {
    node1 = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2_x86_64"
      instance_types = ["t2.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }


    node2 = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2_x86_64"
      instance_types = ["t2.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}