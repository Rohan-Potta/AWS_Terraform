# Terraform Notes

This repository contains notes on Terraform organized into separate files for easier access.

## Sections

- [IaC Introduction](iac-introduction.md) - Overview of Infrastructure as Code, advantages, and Terraform files.
- [Terraform Commands](terraform-commands.md) - Basic Terraform commands and tips.
- [Terraform Providers](terraform-providers.md) - Details on providers, versioning, and operators.
- [State File Management](state-file-management.md) - Managing Terraform state files and best practices.
- [State Issues](state-issues.md) - Common problems and solutions related to Terraform state.
- [Terraform Variables](terraform-variables.md) - Input variables, outputs, locals, and precedence.
- [Project Structure](project-structure.md) - Recommended project structures and organization patterns.

Based on Values:
Primitive => String , Boolean , number
Complex => List , set , MAP, Object,Touple
Others => NULL, Any(this is any type of variable)

List => Basically an array
type = list(string)
["10.0.0.0/8","10.0.0.1/16"]

with set we cannot have duplicates 

set => Basically an array
type = set(string)
["us-east-1","us-west-1"]

cant be called directly like in list , we need to convert it to a list and then call it 
region = tolist(var.allowed_regions)[0]

Map => Key Value Pair
variable "tags" {
  type = map(string)

  default = {
    Environment = "dev"
    Project     = "healthcare-app"
    Owner       = "rohan"
  }
}
tags = var.tags

Touple => Allows you to have multiple datatypes , these are accessed just like in a list 
variable "example_tuple" {
  type = tuple([string, number, bool])

  default = ["rohan", 25, true]
}


Object => 
variable "server_config" {
    type = object({
        name = string
        instance_type = string
        monitoring = bool
        storage_gb = number
        backup_enabled = bool
    })
    description = "Complete server configuration object"
    default = {
        name = "web-server"
        instance_type = "t2.micro"
        monitoring = true
        storage_gb = 20
        backup_enabled = false
    }
    # KEY BENEFITS:
    # - Self-documenting structure
    # - Type safety for each attribute
    # - Access: var.server_config.name, var.server_config.monitoring
    # - All attributes must be provided (unless optional)
}

Meta Arguments
Meta-arguments in Terraform are special arguments that you can use inside resources (and modules) to control how Terraform behaves, rather than what infrastructure it creates.

Normal arguments → define the resource
Meta-arguments   → control Terraform’s behavior on that resource

count - Create multiple resources with numeric indexing
resource "aws_instance" "app" {
  count         = 3
  ami           = "ami-12345"
  instance_type = "t2.micro"
}
aws_instance.app[0]
aws_instance.app[1]
aws_instance.app[2]

for_each - Create multiple resources with maps/sets
resource "aws_s3_bucket" "example" {
  for_each = toset(["bucket1", "bucket2", "bucket3"])
  bucket   = each.value
}
here we dont have to explicitly mention the count 


depends_on - Explicit resource dependencies, A depends on B , so that we can tell which resources to create first 
resource "aws_s3_bucket" "dependent" {
  bucket = "my-bucket"
  
  depends_on = [aws_s3_bucket.primary]
}
lifecycle - Control resource creation and destruction behavior
resource "aws_s3_bucket" "example" {
  bucket = "my-bucket"
  
  lifecycle {
    prevent_destroy       = true  # Prevent accidental deletion
    create_before_destroy = true  # Create new before destroying old
    ignore_changes        = [tags] # Ignore changes to tags
  }
}
provider - Use alternate provider configurations
resource "aws_s3_bucket" "example" {
  provider = aws.west  # Use alternate provider
  bucket   = "my-bucket"
}

Lifecycle Rules Explained:

create_before_destroy - Zero-downtime deployments
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type

  lifecycle {
    create_before_destroy = true
  }
}

