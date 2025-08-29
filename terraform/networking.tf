# ------------------ Networking ------------------
# Use default VPC
data "aws_vpc" "default" {
  default = true
}

# Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = data.aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "mern-public-rt" }
}

# Associate route table with all subnets in default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_route_table_association" "public_assoc" {
  for_each       = toset(data.aws_subnets.default.ids)
  subnet_id      = each.key
  route_table_id = aws_route_table.public_rt.id
}
