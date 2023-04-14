
# create a new vpc on aws 
resource "aws_vpc" "mm-vpc" {
  cidr_block = "100.0.0.0/16"


  tags = {
    Name      = "mm-vpc",
    Terraform = "True"
  }
}

#----------------------------------------------------------------

# create a new subnet in mm-vpc

resource "aws_subnet" "mm-subnet-1" {
  vpc_id                  = aws_vpc.mm-vpc.id
  cidr_block              = "100.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"

  tags = {
    Name      = "mm-subnet-1",
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
    Name      = "mm-vpc-rt",
    Terraform = "True"
  }
}

#----------------------------------------------------------------

# create a new internet gateway for that vpc

resource "aws_internet_gateway" "mm-vpc-gw" {
  vpc_id = aws_vpc.mm-vpc.id

  tags = {
    Name      = "mm-vpc-gw",
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
  name        = "allow_website"
  description = "Allow website traffic"
  vpc_id      = aws_vpc.mm-vpc.id

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name      = "mm-vpc-sg",
    Terraform = "True"
  }
}

#----------------------------------------------------------------

# create instance 

resource "aws_instance" "my-server" {
  ami = "ami-0f3c9c466bb525749"
  instance_type = "t2.micro"
  availability_zone = "us-east-2a"
  key_name = "auto-key-pair"
  security_groups = [aws_security_group.allow_ssh_http.id]
  subnet_id = aws_subnet.mm-subnet-1.id

  tags = {
    Name      = "mm-vpc-my-server",
    Terraform = "True"
  }
  
}