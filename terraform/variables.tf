variable "key_name" { type = string  }

variable "instance_type" {
     type = string 
}

variable "ami_id" {
    type = string
}

variable "volume_size" {
  description = "value of volume size in GB"
  type    = number
}

variable "volume_type" {
  description = "value of volume type"
  type = string
}

variable "tag_name" {
  description = "value of tag name"
  type    = string
}
