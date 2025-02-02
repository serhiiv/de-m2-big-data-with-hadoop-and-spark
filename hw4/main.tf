terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.14.1"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_storage_bucket" "de-storage" {
  name          = var.bucket_name
  location      = var.region
  force_destroy = true # This is dangerous, but we're doing it for the sake of the homework
}

resource "google_dataproc_cluster" "de-cluster" {
  name    = var.cluster_name
  project = var.project
  region  = var.region

  cluster_config {
    staging_bucket = var.bucket_name

    master_config {
      num_instances = 1
      machine_type  = "e2-standard-4"
    }

    worker_config {
      num_instances = 2
      machine_type  = "e2-standard-4"
    }
    endpoint_config {
      enable_http_port_access = true
    }

    software_config {
      image_version       = "1.5-debian10"
      optional_components = ["ZEPPELIN"]
    }
  }

}
