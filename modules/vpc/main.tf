resource "aws_vpc" "main" {
    cidr_block = "100.0.0.0/16"

    tags = {
      Name = "my-vpc"
    }
  
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "my-igw"
    }

  
}

resource "aws_route_table" "main" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
        
    }

    tags = {
      Name = "my-route-table"
    }
  
}

resource "aws_route_table" "main1" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "my-route-table-nat"
    }
  
}

resource "aws_route" "nat" {
    route_table_id = aws_route_table.main1.id
    destination_cidr_block = "0.0.0.0/0"
    network_interface_id = var.nat_interface_network_interface_id
  
}