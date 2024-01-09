variable "cidr" {
  type        = string
  description = "CIDR for VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "List pf public subnets"

}

variable "privat_subnets" {
  type        = list(string)
  description = "List pf private subnets"

}

