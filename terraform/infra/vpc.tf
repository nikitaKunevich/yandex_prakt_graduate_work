data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = map(
    "Name", "movies-vpc",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_subnet" "eks" {
  count = 2

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = aws_vpc.vpc.id

  tags = map(
    "Name", "eks-movies-subnet",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
    "kubernetes.io/role/elb", 1,
    "kubernetes.io/role/internal-elb", 1
  )
}

resource "aws_subnet" "private" {
  count = 2

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.0.${count.index + 100}.0/24"
  vpc_id            = aws_vpc.vpc.id

  tags = map(
    "Name", "private-subnet"
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "igw_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "eks_to_igw" {
  count = 2

  subnet_id      = aws_subnet.eks.*.id[count.index]
  route_table_id = aws_route_table.igw_route.id
}
