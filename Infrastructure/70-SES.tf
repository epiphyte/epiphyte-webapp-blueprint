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


## ===================================================================================================================================
##
## Simple Email Service Configuration
##

resource "aws_ses_domain_identity" "email_domain" {
  domain = var.ROOT_DOMAIN
}

resource "aws_route53_record" "amazonses_verification_record" {
  zone_id = data.aws_route53_zone.dns_zone.zone_id
  name    = "_amazonses.${aws_ses_domain_identity.email_domain.id}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.email_domain.verification_token]
}


## Mail from domain
resource "aws_ses_domain_mail_from" "email_domain" {
  domain           = aws_ses_domain_identity.email_domain.domain
  mail_from_domain = "mail.${aws_ses_domain_identity.email_domain.domain}"
}

## Route53 MX record
resource "aws_route53_record" "ses_domain_mail_from_mx" {
  zone_id = data.aws_route53_zone.dns_zone.id
  name    = aws_ses_domain_mail_from.email_domain.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.us-east-1.amazonses.com"] # Change to the region in which `aws_ses_domain_identity.example` is created
}

## Route53 TXT record for SPF
resource "aws_route53_record" "ses_domain_mail_from_txt" {
  zone_id = data.aws_route53_zone.dns_zone.id
  name    = aws_ses_domain_mail_from.email_domain.mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com -all"]
}

##
## Email addresses
##
resource "aws_ses_email_identity" "info" {
  email = "info@clinicaltrials.im"
}