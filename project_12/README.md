In this project we deal with a 3-tier project and goes to IGW -> external ALB-> Splits it across the availability zones 
Frontend ec2 -> alb (internal) -> backend ec2 -> RDS
and each in their own private subnet and then across various availablity zones 
and the ec2 also have their own Auto Scaling group with a rule sets 
NAT gateway is a one way communication so that the private subnets have access to internet

The EC2 has docker containers and running the docker image done via NAT gateway 

Route Table is , server to nat gateway and then gateway to igw , and then sent back 
1 NAT per availability zone 

Public Subnet (NAT lives here) route 
0.0.0.0/0 → IGW


Private Subnet
0.0.0.0/0 → NAT Gateway


you do NOT explicitly create a route like:
NAT Gateway → Internet Gateway

Why?

Because:
Route tables are attached to subnets, NOT to resources like NAT Gateway
NAT Gateway uses the subnet’s route table automatically

Best Practice :
1 Route table for public subnets
x route tables for pirvate subnet per availiability zone , unless the need comes , that different rules for different subnets in the same az


