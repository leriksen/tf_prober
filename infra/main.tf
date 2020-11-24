terraform {
  backend "remote" {
    organization = "tf_rel_path"

    workspaces {
      name = "prober"
    }
  }
}

provider "null" {
  version = "~> 3.0"
}

resource "null_resource" "bump" {
  triggers = {
    now = timestamp()
  }
  provisioner "local-exec" {
    command = "pwd && ls -al /terraform/modules"
  }
}

module "data" {
  source = "../modules/static_data"
}

output "data" {
  value = module.data.name
}

