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

//CDN for the application frontend
resource "aws_cloudfront_distribution" "frontend_cloudfront" {
	depends_on = [ aws_acm_certificate.ssl_certificate ]
	enabled         = true
	is_ipv6_enabled = true
	default_root_object = "index.html"

	tags = {
		PROJ = var.PROJ
		CONTACT = var.CONTACT
		STATUS = var.STATUS
	}

  custom_error_response {
      error_caching_min_ttl = 0
      error_code = 404
      response_code = 200
      response_page_path = "/index.html"
  }

	origin {
		domain_name = aws_s3_bucket.frontend_bucket.bucket_domain_name
		origin_id   = var.FRONTEND_DOMAIN
	}

	restrictions {
		geo_restriction {
			restriction_type = "none"
		}
	}

	aliases = [var.FRONTEND_DOMAIN]
	viewer_certificate {
		acm_certificate_arn = aws_acm_certificate.ssl_certificate.arn
		ssl_support_method = "sni-only"
		minimum_protocol_version       = "TLSv1.2_2019"
	}


	default_cache_behavior {
		target_origin_id = var.FRONTEND_DOMAIN

		allowed_methods = ["GET", "HEAD"]
		cached_methods  = ["GET", "HEAD"]

		forwarded_values {
			query_string = false

			cookies {
				forward = "none"
			}
		}

		viewer_protocol_policy = "redirect-to-https"
		min_ttl                = 0
		default_ttl            = 3600
		max_ttl                = 86400
	}

}