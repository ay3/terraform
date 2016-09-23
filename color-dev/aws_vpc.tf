#####################################
# Provider Settings
#####################################
provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "${var.region}"
}

data "terraform_remote_state" "remote_main" {
    backend = "s3"
    config {
        bucket = "${var.s3_bucket_name}"
        key = "${var.app_name}/terraform.tfstate"
        region = "${var.region}"
    }
}

#####################################
# VPC Settings
#####################################
resource "aws_vpc" "vpc_main" {
    cidr_block = "${var.root_segment}"
    tags {
        Name = "${var.app_name}"
    }
}

#####################################
# Internet Gateway Settings
#####################################
resource "aws_internet_gateway" "vpc_main-igw" {
    vpc_id = "${aws_vpc.vpc_main.id}"
    tags {
        Name = "${var.app_name} igw"
    }
}

#####################################
# Public Subnets Settings
#####################################
resource "aws_subnet" "vpc_main-public-subnet" {
    vpc_id = "${aws_vpc.vpc_main.id}"
    cidr_block = "${var.public_segment}"
    availability_zone = "${var.public_segment_az}"
    tags {
        Name = "${var.app_name} public-subnet"
    }
}

#####################################
# Private Subnets Settings
#####################################
resource "aws_subnet" "vpc_main-private-subnet" {
    vpc_id = "${aws_vpc.vpc_main.id}"
    cidr_block = "${var.private_segment}"
    availability_zone = "${var.private_segment_az}"
    tags {
        Name = "${var.app_name} private-subnet"
    }
}

#####################################
# Routes Table Settings
#####################################
resource "aws_route_table" "vpc_main-public-rt" {
    vpc_id = "${aws_vpc.vpc_main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.vpc_main-igw.id}"
    }
    tags {
        Name = "${var.app_name} public-rt"
    }
}

resource "aws_route_table_association" "vpc_main-rta" {
    subnet_id = "${aws_subnet.vpc_main-public-subnet.id}"
    route_table_id = "${aws_route_table.vpc_main-public-rt.id}"
}

