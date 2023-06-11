variable "subnet_id_1" {
  description = "The default VPC subnet the instances will be created"
  default     = "subnet-0223402b5c3a7ee57"
}

variable "subnet_id_2" {
  description = "The default VPC subnet the instances will be created"
  default     = "subnet-01dcf944132ed56ee"
}

variable "vpc_id" {
  type    = string
  default = "vpc-0476c82d3a24a4e20"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "image_id" {
  type    = string
  default = "ami-0715c1897453cabd1" #This AMI is for Amazon Linux 2
}

variable "key_name" {
  type        = string
  description = "ec2 key pair"
  default     = "key_name"
}

variable "user_data_file" {
  type        = string
  description = "user data file path"
  default     = "apache.sh"
}
