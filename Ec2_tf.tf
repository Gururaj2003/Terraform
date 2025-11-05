resource "aws_key_pair" "my_key" {
    key_name = "my_key"
    public_key = file("enter the file name") #generate a ssh-key and paste you file name here

  }

resource "aws_default_vpc" "default" {
    
  }

resource "aws_security_group" "Ec2_tf_sg" {
    name = "tf_sg"
    description = "created from tf"
    vpc_id = aws_default_vpc.default.id

    tags = {
      name = "sg_for_tf"
      }
      

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ 0.0.0.0/0 ]
        description = "ssh"

    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ 0.0.0.0/0 ]
        description = "http"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ 0.0.0.0/0 ]
    }
      }
resource "aws_instance" "terraform_ec2" {
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.Ec2_tf_sg.name]
    instance_type = "t2.micro"
    ami = "enter the ami from aws"


    root_block_device {
      volume_size = 15
      volume_type = "gp3"
    }

tags = {
    name = "terraform_ec2"
}
  
}
