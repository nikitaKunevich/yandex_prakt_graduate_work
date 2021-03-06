###########################################
# EKS master nodes IAM resources          #
###########################################

resource "aws_iam_role" "movies-cluster" {
  name = "eks-movies-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "movies-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.movies-cluster.name
}

resource "aws_iam_role_policy_attachment" "movies-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.movies-cluster.name
}


###########################################
# EKS worker nodes IAM resources          #
###########################################

resource "aws_iam_role" "movies-node" {
  name = "terraform-eks-movies-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "movies-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.movies-node.name
}

resource "aws_iam_role_policy_attachment" "movies-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.movies-node.name
}

resource "aws_iam_role_policy_attachment" "movies-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.movies-node.name
}

resource "aws_iam_instance_profile" "movies-node" {
  name = "terraform-eks-movies"
  role = aws_iam_role.movies-node.name
}