Hosting a Static Website and also using the CLoudfront

We will be storing the website files inside the S3 Bucket 

Using cloudfron allows us to use edge-location , making sure there is no publically accessible s3 bucket etc
This allows for caching and less api calls etc


1. initialize the provider and the backend.tf
2. Created a s3 bucket and created an access_policy to not allow any public access
3. created an origin access control so that only cloudfront can access it 
4. create an s3 bucket policy using the aws policy generator 
5. we created a s3_object and this is so that we can upload the files for the website and this is done using a for loop to iterate over all the files in the folder

"""
  for_each = fileset("${path.module}/www", "**/*")

  bucket = aws_s3_bucket.s3_bucket.id
  key    = each.value
  source = "${path.module}/www/${each.value}
"""
And before this we also create  function so that we upload the correct extention based on HTLM, CSS and so on

6. then we create the said cloudfront distribution 
7. add the cloudfront url in the outputs so that we can quickly see out application