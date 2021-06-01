variable "project_id" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "type_machine" {
  type    = string
  default = "n1-standard-32"
}

variable "zone" {
  type    = string
  default = "us-east1-c"
}

variable "image" {
  type    = string
  default = "centos-7-v20190326"
}

variable "shared_project" {
  default = "shared-network"
}

variable "shared_vpc" {
  default = "stone-shared-vpc-prod"
}

variable "compute_name" {
  default = "splunk-east-0"
}

variable "machine_count" {
  default = 2
}

variable "shared_subnet" {
  default = "default-1"
}

variable "shared_vpc_project_id" {
  default = "project-network"
}