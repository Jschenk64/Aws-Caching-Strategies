# Lambda.tf
resource "aws_api_gateway_rest_api" "main" {
  name        = "MyAPI"
  description = "API Gateway for my application"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_lambda_function" "my_lambda" {
  function_name    = "my-lambda"
  handler          = "index.handler"
  runtime          = "python3.9"
  role             = aws_iam_role.lambda_exec.arn
  filename         = "./module/lambda/lambda_function.zip"
  source_code_hash = filebase64sha256("./module/lambda/lambda_function.zip")
}


resource "aws_iam_role" "lambda_exec" {
  name = "lambda-exec-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}






