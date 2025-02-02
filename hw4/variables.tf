variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}

# for correct work create file `terraform.tfvars`
# and add there your variables
# project      = "google cloud project id"
# bucket_name  = "google cloud storage bucket name"
# cluster_name = "google dataproc cluster name"

variable "project" {}
variable "bucket_name" {}
variable "cluster_name" {}
