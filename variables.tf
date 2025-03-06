variable "aws_region" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "environment" {
  type = string
}
variable "public_subnets_cidr" {
  type = list(any)
}
variable "private_subnets_cidr" {
  type = list(any)
}
variable "eks_cluster_name" {
  type = string
}
variable "eks_version" {
  type = string
}
variable "node_group_name" {
  type = string
}
variable "desired_size" {
  type = number
}
variable "min_size" {
  type = number
}
variable "max_size" {
  type = number
}
variable "key" {
  type = string
}
variable "ami_type" {
  type = string
}
variable "instance_types" {
  type = list(any)
}
variable "disk_size" {
  type = string
}