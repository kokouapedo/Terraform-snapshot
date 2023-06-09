# configured aws provider with proper credentials
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}


# launch the jenkins instance using ami : you can change this ami id with your own ami. 
resource "aws_instance" "jenkins_ec2_instance" {
  ami                    = "ami-0a36df1a0de1ed32b"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.jenkins_security_gp.id]
  key_name               = aws_key_pair.instance_key.key_name

 # Set the instance's root volume to 40 GB
  root_block_device {
    volume_size = 30
  }

  # Attach an additional 40 GB EBS volume
  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
<<<<<<< HEAD
    Name  = "jenkins-server"
=======
    Name = "jenkins-server"
>>>>>>> d88129a80d3b064f01a7044f486387e3c8839abc
    Owner = "Hermann90"
  }
}


<<<<<<< HEAD
# launch the Nexus instance using ami
resource "aws_instance" "nexus_ec2_instance" {
  ami                    = "ami-0d39e2dff94ea9f60"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.nexus_security_gp.id]
  key_name               = aws_key_pair.instance_key.key_name

  tags = {
    Name  = "jenkins-server"
    Owner = "Hermann90"
  }
}
=======
>>>>>>> d88129a80d3b064f01a7044f486387e3c8839abc

# an empty resource block
resource "null_resource" "name" {
  # ssh into the ec2 instance 
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(local_file.ssh_key.filename)
    hosts       = [aws_instance.jenkins_ec2_instance.public_ip, aws_instance.nexus_ec2_instance.public_ip]
  }
  # wait for ec2 to be created
  depends_on = [aws_instance.jenkins_ec2_instance]
}
