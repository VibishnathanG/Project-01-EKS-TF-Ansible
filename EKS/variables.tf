variable "cidr" {
  type        = string
  description = "CIDR for VPC"
}

variable "public_subnets1" {
  type        = list(string)
  description = "List pf public subnets"

}

variable "public_subnets2" {
  type        = list(string)
  description = "List pf private subnets"

}

