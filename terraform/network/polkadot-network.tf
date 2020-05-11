provider "google" {
  project     = "${var.project}"
  region      = "${var.location}"
  credentials = "${file("/tmp/.gcp/credentials.json")}"
}

terraform {
  required_version = "0.11.13"
}

resource "google_compute_network" "vpc_network" {
  name                    = "vpc-polkadot-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "polkadot_subnet" {
  name          = "polkadot-subnetwork"
  ip_cidr_range = "10.100.10.0/27"
  region        = "${var.subnet_location}"
  network       = "${google_compute_network.vpc_network.self_link}"

  depends_on = ["google_compute_network.vpc_network"]
}

resource "google_compute_firewall" "firewall_ssh" {
  name    = "allow-ssh-from-specified-cidr-range"
  project = "${var.project}"
  network = "vpc-polkadot-network"

  allow {
    protocol = "tcp"

    ports = [
      "22",
    ]
  }

  source_ranges = [
    "${var.cidr_allowed}",
  ]

  depends_on = ["google_compute_subnetwork.polkadot_subnet"]
}
