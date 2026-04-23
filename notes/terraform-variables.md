# Terraform Variables

## Input Variables
Input variables allow you to customize aspects of Terraform modules without altering the module's own source code.

### Example
```hcl
variable "environment" {
  default = "dev"
  type    = string
}
```

To reference: `var.environment`

## Output Variables
Output variables make information about your infrastructure available on the command line and can be queried easily.

### Example
```hcl
output "instance_ip" {
  value = aws_instance.example.public_ip
}
```

Use `terraform output` to display output variables.

## Locals
Locals are immutable (cannot be changed) and are used to derive values from variables. Useful for reusability and quick changes, such as tags.

### Example
```hcl
locals {
  common_tags = {
    Environment = "dev"
    Owner       = "rohan"
  }

  instance_name = "${var.instance_type}-server"  # Derived from variables
}
```

## Multiple Values in Variables
You can define variables with multiple values using maps or lists.

### Example
```hcl
variable "instance_types" {
  type = map(string)
  default = {
    dev  = "t2.micro"
    prod = "t3.large"
  }
}
```

## Variable Precedence
1. CLI flags (`-var`, `-var-file`)
2. `*.auto.tfvars` / `terraform.tfvars.json` (auto-loaded)
3. `terraform.tfvars`
4. Environment variables (`TF_VAR_*`)
5. Default values in variable block

## Type Constraints
Terraform supports various type constraints for variables to ensure proper data types.


Terraform Variables: variables.tf vs terraform.tfvars

1. variables.tf (Variable Declaration)
-------------------------------------
Purpose:
- Defines variables (name, type, description, default)

Example:
variable "region" {
  description = "AWS region"
  type        = string
}

Think of it as:
"What inputs does my Terraform configuration need?"

-----------------------------------------------------

2. terraform.tfvars (Variable Values)
-------------------------------------
Purpose:
- Assigns values to variables defined in variables.tf

Example:
region = "us-east-1"

Think of it as:
"What values am I using for this setup?"

-----------------------------------------------------

3. How They Work Together
-------------------------
variables.tf → defines variable
terraform.tfvars → provides value

Used in code like:
provider "aws" {
  region = var.region
}

-----------------------------------------------------

4. Real-World Usage (Best Practice)
----------------------------------
Use both files together.

Typical structure:
variables.tf        → variable definitions
terraform.tfvars    → default values
dev.tfvars          → dev environment values
prod.tfvars         → production values

Run with:
terraform apply -var-file="dev.tfvars"

-----------------------------------------------------

5. Common Mistakes
-----------------
- Putting values inside variables.tf
- Hardcoding values in .tf files
- Using tfvars without defining variables

-----------------------------------------------------

6. Key Takeaway
---------------
variables.tf   = structure/schema
terraform.tfvars = actual values/data