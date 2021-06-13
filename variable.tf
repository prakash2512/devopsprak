variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "instance_name"
}
variable "vpc_name" {
  description = "Value of the Name tag for the vpc"
  type        = string
  default     = "task2"
}

variable "subnet_private_tags_name" {
  description = "Value of the Name tag for the subnet"
  type        = string
  default     = "subnetprivate"
}

variable "subnet_public_tags_name" {
  description = "Value of the Name tag for the subnet"
  type        = string
  default     = "subnetpublic"
}

variable "internet_gateway_name" {
  description = "Value of the Name tag for the internet gateway"
  type        = string
  default     = "igw"
}

variable "route_table_name" {
  description = "Value of the Name tag for the route table"
  type        = string
  default     = "publicrt"
}

variable "route_table_association_name" {
  description = "Value of the Name tag for the route table association"
  type        = string
  default     = "pubassoc"
}

variable "security_group_name" {
  description = "Value of the Name tag for the security group"
  type        = string
  default     = "allow_tls"
}

variable "elb_name" {
  description = "Value of the Name tag for the elb"
  type        = string
  default     = "clb"
}

variable "lb_target_group_name" {
  description = "Value of the Name tag for the lb target group"
  type        = string
  default     = "tg"
}

variable "s3_bucket_name" {
  description = "Value of the Name tag for the s3 bucket"
  type        = string
  default     = "staticwebsitebucket11062021"
}

variable "db_instance_name" {
  description = "Value of the Name tag for the db instance"
  type        = string
  default     = "demodb"
}

variable "cidr_block" {
  type = map
  default = {
  "vpc"            = "172.16.0.0/16"
  "subnet_private" = "172.16.10.0/24"
  "subnet_public"  = "172.16.20.0/24"
  "route_table"    = "0.0.0.0/0"
  "security_group" = "0.0.0.0/0"
  }
}

variable "elasticache_cluster_name" {
  description = "Value of the Name tag for the elasticache cluster"
  type        = string
  default     = "rediscluster"
}
