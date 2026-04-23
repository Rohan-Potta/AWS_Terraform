In this project we will be dealing with the IAM user managment , between creating a bulk of users and also adding them to said group 

1. We have the sample.csv which has the sample bulk user and then we iterate thrugh them and then pass it out as a map , and then passed to aws_iam_user, 
Note => now that the iam user is managed with terraform state , when we destroy they also get destroyed 
2. then we create the groups and based on the job title we can pass it through the if condition and place them in the respective group.

