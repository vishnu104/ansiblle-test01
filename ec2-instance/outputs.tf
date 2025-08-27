output "default_vpc_id"{
    value = data.aws_vpc.default
    description = "Display default VPC id"
}

output "sg_id"{
    value = aws_security_group.web_sg
    description = "Display default VPC id"
}

output "instance_public_ip" {
    value = aws_instance.example.public_ip
    description = "Display public IPAddress of created AWS instance"

}

output "key_name" {
  value = aws_instance.example.key_name
}