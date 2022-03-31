resource "aws_instance" "web" {
ami = "ami-04a50faf2a2ec1901"
instance_type = "t2.micro"
key_name=aws_key_pair.deployer.key_name
vpc_security_group_ids=[aws_security_group.allow_tls.id]
tags = {
Name = "HelloWorld"
}
}
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJioplecnRJcqon6emmC3Yk0V6KJSLb+DqtrumMfYZGdX8ZMrWABo2LvfH97cGID3gqNkSaY97YcTnGsTry2QLBkM/wE9TGJ+7CiQvVbmvDFaJQuTELxcYu+UG3Nb+/E0gG2uPAw7kbZcj/VlxDnMQbZNnyM6xPVEstSHom5ZN2vi6XG9pdb9VEZ1wzfEwasSpu8QkcbHd1Y3y9duGaDREfx9r+2bH1RJgRZ5JolXN5vQJpGDyz9gq0cwP4DyxTEI7HtXvxm2Tn7VvcowPdg0Q+AUcB2pM/M72RB7rDAyXnJFTV7RhKRKcEwG9FsdUd1FKMCPYr0Fz/GWtRTSlnliRqN67AMOgf9g11FQrn47hxpuvQuVUITx/SD0gVSFkTTlLkj5UKX0qKtIsUzc4gC2zr7nI5FKRcMJwnmug+Q8bYXgeH6dSqLxuxMiKBpIYQ2HItF8bW4sWCGB6QWsD9+f0TsFO4zv2Ln6UY1r1pxT/nfcX633i5W2+Z/wnlwaSNa8= hp@DESKTOP-BQ7L279"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-08de22be195690b73"

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
