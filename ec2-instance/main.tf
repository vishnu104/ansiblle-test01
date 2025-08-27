data "aws_vpc" "default" {
    default = true
  }

# Create a Security Group
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "SSH"
    from_port        = var.ssh_port
    to_port          = var.ssh_port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = var.http_port
    to_port          = var.http_port
    protocol         = var.protocol_value
    cidr_blocks      = var.cidr_block_value
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.cidr_block_value
  }

  tags = {
    Name = var.aws_sg_name
  }
}

resource "aws_instance" "example"{
    ami = var.ami_id
    instance_type = var.aws_instance_type
    key_name      = var.aws_key_pair_name
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    associate_public_ip_address = true
    #user_data     = file("./user_data.sh")
    user_data     = templatefile("templates/user_data.tpl", {instance_name = var.aws_instance_name})

    tags = {
      Name = var.aws_instance_name
    }

   metadata_options {
    http_endpoint = "enabled"
    http_tokens = "optional"
  }
}

#resource "aws_eip" "eip_web_server" {
 #  instance = aws_instance.example.id
 #  vpc = true
 #  vpc     = data.aws_vpc.default_vpc_id
 #}