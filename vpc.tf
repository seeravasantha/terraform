resource "aws_vpc" "tf_vpc_new"{
    cidr_block = "10.1.0.0/16"
    tags = {
        "Name" = "productionvpc"
    }
}
resource "aws_subnet" "mainvpc"{
    vpc_id = aws_vpc.tf_vpc_new.id
    cidr_block = "10.1.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true  #giving public ip to instance which is in subnet
    tags ={
        "Name" = "subnetmain"
    }
}
resource "aws_internet_gateway" "tf_igw"{
    vpc_id = aws_vpc.tf_vpc_new.id
}
resource "aws_route_table" "tf_rtable"{
    vpc_id = aws_vpc.tf_vpc_new.id
}
resource "aws_route" "tf_route"{						 
    route_table_id = aws_route_table.tf_rtable.id
    gateway_id = aws_internet_gateway.tf_igw.id
    destination_cidr_block = "0.0.0.0/0"
}
resource "aws_route_table_association" "tf_rtassoc"{
    route_table_id = aws_route_table.tf_rtable.id
    subnet_id = aws_subnet.mainvpc.id
}
resource "aws_security_group" "tf_sg_new"{
    name = "production_sg_new"
    description = "allow ssh and http ports to get internet"
    vpc_id = aws_vpc.tf_vpc_new.id
    ingress {
    description      = "allow ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    ingress {
    description      = "allow http"
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
  }
}
