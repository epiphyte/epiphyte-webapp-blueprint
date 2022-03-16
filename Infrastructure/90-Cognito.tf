

resource "aws_cognito_user_pool" "pool" {
  name = var.COGNITO_USER_POOL_NAME

    username_attributes = ["email"]
    
    username_configuration {
      case_sensitive = false
    }

    /** Required Standard Attributes*/
    schema {
      attribute_data_type = "String"
      mutable = true
      name = "email"
      required = true
      string_attribute_constraints {
        min_length = 1
        max_length = 2048
      }
    }

    schema {
      attribute_data_type = "String"
      mutable = true
      name = "given_name"
      required = true
      string_attribute_constraints {
        min_length = 1
        max_length = 2048
      }
    }

    schema {
      attribute_data_type = "String"
      mutable = true
      name = "family_name"
      required = true
      string_attribute_constraints {
        min_length = 1
        max_length = 2048
      }
    }

    /** Custom Attributes */
    schema {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "PersonalInfo"
      required                 = false
      string_attribute_constraints {
        min_length = 1
        max_length = 2048
      }
    }

    schema {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "Role"
      required                 = false
      string_attribute_constraints {
        min_length = 1
        max_length = 2048
      }
    }

}

output "user_pool_id" {
  value = aws_cognito_user_pool.pool.id
}