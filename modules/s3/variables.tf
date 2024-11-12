variable "bucket_name" {
    description = "name of the s3"
    type = string
  
}

variable "acl" {
    description = "value"
    type = string
    default = "private"
  
}