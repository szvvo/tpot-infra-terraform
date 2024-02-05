output "ec2_ip" {
    value = module.tpotc-server.server.public_ip
}

output "ec2_ami" {
    value = module.tpotc-server.server.ami
  
}