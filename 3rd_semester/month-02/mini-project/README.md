### Terraform's configuration language is declarative, meaning that it describes the desired end-state for your infrastructure, in contrast to procedural programming languages that require step-by-step instructions to perform tasks. Terraform providers automatically calculate dependencies between resources to create or destroy them in the correct order.


* Prerequsites
To follow this article you will need:
  * The Terraform CLI installed
  * The AWS CLI installed
  * Git installed
  * AWS account and associated credentials that allow you to create resources

To use your IAM credentials to authenticate the Terraform AWS provider, set the `AWS_ACCESS_KEY_ID` and secret key environment variables by running the following commands, we'll be using this later.

```php
export AWS_ACCESS_KEY_ID=
```

```php
export AWS_SECRET_ACCESS_KEY=
```

_ Tip: <span> If you don't have access to IAM user credentials, use another authentication method described in the AWS provider documentation. <span>

This tutorial will only provision resources that qualify under the <bold>AWS free tier<bold>. While following it please be sure that your AWS account qualifies for free tier resources, as I'll not responsible for any charges that you may incur.

## Write configuration
The set of files used to describe infrastructure in Terraform is known as a Terraform configuration. You will write your first configuration to define a single AWS EC2 instance.

Each Terraform configuration must be in its own working directory. We will be using terraform modules to .....

Create a directory for your configuration.

 ```php
 mkdir terraform-ansible
 ```

Change into the directory.

 ```php
 cd terraform-ansible
 ```


Create a file to define your infrastructure.

```php
touch main.tf
```

Open `main.tf` in your text editor, paste in the configuration below, and save the file.

```go
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.49.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.3.0"
    }
  }
  required_version = ">= 1.1.0"
}

/* this block configures the AWS provider */
provider "aws" {
  region = var.aws_region
}
```