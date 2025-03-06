resource "aws_iam_role" "eks_cluster" {
  name = "${var.eks_cluster_name}-cluster-role"

  assume_role_policy = file("policy/eks_assume_role_policy.json")

  tags = {
    Name = "${var.eks_cluster_name}-eks-cluster-role"
  }
}
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
resource "aws_iam_role" "eks_nodes" {
  name = "${var.eks_cluster_name}-eks-nodes-role"

  assume_role_policy = file("policy/eks_assume_role_policy_node.json")

  tags = {
    Name = "${var.eks_cluster_name}-eks-nodes-role"
  }
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ec2_read_only" {
  role       = aws_iam_role.eks_nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
resource "aws_iam_role_policy_attachment" "Administrator_Access" {
  role       = aws_iam_role.eks_nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}