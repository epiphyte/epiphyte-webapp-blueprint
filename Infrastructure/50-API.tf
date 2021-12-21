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
## API Gateway Domain Name
##

resource "aws_api_gateway_domain_name" "api_getway_domain_name" {
  depends_on = [ aws_acm_certificate.ssl_certificate ]
  domain_name              = var.API_DOMAIN
  regional_certificate_arn =  aws_acm_certificate.ssl_certificate.arn
  security_policy          = "TLS_1_2"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}