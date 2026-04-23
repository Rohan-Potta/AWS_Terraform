SO here we are going to build a blue green deployment via the elastic beanstalk.

1. Create an application , zip it and store it , we will need two application , one for green and one for blue 
2. once this is ready we need to create an s3 bucket and upload the application 1 and 2 
3. create the elb scripts , mentioning the vpc and the subnets and also the load balancer type and the auto scaling group 

4. once they are ready create the scripts of terrafrom will bu run 
5. use the command "terraform output swap_command" to get the swap command and paste it to check the swapping 
6. if run and still cant see the changes run a hard refresh (cntrl+shift+R)

