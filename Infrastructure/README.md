
# Epiphyte WebApp Blueprint Infrastructure

These are the Terraform files describing the AWS infrastructure that supports the web application

## Usage

The file ``example.tfvars`` provides and example of the configuration files 
used in this blueprint. 

It is recommended to create two files: ```prod.tfvars``` and ```dev.tfvars``` for
the production environment and the development environment respectively

To initialize the environment:
```make init```

To test the Terraform configuration in development:
```make plan_dev```

To deploy the Terraform configuration in development:
```make deploy_dev```

To destroy everything in development (Use it with care):
```make destroy_dev```

## Main Terraform Components


### 00-Main.tf
Describes the AWS deployment region, the location where the Terraform state is going to be stored 
and the root domain of the new application  

### 20-S3.tf

Specifies the S3 buckets for storing the application frontend and the user
information


### 30-CloudFront.tf

Specification of the content delivery network (CDN) for the web application

### 40-Route53.tf

Configures the DNS to generate the SSL certificates and to point 
the domain names to the right locations.


### 50-API.tf
AWS API gateway configuration.

### 60-DynamoDB.tf

Describes the AWS DynamoDB tables used in the application


### 70-SES.tf
AWS Simple Email Service configuration for user notification such as welcome 
email and password reset.


## TODO

Implement configuration of the AWS Cognito user pools. 
This will be included in file 10-Cognito.tf


Copyright (c) 2021, Epiphyte LLC (https://www.epiphyte.io)

