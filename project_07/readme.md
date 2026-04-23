Policy and Governence 

Policy => Enforcing Rules , example MFA must be enabled to delete the resource, when uploading a file to s3 must be encrypted in transit etc, while creating objects there needs to be tags

Governence => Store logs for audit and governence , this is done by aws config and then stored in aws S3
 

 1. We securely creat s3 bucket , with blocking the public access, creating the policy and all that

2. then we create the policy to ensure the rules , the policy will be in json 