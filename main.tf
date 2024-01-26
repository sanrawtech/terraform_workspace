provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = "us-east-2"
}

locals {
  common_tags={
    project = "Test"
    enviornment = terraform.workspace
            }   
  name_prefix="${var.name}-${terraform.workspace}"

}

resource "aws_instance" "test" {
    count = var.instance_count[terraform.workspace]
    ami = "ami-05fb0b8c1424f266b"
    instance_type = var.instance_type[terraform.workspace]
    tags = merge(local.common_tags,
    {
        Name="${local.name_prefix}-${count.index}"
    }
    )
}

