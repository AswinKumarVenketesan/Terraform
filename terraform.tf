terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "Aswin"

    workspaces {
      name = "aswin-eks-ap-south-1"
    }
  }
}
