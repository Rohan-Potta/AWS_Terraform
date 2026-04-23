tf import => this is used to import resources via the console and used to migrate via iac and then updated on the tfstate file
terraformer => this gets the resource from the console into iac code, but not good and modular
AWS2TF => AWS to terraform 3rd party and generated the terraform file 


If we delete the terraform state , we can use this terraform import method.

data sources → read existing infrastructure; A data block is strictly read-only.
terraform import → bring existing infrastructure under Terraform management


to import a resource 
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}
terraform import aws_vpc.example vpc-12345 ; the last is vpc id