provider "google" {
  project     = "${var.project}"
  region      = "${var.location}"
  credentials = "${file("/tmp/.gcp/credentials.json")}"
}

terraform {
  required_version = "0.11.13"
}

resource "google_compute_instance" "polkadot_vm" {
  name         = "polkadot-vm"
  machine_type = "n1-highcpu-8"
  zone         = "${var.location}"

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
    }
  }

  network_interface {
    network    = "vpc-polkadot-network"
    subnetwork = "polkadot-subnetwork"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    ssh-keys = "polkadot:${file(var.pub_key_path)}"
  }
}
