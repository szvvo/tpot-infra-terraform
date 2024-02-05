# CREATING SUBNET 
resource "aws_subnet" "TPOTC_SUBNET" {
    vpc_id = var.vpc_id
    availability_zone = var.availability_zone
    cidr_block = var.cidr_blocks[1].cidr_block
    tags = {
    Name: var.cidr_blocks[1].name
    }
}

# CREATING INTERNET GATEWAY

resource "aws_internet_gateway" "TPOTC_IG" {
    vpc_id = var.vpc_id
    tags = {
    Name: "TPOTC_InternetGateway"
    }
}

# CREATING ROUTE TABLE INSIDE TPOTC_VPC

resource "aws_route_table" "TPOTC_RT" {
    vpc_id = var.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.TPOTC_IG.id
    }
    tags = {
    Name: "TPOTC-RT"
    }
}


# CREATE RT<->SUBNET ASSOCIATION 

resource "aws_route_table_association" "TPOTC-RTA" {
    route_table_id = aws_route_table.TPOTC_RT.id
    subnet_id = aws_subnet.TPOTC_SUBNET.id
}