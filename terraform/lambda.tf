module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name          = "dev-http-${terraform.workspace}"
  description   = "HTTP API Gateway"
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  create_api_domain_name = false

  # Routes and integrations
  integrations = {
    "GET /api/hello" = {
      lambda_arn             = module.lambda_function_get_hello.lambda_function_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
      request_templates = {
        "application/json" = ""
      }
      authorization_type = "CUSTOM"
      authorizer_key     = "authorizer"
    },
    "POST /api/hello" = {
      lambda_arn             = module.lambda_function_post_hello.lambda_function_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
      request_templates = {
        "application/json" = ""
      }
      authorization_type = "CUSTOM"
      authorizer_key     = "authorizer"
    }
  }

  authorizers = {
    "authorizer" = {
      authorizer_type                   = "REQUEST"
      authorizer_uri                    = module.lambda_function_authorizer.lambda_function_invoke_arn
      identity_sources                  = ["$request.header.Authorization"]
      name                              = "authorizer"
      authorizer_payload_format_version = "2.0"
      enable_simple_responses           = true
    }
  }

  tags = {
    workspace = terraform.workspace
  }
}

module "lambda_function_get_hello" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "get-hello-${terraform.workspace}"
  description   = "lambda function"
  handler       = "handler.getHello"
  runtime       = "python3.8"

  source_path = "../back/hello"

  publish = true

  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service    = "apigateway"
      source_arn = "${module.api_gateway.apigatewayv2_api_execution_arn}/*/*"
    }
  }

  tags = {
    workspace = terraform.workspace
  }
}

module "lambda_function_post_hello" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "post-hello-${terraform.workspace}"
  description   = "lambda function"
  handler       = "handler.postHello"
  runtime       = "python3.8"

  source_path = "../back/hello"

  publish = true

  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service    = "apigateway"
      source_arn = "${module.api_gateway.apigatewayv2_api_execution_arn}/*/*"
    }
  }

  tags = {
    workspace = terraform.workspace
  }
}

module "lambda_function_authorizer" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "authorizer-${terraform.workspace}"
  description   = "lambda authorizer"
  handler       = "handler.auth"
  runtime       = "python3.8"

  source_path = "../back/authorizer"

  publish = false

  tags = {
    workspace = terraform.workspace
  }
}
