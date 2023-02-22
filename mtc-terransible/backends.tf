terraform {
  cloud {
    organization = "mtc-terransible-svk"

    workspaces {
      name = "mtc-terransible"
    }
  }
}