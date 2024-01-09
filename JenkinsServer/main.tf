#Creating VPC For Jenkins Server

module "vpc" {
  source                  = "terraform-aws-modules/vpc/aws"
  name                    = "VPC-Jenkins"
  cidr                    = var.cidr
  azs                     = data.aws_availability_zones.azs.names
  public_subnets          = var.public_subnets
  map_public_ip_on_launch = true
  enable_dns_hostnames    = true

  tags = {
    name        = "VPC-Project-01"
    Terraform   = "true"
    Environment = "dev"
  }

  public_subnet_tags = {
    Name = "jenkins-subnet"
  }

}

#Creating SG Group for Jenkins Server

module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "sg-jenkinsServer"
  description = "sg for jenkins Server"
  vpc_id      = module.vpc.vpc_id
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "Jenikins Port"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "ssh"
      description = "SSH Port"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = {
    name = "jenkinsserver-sg"
  }

}

#Creating EC2 For Jenkins Server

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "JenkinsServer-Project"

  instance_type               = var.instance_type
  key_name                    = "Basic_Mumbai_KP"
  monitoring                  = true
  vpc_security_group_ids      = module.vote_service_sg.security_group_id
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data                   = file("jenkins-install.sh")
  availability_zone           = data.aws_availability_zones.azs.names[0]

  tags = {
    name        = "Jenkins-Server-Project"
    Terraform   = "true"
    Environment = "dev"
  }
}