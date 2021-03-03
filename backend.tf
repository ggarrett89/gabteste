terraform {
    backend "s3" {
        region = "us-east-2"
        bucket = "bucket-k8s-devops"
        encrypt = "true"
        key = "terraform.tfstate"
    }
}
