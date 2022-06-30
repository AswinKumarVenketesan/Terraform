terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "IshaFoundation"

    workspaces {
      name = "ishaservice-eks-ap-south-1"
    }
  }
}
