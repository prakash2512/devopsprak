provider "aws" {
   access_key = ""
   secret_key = ""
   region = "us-east-2"
}

resource "aws_instance" "us-east-2" {
  ami =  "ami-0b9064170e32bde34"
  availability_zone           = "us-east-2a"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  tags = {
    Name = var.instance_name
  }
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.cidr_block["vpc"]

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet_private" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.cidr_block["subnet_private"]
  availability_zone = "us-east-2a"
  tags = {
    Name = var.subnet_private_tags_name
  }
}

resource "aws_subnet" "subnet_public" {
    vpc_id                  = aws_vpc.my_vpc.id
    cidr_block              = var.cidr_block["subnet_public"]
    availability_zone       = "us-east-2b"
    tags = {
        Name = var.subnet_public_tags_name
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_route_table" "publicrt" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block = var.cidr_block["route_table"]
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "pubassoc" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.publicrt.id
}

resource "aws_security_group" "allow_tls" {
  name        = var.security_group_name
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
  }
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
  }
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.cidr_block["security_group"]]
  }

  tags = {
    Name = var.security_group_name
  }
}

resource "aws_elb" "clb" {
  name               = var.elb_name
  availability_zones = ["us-east-2a", "us-east-2b"]

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/info.php"
    interval            = 30
  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = var.elb_name
  }
}

resource "aws_lb_target_group" "tg" {
  name              = var.lb_target_group_name
  port              = 80
  protocol          = "HTTP"
  vpc_id            = aws_vpc.my_vpc.id
}

resource "aws_s3_bucket" "b" {
  bucket = var.s3_bucket_name
  acl    = "private"
}

resource "aws_db_instance" "db" {
  name              = var.db_instance_name
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t2.micro"
  username          = "user"
  password          = "********"
  allocated_storage = 5
}

resource "aws_elasticache_cluster" "example" {
  cluster_id           = var.elasticache_cluster_name
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  engine_version       = "4.0.10"
  port                 = 6379
}

resource "aws_cloudwatch_metric_alarm" "test" {
  alarm_name                = "test"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
}
