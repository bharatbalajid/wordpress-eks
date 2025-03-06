resource "aws_eks_cluster" "main" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.eks_version

  vpc_config {
    subnet_ids              = flatten(concat([aws_subnet.public_subnet[*].id], [aws_subnet.private_subnet[*].id]))
    security_group_ids      = [aws_security_group.eks_cluster.id]
    endpoint_public_access  = true
    endpoint_private_access = true
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]

  tags = {
    Name = "${var.eks_cluster_name}"
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = flatten([aws_subnet.private_subnet[*].id])

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  ami_type       = var.ami_type
  instance_types = var.instance_types
  disk_size      = var.disk_size

  remote_access {
    ec2_ssh_key = var.key
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_read_only
  ]

  tags = {
    Name = "${var.node_group_name}"
  }
}