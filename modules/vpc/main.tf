module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.cidr_blocks[0].name}"
  cidr = var.cidr_blocks[0].cidr_block

  azs             = [var.availability_zone]
  public_subnets  = [var.cidr_blocks[1].cidr_block]

  tags = {
    Name = "${var.cidr_blocks[0].name}"
  }
  public_subnet_tags = {
     Name = "${var.cidr_blocks[0].name}"
  }
}

