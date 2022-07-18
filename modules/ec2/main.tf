data "aws_ami" "amazon-2" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}
data "aws_security_group" "sg" {
  id ="sg-00973a2eb6c626748"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon-2.id
  instance_type = "t3.micro"
  key_name = "bipro_aws_key"
  vpc_security_group_ids = [data.aws_security_group.sg.id]

  user_data = <<-EOL
  #!/bin/bash -xe

  yum search docker
  yum info docker
  yum install docker -y
  sudo usermod -aG docker $USER
  systemctl start docker
  docker pull spalvai/mywebapp:latest
  docker run -i -t -d -p 8080:8080 spalvai/mywebapp:latest
  EOL

  tags = {
    Name = "terraform_project"
  }
}
