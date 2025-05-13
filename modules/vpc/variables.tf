variable "region_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}
variable "public_subnet_cidr" {
  type = list(string)
}
variable "private_subnet_cidr" {
  type = list(string) 
}
variable "cidr_allowing_all" {
  type = string
}
