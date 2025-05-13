variable "virginia_vpc_cidr" {
  type = string
}
variable "VirVpc_PrivSub_Cidr" {
  type = list(string)
}
variable "VirVpc_PubSub_Cidr" {
  type = list(string)
}
variable "cidr_allowing_all" {
  type = string
}
