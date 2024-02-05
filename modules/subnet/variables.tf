variable "availability_zone" {}
variable "my_ip" {}
variable "cidr_blocks" {
    description = "CIDR block for infrastructure deployment"
    type = list(object({
        cidr_block = string, 
        name = string
    }))
}

variable "vpc_id" {}