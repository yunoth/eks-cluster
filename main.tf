provider "aws" {
	access_key = var.access_key
	secret_key = var.secret_key
	region = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "eks-cluster"
  cidr = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
  tags = {
    Terraform = "true"
    Environment = "dev"
    "kubernetes.io/cluster/eks-cluster" = "shared"
  }
 public_subnet_tags = { 
    Terraform = "true"
    Environment = "dev"
    "kubernetes.io/cluster/eks-cluster" = "shared"
    "kubernetes.io/role/elb" = 1	
 }
 private_subnet_tags = { 
    Terraform = "true"
    Environment = "dev"
    "kubernetes.io/cluster/eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb" = 1	
 }
}
