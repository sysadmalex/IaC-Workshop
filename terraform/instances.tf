data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "key" {
  key_name = "key"
  public_key = file("~/.ssh/id_rsa.pub")
}
  

resource "aws_instance" "web" {
  ami           = var.ubuntu_22_04
  instance_type = "t2.micro"

key_name = aws_key_pair.key.key_name

vpc_security_group_ids = [
  aws_security_group.web_server_sg.id
]

  tags = {
    Name = "web"
  }
}