packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.3"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" {}
variable "source_ami" {}
variable "instance_type" {}
variable "vpc_id" {}
variable "subnet_id" {}

source "amazon-ebs" "ubuntu" {
  access_key    = var.aws_access_key
  secret_key    = var.aws_secret_key
  region        = var.region
  source_ami    = var.source_ami
  instance_type = var.instance_type
  ssh_username  = "ubuntu"
  ami_name      = "Swapnil-ami-build-{{timestamp}}"
  vpc_id        = var.vpc_id
  subnet_id     = var.subnet_id

  tags = {
    Name = "Swapnil-ami-build-{{timestamp}}"
  }
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sleep 30",
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo apt install git -y",
      "sudo git clone https://github.com/RajPractiseRepo/AMi-Automate_testing.git",
      "sudo rm -rf /var/www/html/index.nginx-debian.html",
      "sudo cp AMi-Automate_testing/index.html /var/www/html/index.nginx-debian.html",
      "sudo cp AMi-Automate_testing/style.css /var/www/html/style.css",
      "sudo cp AMi-Automate_testing/scorekeeper.js /var/www/html/scorekeeper.js",
      "sudo service nginx start",
      "sudo systemctl enable nginx",
      "curl https://get.docker.com | bash"
    ]
  }

}


