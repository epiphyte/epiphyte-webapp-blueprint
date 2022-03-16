## Cloud Resource Tagging Variables
 
#Project tag name
variable "PROJ" {
    type = string
}

#Resource contact name
variable "CONTACT" {
    type = string
}

#Project status
variable "STATUS" {
    type = string
}

### Deployment Specific Variables ========================== 

#AWS Region
variable "AWS_REGION" {
  type = string
  default = "us-east-1"
}

#AWS Profile
variable "AWS_PROFILE" {
  type = string
}

#Role Name
variable "LAMBDA_ROLE_NAME" {
  type = string
  default = "public_api_role"
}

#Role Name
variable "LAMBDA_POLICY_NAME" {
  type = string
  default = "public_api_policy"
}

variable "FRONTEND_DOMAIN" {
  type = string
}

variable "USER_PROFILES_BUCKET_NAME" {
  type = string
}

variable "ROOT_DOMAIN" {
	type = string
}

variable "API_DOMAIN" {
	type = string
}

variable "WILDCARD_CERT_NAME" {
  type = string
}

### DynamoDB Configuration =================================

#Table Name
variable "USER_PROFILES_TABLE_NAME" {
  type = string
}


### Cognito Configuration =================================
#User Pool Name
variable "COGNITO_USER_POOL_NAME" {
  type = string
}