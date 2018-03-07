provider "google" {
  project     = "${var.gce_project}"
  region      = "${var.gce_region}"
}


resource "google_container_cluster" "k8scluster" {
  name               = "${var.env}-kubernetes-cluster"
  zone               = "${var.gce_region}-a"

  additional_zones = [
    "${var.gce_region}-b",
    "${var.gce_region}-c",
  ]

  master_auth {
    username = "${var.kubernetes_username}"
    password = "${var.kubernetes_password}"
  }

  //network = "${google_compute_network.newvpc.self_link}"
  //subnetwork = "${google_compute_subnetwork.newsubnet.name}"

  node_pool = [{
    name = "default-pool"
    node_count= 0
  }]

}

resource "google_container_node_pool" "np" {
  name               = "k8s-node-pool"
  zone               = "${var.gce_region}-a"
  cluster            = "${google_container_cluster.k8scluster.name}"
  node_count         = "${var.initial_node_eachzone}"

  node_config {
    image_type    = "${var.node_image}"
    machine_type  = "${var.node_machine_type}"
    disk_size_gb  = "${var.node_disk_size_gb}"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels {
      env = "${var.env}"
    }

    tags = ["networktag1", "networktag2"]
  }

  autoscaling {
    min_node_count   = "${var.min_node_count}"
    max_node_count   = "${var.max_node_count}"
  }

}

