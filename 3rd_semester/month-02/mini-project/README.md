![integration](./images/Ansible_and_Terraform_Integration.png)

* Prerequsites
To deploy this project, you'll need:
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

Tip: <span> If you don't have access to IAM user credentials, use another authentication method described in the AWS provider documentation.</span>

Warning: This tutorial will only provision resources that qualify under the <bold>AWS free tier<bold>. While following it please be sure that your AWS account qualifies for free tier resources, as I'll not responsible for any charges that you may incur.

###### Note: 
  This prooject deploys automatically to the `us-east-1` region you can change this to whatever region is closer to you inorder to avoid latency issues.

### TO Deploy this project first 

Clone this repo

```php
git clone https://github.com/philemonnwanne/altschool-cloud-exercises.git
```


cd into the terraform directory and run terraform init

then run terraform plan to know what chnages will be made to your AWS

Deploy terraform config

```php
terraform apply -auto-approve
```

Note: Don't forget to run `terraform destroy` when you're done to clean up


View My Deployment: https://terraform-test.philemonnwanne.me/

IAM User SignIn Link: https://philemonnwanne.signin.aws.amazon.com/console


## Main Project structure

![project structure](./images/mini_project_dir_structure.png)

## Terraform Directory structure

![project structure](./images/terraform_dir_structure.png)

## Ansible Directory structure

![project structure](./images/ansible_dir_structure.png)