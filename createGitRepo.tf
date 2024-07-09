terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}


provider "github" {
    token = "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"   
}

/*
resource "github_repository" "example" {
  name        = "2024_terraform"
  description = "keep your terraform work here"
  visibility = "public"
}
*/