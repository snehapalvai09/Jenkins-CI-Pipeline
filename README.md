
##############################################################################
# Use the Jenkinsfile as CI/CD Pipeline  
##############################################################################

## Step-1:Install Jenkins
On local machine, ensure Jenkins and all other required plugins like git, docker, terraform etc are installed.

## Step-2:Create a jenkins pipeline, which will create Docker container
In first stage of the pipeline, it will pull a standard centos 7 docker image and installs Tomcat & its associated dependencies which will create an custom image with all changes and Pushed the custom image to custom docker repo.

## Step-3: Deploy to AWS using terraform
In another stage of the same pipeline, it will create amazon linux EC2 server by executing terraform commands from the pipeline
```
terraform init
terraform plan
terraform apply
```
and while creating the ec2 server, in User Data section it will download the custom docker image from the docker repo and running that image in the server on port 8080.
