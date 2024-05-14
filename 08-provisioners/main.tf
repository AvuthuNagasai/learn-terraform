
resource "aws_instance" "web" {
  ami                    = data.aws_ami.example.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["sg-0699faddd77976d4c"]

  tags = {
    Name = "EC2 Instance1"
  }

  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = self.public_ip
}

    inline = [
      "sudo labauto ansible",
      "ansible-pull -i localhost, -U https://github.com/AvuthuNagasai/roboshop-ansible main.yml -e env=dev -e role_name=frontend"
    ]
  }

}

data "aws_ami" "example" {
  owners      = ["973714476881"]
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
}