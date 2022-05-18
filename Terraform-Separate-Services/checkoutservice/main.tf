terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.15.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
provider "google" {
  project="nachiket-devops"
  region="us-central1"
  zone = "us-central1-a"
}

data "kubectl_file_documents" "docs" {
    content = file("checkoutservice.yaml")
}

resource "kubectl_manifest" "test" {
    
    for_each  = data.kubectl_file_documents.docs.manifests
    yaml_body = each.value
}