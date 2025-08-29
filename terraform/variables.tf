variable "aws_region" { type = string }
variable "key_name" { type = string  }

variable "instance_type" {
     type = string 
}

variable "ami_id" {
    type = string
}

variable "tag_name" {
  description = "value of tag name"
  type    = string
}
