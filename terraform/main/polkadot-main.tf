provider "google" {
  project     = "${var.project}"
  region      = "${var.location}"
  credentials = "${file("/tmp/.gcp/credentials.json")}"
}

terraform {
  required_version = "0.11.13"
}

resource "google_project_service" "compute_api" {
  project = "${var.project}"
  service = "compute.googleapis.com"

  depends_on = ["google_project_service.resource_api"]
}

resource "google_project_service" "resource_api" {
  project = "${var.project}"
  service = "cloudresourcemanager.googleapis.com"
}
