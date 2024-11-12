variable "db_name" {
    type = string
  
}

variable "username" {
    type = string
  
}

variable "password" {
    type = string
    sensitive = true
  
}

variable "instance_class" {
    type = string
    default = "db.t3.micro"
  
}

variable "allocated_storage" {
    type = number
    default = 20
  
}

variable "vpc_security_gorup_ids" {
    type = list(string)
  
}

variable "subnet_ids" {
    type = list(string)
  
}