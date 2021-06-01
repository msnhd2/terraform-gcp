resource "google_compute_disk" "splunk-disk-central" {
  count = "${var.machine_count}"
  name = "datadisk-hdd-${format("${var.compute_name}%01d", count.index + 1)}"
  type = "pd-standard"
  size = "8192"
  zone = "${var.zone}"
}

resource "google_compute_attached_disk" "default-central" {
  count      = "${var.machine_count}"
  disk       = "datadisk-hdd-${format("${var.compute_name}%01d", count.index + 1)}"
  instance   = "${format("${var.compute_name}%01d", count.index + 1)}"
  zone       = "${var.zone}"
  depends_on = ["google_compute_instance.splunk-indexers-central"]
}

data "google_compute_subnetwork" "default" {
  project = "${var.shared_vpc_project_id}"
  name    = "${var.shared_subnet}"
  region  = "${var.region}"
}

resource "google_compute_address" "internal" {
  count        = "${var.machine_count}"
  name         = "${format("${var.compute_name}%01d", count.index + 1)}"
  address_type = "INTERNAL"
  region       = "${var.region}"
  project      = "${var.project_id}"
  subnetwork   = data.google_compute_subnetwork.default.self_link
  purpose      = "GCE_ENDPOINT"
}

resource "google_compute_instance" "splunk-indexers-central" {
  count        = "${var.machine_count}"
  name         = "${format("${var.compute_name}%01d", count.index + 1)}"
  machine_type = "${var.type_machine}"
  zone         = "${var.zone}"
  project      = "${var.project_id}"
  tags = ["", ""]

  boot_disk {
    initialize_params {
      image = "${var.image}"
      size  = "30"
      type  = "pd-ssd"
    }
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.default.self_link
    network_ip = google_compute_address.internal[count.index].self_link          
  }
}