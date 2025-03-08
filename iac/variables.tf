variable "region" {
  default = "us-east-1"
}

variable "instance_name" {
  description = "Name of the instance to be created"
  default     = "learn-rust"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "subnet_id" {
  description = "The VPC subnet the instance(s) will be created in"
  default     = "subnet-98e06ac7"
}

variable "iam_instance_profile" {
  description = "IAM role for the EC2 instance to access KMS"
  default     = "EC2toKMS"
}

variable "vpc_security_group_ids" {
  description = "The VPC Security Group IDs to attach to this instance"
  default = [
    "sg-0070df6d46b3322a2"
  ]
}

variable "ami_id" {
  description = "The AMI to use"
  default     = "ami-0fc5d935ebf8bc3bc"
}

variable "number_of_instances" {
  description = "number of instances to be created"
  default     = 1
}


variable "instance_key" {
  default = "treebux-ec2-a"
}

variable "user_data" {
  type    = string
  default = <<-EOF
    #!/usr/bin/bash
    sudo apt-get update

    # Install aws cli
    echo "*** Installing AWS CLI"
    ## Automatically restart services if prompted
    sudo NEEDRESTART_MODE=a apt-get dist-upgrade --yes
    ## Dependencies
    sudo apt-get install -y unzip libc6 groff less

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    echo "*** Completed Installing AWS CLI"

    # Update apt-get
    echo "*** Updating apt-get"
    sudo apt-get update
    sudo apt-get upgrade
    sudo NEEDRESTART_MODE=a apt-get dist-upgrade --yes # Avoids manual input to prompt for restarting services
    echo "*** Completed Updating apt-get"

    # Install Go and dependencies
    echo "*** Installing Go and dependencies"
    wget https://go.dev/dl/go1.24.1.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.24.1.linux-amd64.tar.gz
    export PATH=$PATH:/usr/local/go/bin
    echo "*** Completed Installing Go and dependencies"

    # Create directory to work from
    echo "*** Creating new directory"
    NEW_DIR=go_tutorial
    mkdir $NEW_DIR
    cd $NEW_DIR
    git init
    # git clone 
    echo "*** Completed Creating new directory"
    EOF
}

variable "creds" {}
variable "vpc_cidr" {}
variable "public_subnet_cidr" {}
