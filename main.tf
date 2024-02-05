terraform {
required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.33.0"
    }
}
}

provider "aws" {
    region = var.aws_region
}  


module "tpotc-subnet" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.TPOTC_VPC.id
  availability_zone = var.availability_zone
  my_ip = var.my_ip
  cidr_blocks = var.cidr_blocks
}


module "tpotc-server" {
  source = "./modules/tpot-server"
  instance_type = var.instance_type
  my_ip = var.my_ip
  pub_key = var.pub_key
  availability_zone = var.availability_zone
  vpc_id = aws_vpc.TPOTC_VPC.id
  wilcard = "0.0.0.0/0"
  subnet_id = module.tpotc-subnet.subnet.id
  tpotc-rules = var.tpotc-rules
  image_name = var.image_name

}

# CREATING VPC
resource "aws_vpc" "TPOTC_VPC" {
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
        Name: var.cidr_blocks[0].name
    }
}




