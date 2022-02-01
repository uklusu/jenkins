provider "aws" {
  region = "us-east-2"
}





resource "aws_instance" "project_serv" {

  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 10
  }
  key_name               = "id_rsa"
  availability_zone      = "us-east-2a"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  user_data              = <<EOF
#!/bin/bash
echo "project" > /etc/hostname
apt-get update && apt-get upgrade -y
add-apt-repository ppa:ondrej/php -y
apt-get install nginx php7.4-fpm php7.4-cli php7.4-mbstring php7.4-json php7.4-intl php7.4-intl php7.4-curl php7.4-xml php7.4-gd php7.4-mcrypt php-memcache php-mysql php7.4-xmlrpc php-imagick mariadb-server memcached htop sysstat zip php-memcached php-memcache supervisor screen snapd  php7.4-zip php7.4-apcu php7.4-mysqlnd -y
sudo apt-get update
sudo update-alternatives --set php /usr/bin/php7.4
sudo apt-get install \
   ca-certificates \
   curl \
   gnupg \
   lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
 "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
 $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
 sudo apt-get update
 sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo apt install openssh-server
sudo service ssh start
 mysql -u root --password='' -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'duck'; flush privileges;"
 rm /var/www/html/index.nginx-debian.html
EOF

}


resource "aws_key_pair" "project" {
  key_name   = "id_rsa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3fqO+5tirKeEjnjPvVFLrhIhghwQu5vHfBvCK3D/yQBRQSrURMvmNy7tZRSa/s0kgVk1DPVxzUJ2YUwFUCqdCrtxKPHaEvDSfpuuA7KZQDKwATlWIBBIKzo3GvBQIXZSP+QCkXMlcVO0QWWH/vd117Rp2K1u6+sr9yS2zM17yYwrMWRNSKSUphiq1ULjQ2xhovLmY2V9ZiloAY48iQ7ZyyFsvtgqz0kXnKwvcdapyQ49lznMErFlx71ASv/CLup/aNKJ7KgqlLpm9UMclRgk24IDDQfRFfvYFGk8UJNcOc+5/A46y7QEou33NUYa/P9jW7TAyWPvQEsFwmZujzpYrMuujyeo6BrKnngGJh4EYbpfMLFLPviXswygQmz8P9Son/TUkdAx/xb4T8BWbsujU94H1rHxjK/KOYAKoNdVIHJBZHslqToucDGGYATsGyuTJDIwcnx0R0AHvveU4DGwTsrwPa+MfbX7WMzd1GhK8JKuTmw0D+Au0hTnzeMhIBm7+7xwJQcxl4ieDfqCLcToydor1Ksfx2iYdhnQFc9dbuvDZSQSLQ733Ezfy6e68P+QZ3RrpGXjc4+E2w+eF28+3REbCV01gG6hHOA7XF3jrlY1vHaoyiAplmQu39sdxheHDjttSOi4qHSiHGq961tob19GAxGlcVfKwadV7RTZVxQ== uklusu@gmail.com"

}
resource "aws_security_group" "webserver" {
  name        = "websec"
  description = "dyn_security"



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = ["80", "443", "8080", "22", "9093"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "sec_group"
  }
}


output "webserver_public_ip_adress" {
  value = aws_instance.project_serv.public_ip
}
