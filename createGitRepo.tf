terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}


provider "github" {
}

/*
resource "github_repository" "example" {
  name        = "2024_terraform"
  description = "keep your terraform work here"
  visibility = "public"
}
*/