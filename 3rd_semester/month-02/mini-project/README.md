![integration](./images/Ansible_and_Terraform_Integration.png)

In this article, I will show you how to provision and a staeless web application using Terraform and Ansible

* Prerequsites
To follow this article you will need:
  * The Terraform CLI installed
  * The AWS CLI installed
  * Git installed
  * AWS account and associated credentials that allow you to create resources
  * A key pair on AWS
  * An SSL public certificate on AWS

 Note: I am also assuming you have basic to intermediate knowledge of AWS, Terraform and Ansible.

To use your IAM credentials to authenticate the Terraform AWS provider, set the `AWS_ACCESS_KEY_ID` and secret key environment variables by running the following commands, we'll be using this later.

```php
export AWS_ACCESS_KEY_ID="insert your AWS ACCESS KEY here"
```

```php
export AWS_SECRET_ACCESS_KEY="insert your AWS SECRET KEY here"
```

_ Tip: <span> If you don't have access to IAM user credentials, use another authentication method described in the AWS provider documentation here ![AWS IAM doc](https://aws.com). <span>

This tutorial will only provision resources that qualify under the <bold>AWS free tier<bold>. While following it please be sure that your AWS account qualifies for free tier resources, as I'll not responsible for any charges that you may incur.


## Main Project structure

First of all, don’t put everything in one file, you need to have a project folder structure for code reusability, code sharing, code maintenance, and code clarity. A typical Terraform folder structure will look like the following. Terraform has also made things easy for us by providing what we call Terraform modules, modules are basically reusable pieces of code just like functions or libraries.

By the end of this project, our terraform directory would look like the image below

## Main Project structure

![project structure](./images/mini_project_dir_structure.png)

## Terraform Directory structure

![project structure](./images/terraform_dir_structure.png)

## Ansible Directory structure

![project structure](./images/ansible_dir_structure.png)

###### Note: 
1. All files in your Terraform directory using the .tf file format will be automatically loaded during operations.
2. This porject deploys automatically to the us-east-1 region you can change this to whatever region is closer to you inorder to address latency issues

### TO Deploy this project first 

Clone this repo

```php
git clone https://github.com/philemonnwanne/altschool-cloud-exercises.git
```

cd into the terraform directory and run terraform init

then run terraform plan to know what chnages will be made to your AWS

terraform apply -auto-approve

Don't forget to run terraform destroy when you're done to clean up


VIEW MY DEPLOYMENT

https://terraform-test.philemonnwanne.me/