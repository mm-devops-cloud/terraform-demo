
# create a new vpc on aws 
resource "aws_vpc" "mm-vpc" {
  cidr_block = var.cidr_block


  tags = {
    Name      = "mm-vpc-${var.env}",
    Terraform = "True"
  }
}

#----------------------------------------------------------------

# create a new subnet in mm-vpc

resource "aws_subnet" "mm-subnet-1" {
  vpc_id                  = aws_vpc.mm-vpc.id
  cidr_block              = var.cidr_block-sub-1
  map_public_ip_on_launch = true
  availability_zone       = var.az

  tags = {
    Name      = "mm-subnet-1-${var.env}",
    Terraform = "True"
  }
}

#----------------------------------------------------------------

# create a new route table for that mm-vpc

resource "aws_route_table" "mm-vpc-rt" {
  vpc_id = aws_vpc.mm-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mm-vpc-gw.id
  }

  tags = {
    Name      = "mm-vpc-rt-${var.env}",
    Terraform = "True"
  }
}

#----------------------------------------------------------------

# create a new internet gateway for that vpc

resource "aws_internet_gateway" "mm-vpc-gw" {
  vpc_id = aws_vpc.mm-vpc.id

  tags = {
    Name      = "mm-vpc-gw-${var.env}",
    Terraform = "True"
  }
}

#----------------------------------------------------------------

# associate subnet with route table
resource "aws_route_table_association" "mm-vpc-subnet-rt" {
  subnet_id      = aws_subnet.mm-subnet-1.id
  route_table_id = aws_route_table.mm-vpc-rt.id
}

#----------------------------------------------------------------

# create a new security group

resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_website-${var.env}"
  description = "Allow website traffic"
  vpc_id      = aws_vpc.mm-vpc.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name      = "mm-vpc-sg-${var.env}",
    Terraform = "True"
  }
}

#----------------------------------------------------------------

# create instance 

resource "aws_instance" "my-server" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.az
  key_name          = var.key
  security_groups   = [aws_security_group.allow_ssh_http.id]
  subnet_id         = aws_subnet.mm-subnet-1.id
  count             = var.counts
  user_data         = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>Welcome to StackSimplify ! AWS Infra created using Terraform in us-east-1 Region</h1>" > /var/www/html/index.html
    EOF

  tags = {
    Name      = "mm-vpc-my-server-${var.env}",
    Terraform = "True"
  }

}