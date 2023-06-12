terraform {
  required_providers {
    vercel = {
      source = "vercel/vercel"
      version = "~> 0.3"
    }
  }
}

provider "vercel" {
  api_token = <YOUR_TOKEN>
}

resource "vercel_project" "vercel-terraform" {
  name      = "vercel-terraform"
  framework = "nextjs"
  git_repository = {
    type = "github"
    repo = "FelixWaweru/vercel-terraform"
  }
}

data "vercel_project_directory" "vercel-terraform" {
  path = "."
}

resource "vercel_deployment" "vercel-terraform" {
  project_id  = vercel_project.vercel-terraform.id
  files       = data.vercel_project_directory.vercel-terraform.files
  path_prefix = "."
  production  = true
  ignore_command = "if [ '$VERCEL_GIT_COMMIT_REF' != 'ignore-build' ]; then exit 1; else exit 0; fi"
}