variable "tags" {
    description = "A map of tags to assign to the resources."
    type = map(string)
    default = {
        Environment = "Dev"
    }
}

variable "aws_region" {
    description = "Default Region"
    type = string
}


variable "vpc_name" {
    description = "Name of VPC"
    type    = string
}

variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type    = string
}

variable "availability_zones" {
    description = "List of availability zones in the region"
    type    = list(string)
}

variable "public_subnets_cidrs" {
    description = "List of public subnet CIDR blocks"
    type    = list(string)
}

variable "private_subnets_cidrs" {
    description = "List of private subnet CIDR blocks"
    type    = list(string)
}
  