In this project we will be explaining about CICD for IAC terraform via github actions and then it passes through a trivy for security check and the TFlint 

we have 3 env , dev,test,main each in different branches

s3 bucket for the remote state file

for the pipeline to run github will need access to our secrets keys and stuff for aws   

Terraform Plan -out (Important for CI/CD)
terraform plan -out=tfplan saves the execution plan to a file.
This file contains the exact changes Terraform intends to make.
Why use -out?
Ensures consistency between plan and apply
Prevents Terraform from recalculating changes during apply
Avoids unexpected differences due to:
Code changes
State changes
Concurrent deployments
Without -out
terraform apply will:
Re-run the plan internally
Possibly produce different results than what was reviewed
With -out

You generate a fixed plan:

terraform plan -out=tfplan

Then apply exactly that plan:

terraform apply tfplan




How to apply ONLY the saved plan

Generate the plan:

terraform plan -out=tfplan

Apply using the saved plan file:

terraform apply tfplan
This ensures Terraform does NOT recalculate anything
It strictly follows the saved execution plan