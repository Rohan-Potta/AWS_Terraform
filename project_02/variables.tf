variable "primary_region" {
  description = "This is the AWS Region"
  type        = string
}

variable "secondary_region" {
  description = "This is the AWS Region"
  type        = string
}

variable "primary_vpc_cidr" {
  description = "CIDR block for the primary VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "secondary_vpc_cidr" {
  description = "CIDR block for the secondary VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "primary_subnet_cidr" {
  description = "CIDR block for the primary subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "secondary_subnet_cidr" {
  description = "CIDR block for the secondary subnet"
  type        = string
  default     = "10.1.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "primary_key_name" {
  description = "Name of the SSH key pair for Primary VPC instance"
  type        = string
  default     = ""
}

variable "secondary_key_name" {
  description = "Name of the SSH key pair for Secondary VPC instance"
  type        = string
  default     = ""
}