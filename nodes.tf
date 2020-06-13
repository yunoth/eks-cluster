resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.example.name
  node_group_name = "node"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = [module.vpc.private_subnets[0],module.vpc.private_subnets[1]]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}
