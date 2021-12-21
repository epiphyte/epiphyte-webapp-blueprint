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

## User Profile
resource "aws_dynamodb_table" "user-profile-table" {
  name           = var.USER_PROFILES_TABLE_NAME
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "Email"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "Email"
    type = "S"
  }


	tags = {
		PROJ = var.PROJ
		CONTACT = var.CONTACT
		STATUS = var.STATUS
	}
}

