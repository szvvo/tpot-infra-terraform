variable "aws_region" {}
variable "availability_zone" {}
variable "instance_type" {}
variable "pub_key" {}
variable "my_ip" {}
variable "image_name" {}
variable "cidr_blocks" {
    description = "CIDR block for infrastructure deployment"
    type = list(object({
        cidr_block = string, 
        name = string
    }))
}

variable "tpotc-rules" {
    type = list(object({
        description = string,
        ports = list(string),
        protocol = string,
        srcip = string

}))
}
