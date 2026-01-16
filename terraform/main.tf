resource "google_project_service" "services" {
  for_each = toset([
    "cloudresourcemanager.googleapis.com",
    "container.googleapis.com",
    "compute.googleapis.com",
    "artifactregistry.googleapis.com",
    "iam.googleapis.com",
  ])
  project = var.project_id
  service = each.value
}

resource "google_artifact_registry_repository" "repo" {
  depends_on   = [google_project_service.services]
  location     = var.region
  repository_id = var.artifact_repo_name
  description  = "Artifact Registry for static website images"
  format       = "DOCKER"
}

resource "google_container_cluster" "primary" {
  depends_on = [google_project_service.services]
  name       = var.cluster_name
  location   = var.zone

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-np"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
