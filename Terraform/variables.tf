variable "aws_access_key" {
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
}

variable "image_tag" {
  description = "Docker image tag to deploy"
}

variable "key_name" {
  description = "Name of your EC2 SSH key (e.g., ayushkey)"
}

variable "docker_image" {
  description = "Your full Docker image name (e.g., ayusht45cyber/mystrapici)"
}
