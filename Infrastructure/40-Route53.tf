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

//Updates the CNAME record for the application frontend.
resource "aws_route53_record" "frontend_cname_record" {
  zone_id  = data.aws_route53_zone.dns_zone.zone_id
  name = var.FRONTEND_DOMAIN
  type = "CNAME"
  records  = [aws_cloudfront_distribution.frontend_cloudfront.domain_name]
  ttl   = 300
}

resource "aws_acm_certificate" "ssl_certificate" {
  domain_name       = var.FRONTEND_DOMAIN
  subject_alternative_names = [ var.WILDCARD_CERT_NAME ] 
  validation_method = "DNS"

  tags = {
	PROJ = var.PROJ
	CONTACT = var.CONTACT
	STATUS = var.STATUS
  }

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.ssl_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.dns_zone.zone_id
}

resource "aws_acm_certificate_validation" "certificate_validation" {
  certificate_arn         = aws_acm_certificate.ssl_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}