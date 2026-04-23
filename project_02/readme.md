In this project we will be looking at VPC Peering via terraform 

┌─────────────────────────────────────┐       ┌─────────────────────────────────────┐
│     Primary VPC (ap-south-1)         │       │    Secondary VPC (ap-south-2)        │
│     CIDR: 10.0.0.0/16               │       │    CIDR: 10.1.0.0/16                │
│                                     │       │                                     │
│  ┌───────────────────────────────┐  │       │  ┌───────────────────────────────┐  │
│  │  Subnet: 10.0.1.0/24          │  │       │  │  Subnet: 10.1.1.0/24          │  │
│  │  ┌─────────────────────────┐  │  │       │  │  ┌─────────────────────────┐  │  │
│  │  │  EC2 Instance           │  │  │       │  │  │  EC2 Instance           │  │  │
│  │  │  Private IP: 10.0.1.x   │  │  │       │  │  │  Private IP: 10.1.1.x   │  │  │
│  │  └─────────────────────────┘  │  │       │  │  └─────────────────────────┘  │  │
│  └───────────────────────────────┘  │       │  └───────────────────────────────┘  │
│                                     │       │                                     │
│  Internet Gateway                   │       │  Internet Gateway                   │
└─────────────────┬───────────────────┘       └─────────────────┬───────────────────┘
                  │                                             │
                  └───────────────VPC Peering──────────────────┘


Terraform statefile will be created/updated only during apply and not init  

So these are the steps

1. In the provider created two providers with the alias as i will be creating resources in different regions 
2. Create the ssh keys for the ec2 in the respective regions , which can be mentioned in tfvars file
3. Create the VPC and the subnets
4. Add the routes in the route table and ensure there is the VPC Peering enabled
5. And then we can create the ec2 instance and attach them to respective vpc and subnets 
6. and then we add the ec2 user data with the apache and then there we display the CIDR and the Host Name 
