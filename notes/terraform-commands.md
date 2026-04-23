# Terraform Commands

## Basic Commands
- `terraform init`: Initializes the Terraform working directory., it will initialize the statefile , but then wont overwite anything onto the remote file , it will only do that when we do apply
- `terraform validate`: Validates the Terraform configuration files.
- `terraform plan`: Checks the state differences between local configuration and the environment.
- `terraform apply`: Makes API calls to apply changes (requires authorization).
- `terraform destroy`: Destroys the infrastructure.

You can install Terraform auto-complete to help run commands automatically.