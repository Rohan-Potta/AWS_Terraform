# Project Structure

In the backend.tf we cannot use locals or varibales inside it , so the best practice is to use somethine like a config file and pass that while initializing it 

name the file config.json
{
  "bucket": "s3-terraform-backend-hyderabad",
  "key": "project_01/terraform.tfstate",
  "region": "us-east-1"
}

terraform init -backend-config=config.json

## Basic Structure
```
terraform-project/
├── backend.tf           # Backend configuration
├── provider.tf          # Provider configurations
├── variables.tf         # Input variable definitions
├── locals.tf            # Local value definitions
├── main.tf              # Main resource definitions
├── vpc.tf               # VPC-related resources
├── security.tf          # Security groups, NACLs
├── compute.tf           # EC2, Auto Scaling, etc.
├── storage.tf           # S3, EBS, EFS resources
├── database.tf          # RDS, DynamoDB resources
├── outputs.tf           # Output definitions
├── terraform.tfvars     # Variable values
└── README.md            # Documentation
```

## Advanced File Organization Patterns

### Environment-Specific Structure
```
environments/
├── dev/
│   ├── backend.tf
│   ├── terraform.tfvars
│   └── main.tf
├── staging/
│   ├── backend.tf
│   ├── terraform.tfvars
│   └── main.tf
└── production/
    ├── backend.tf
    ├── terraform.tfvars
    └── main.tf

modules/
├── vpc/
├── security/
└── compute/

shared/
├── variables.tf
├── outputs.tf
└── locals.tf
```

### Service-Based Structure
```
infrastructure/
├── networking/
│   ├── vpc.tf
│   ├── subnets.tf
│   └── routing.tf
├── security/
│   ├── security-groups.tf
│   ├── nacls.tf
│   └── iam.tf
├── compute/
│   ├── ec2.tf
│   ├── autoscaling.tf
│   └── load-balancers.tf
├── storage/
│   ├── s3.tf
│   ├── ebs.tf
│   └── efs.tf
└── data/
    ├── rds.tf
    ├── dynamodb.tf
    └── elasticache.tf
```
```