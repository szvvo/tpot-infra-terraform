# CREATE A SECURITY GROUP FOR INBOUND CONNECTIONS


locals {
  individual_rules = flatten([
    for rule in var.tpotc-rules : [
        for port in rule.ports: {
            description = rule.description
            port = port
            source_ip = rule.srcip
            protocol = rule.protocol
        }
    ]
  ])
}


resource "aws_security_group" "TPOTC_SG_RULES" {
    name = "TPOTC_SG_RULES"
    description = "TPOTC rules needed for all features"
    vpc_id = var.vpc_id

    tags = {
    Name: "TPOTC_SG_RULES"
    }

    dynamic "ingress" {
        for_each = local.individual_rules
        content {
          description = ingress.value.description
          from_port = ingress.value.port
          to_port = ingress.value.port
          protocol = ingress.value.protocol
          cidr_blocks = [ingress.value.source_ip]
        }
      
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [var.wilcard]
    }
     egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [var.wilcard]
    }





}

# CREATE KEY_PAIR ASSOCIATION
resource "aws_key_pair" "TPOTC_KEYPAIR" {
    public_key = var.pub_key
    key_name = "TPOTC_KEYPAIR"
}

# FETCH LATEST DEBIAN 11

data "aws_ami" "latest-debian11" {
    most_recent = true
    owners = ["679593333241"]
    filter {
    name = "name"
    values = [var.image_name]
    }
    filter {
    name = "virtualization-type"
    values = ["hvm"]
    }
}

# CREATE EC2 INSTANCE
resource "aws_instance" "TPOTC_SERVER" {
    ami = data.aws_ami.latest-debian11.id
    vpc_security_group_ids = [aws_security_group.TPOTC_SG_RULES.id]
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    availability_zone = var.availability_zone
    associate_public_ip_address = true
    key_name = aws_key_pair.TPOTC_KEYPAIR.key_name
    root_block_device {
    tags = {
    }
    volume_size = 150
    }
    
    }

