variable aws_region{
    description = "AWS region to deploy ec2-instance"
    type = string
    default = "ap-southeast-2"
}

variable aws_sg_name{
    description = "my security group name"
    type = string
    default = "webserver-securtiy-group"
}

variable aws_instance_name{
    description = "my ec2 instance name"
    type = string
    default = "vishnu-ec2-instance"
}

variable ami_id{
    description = "AMI image id"
    type = string
    default = "ami-078772dab3242ee11"
}

variable aws_instance_type{
    description = "choose an amazon instance type"
    type = string
    default = "t2.micro"
}

variable aws_key_pair_name{
    description = "choose an amazon instance type"
    type = string
    default = "vishnu-test-key-pair"
}

variable ssh_port{
    description = "choose ssh port value"
    type = string
    default = "22"
}

variable http_port{
    description = "choose http port value"
    type = string
    default = "80"
}

variable protocol_value{
    description = "choose tcp protocol"
    type = string
    default = "tcp"
}

variable cidr_block_value{
    description = "choose cidr block value"
    type = list(string)
    default = ["0.0.0.0/0"]
}