prevent_destroy - Protect critical resources, no destroying 
resource "aws_s3_bucket" "critical_data" {
  bucket = "my-critical-production-data"

  lifecycle {
    prevent_destroy = true
  }
}

ignore_changes - Handle external modifications
resource "aws_autoscaling_group" "app_servers" {
  # ... other configuration ...
  
  desired_capacity = 2

  lifecycle {
    ignore_changes = [
      desired_capacity,  # Ignore capacity changes by auto-scaling
      load_balancers,    # Ignore if added externally
    ]
  }
}

replace_triggered_by - Dependency-based replacements
resource "aws_security_group" "app_sg" {
  name = "app-security-group"
  # ... security rules ...
}

resource "aws_instance" "app_with_sg" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  lifecycle {
    replace_triggered_by = [
      aws_security_group.app_sg.id  # Replace instance when SG changes
    ]
  }
}

precondition - Pre-deployment validation
resource "aws_s3_bucket" "regional_validation" {
  bucket = "validated-region-bucket"

  lifecycle {
    precondition {
      condition     = contains(var.allowed_regions, data.aws_region.current.name)
      error_message = "ERROR: Can only deploy in allowed regions: ${join(", ", var.allowed_regions)}"
    }
  }
}

postcondition - Post-deployment validation
resource "aws_s3_bucket" "compliance_bucket" {
  bucket = "compliance-bucket"

  tags = {
    Environment = "production"
    Compliance  = "SOC2"
  }

  lifecycle {
    postcondition {
      condition     = contains(keys(self.tags), "Compliance")
      error_message = "ERROR: Bucket must have a 'Compliance' tag!"
    }

    postcondition {
      condition     = contains(keys(self.tags), "Environment")
      error_message = "ERROR: Bucket must have an 'Environment' tag!"
    }
  }
}

Expressions:

Conditional Expressions 
condition ? true_value : false_value
Give true and false


Dynamic Blocks

Generates multiple nested blocks within a resource based on a collection (list or map). Eliminates the need to repeat similar block configurations.

Syntax:

dynamic "block_name" {
    for_each = var.collection
    content {
        # Block configuration using each.key and each.value
    }
}
How it works:
for_each iterates over a list or map
content defines what each block should contain
Access values using block_name.value or block_name.key



Splat Expressions
Extracts attribute values from all elements in a list in a single, concise expression. The [*] operator is the splat operator.

Syntax:

resource_list[*].attribute_name
How it works:

Takes a list of resources/objects
Extracts specified attribute from each element
Returns a new list with just those values


Functions:
We can only use inbuilt functions , cant make the custom functions

Terraform console => This can be used to open a terraform console   

String Functions
lower(), upper(), replace(to replace the said characheter), substr(this is used to create a substring), trim(Removes the space or charachter we want to remove ), split(), join(), chomp(This is used to remove any new line \n , used when we deal with files)

Numeric Functions
abs(absolute value), max(), min(), ceil(), floor(), sum()

Collection Functions
length(), concat(), merge(works on key value pairs ), reverse(), toset(), tolist()

Type Conversion
tonumber(), tostring(), tobool(), toset(), tolist()

File Functions
file(), fileexists(), dirname(), basename()

Date/Time Functions
timestamp(), formatdate(), timeadd()art

Validation Functions
can(), regex(), contains(), startswith(), endswith()

Lookup Functions
lookup(), element(), index()

lookup(map, key, default)
locals {
  instance_types = {
    dev  = "t2.micro"
    prod = "t3.large"
  }
}

instance_type = lookup(local.instance_types, "dev", "t2.nano")


Validation 
variable "env" {
  type = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.env)
    error_message = "Environment must be dev, staging, or prod."
  }
}


Datasource:
For example this is used to get ami-id , instead of hardcoding it 
Fetching for data which already exists , You need to USE something that already exists,
but you are NOT creating it in this Terraform code


data "aws_vpc" "main" {
  default = true
}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}