/*
Copyright (c) 2021-2022 Epiphyte LLC

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

/**
 * Bucket for storing the application frontend
 */
resource "aws_s3_bucket" "frontend_bucket" {
  bucket = var.FRONTEND_DOMAIN

  tags = {
		PROJ = var.PROJ
		CONTACT = var.CONTACT
		STATUS = var.STATUS
	}
}

resource "aws_s3_bucket_acl" "frontend_bucket" {
  bucket = aws_s3_bucket.frontend_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "frontend_bucket" {
  bucket = aws_s3_bucket.frontend_bucket.id
  policy = file("policies/frontend_bucket_policy.json")
}

resource "aws_s3_bucket_website_configuration" "frontend_bucket" {
  bucket = aws_s3_bucket.frontend_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}


output "frontend_website_endpoint" {
  value = aws_s3_bucket.frontend_bucket.website_endpoint
}


/**
 * Bucket for storing user profile info (Avatars, etc)
 */
resource "aws_s3_bucket" "user_profiles_bucket" {
  bucket = var.USER_PROFILES_BUCKET_NAME

  tags = {
		PROJ = var.PROJ
		CONTACT = var.CONTACT
		STATUS = var.STATUS
	}
}

