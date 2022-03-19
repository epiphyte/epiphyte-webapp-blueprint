/*
Copyright (c) 2021 Epiphyte LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
/*
Author: Fernandez-Alcon, Jose
E-mail: jose@epiphyte.io
*/

provider "aws" {
    profile = "default" //Profile name of the aws profile on ~/.aws/credentials
    region = "us-east-1" //The region where the webapp needs to be deployed
}

# Where to store the states of the terraform infrastructure
terraform {
	backend "s3" {
        bucket = "blueprint-devops"
        key = "Infrastrucutre"
        region= "us-east-1"
    }
}

# The domain name where the app is going to be hosted example.com
data "aws_route53_zone" "dns_zone" {
  name     =  var.ROOT_DOMAIN
}
