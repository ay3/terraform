resource "aws_instance" "web" {
    ami = "ami-374db956"         # AMI Amazon Linux
    instance_type = "t2.nano"
    key_name = "${var.key_name}"

    # vpc
    vpc_security_group_ids = [
      "${aws_security_group.default.id}"
    ]
    subnet_id = "${aws_subnet.vpc_main-public-subnet.id}"
    associate_public_ip_address = "true"

    # ssh error
    provisioner "remote-exec" {
      connection {
            type = "ssh"
            user = "ec2-user"
            key_file = "${var.ssh_key_file}"
      }
      inline = [
        "sudo yum -y update"
      ]
    }
    tags {
        Name = "${var.app_name}"
    }
    user_data = <<EOS
      #cloud-config
      #hostname: "${var.app_name}"
      timezone: "Asia/Tokyo"
    EOS
}

resource "aws_security_group" "default" {
    name = "${var.app_name} default sg"
    description = "Used in ${var.app_name}"
    tags {
        Name = "${var.app_name} default sg"
    }
    # vpc
    vpc_id = "${aws_vpc.vpc_main.id}"

    # SSH access from anywhere
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

