variable "profile" { default = "default" }

provider "aws" {
  region  = "ap-northeast-1"
  profile = var.profile
}
