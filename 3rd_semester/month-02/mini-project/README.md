![integration](./images/Ansible_and_Terraform_Integration.png)


My Deployment: https://terraform-test.philemonnwanne.me/

IAM SignIn Link: https://philemonnwanne.signin.aws.amazon.com/console



* Prerequsites
To deploy this project, you'll need:
  * The Terraform CLI installed
  * The AWS CLI installed
  * Git installed
  * AWS account and associated credentials that allow you to create resources
  * A key pair on AWS
  * An SSL public certificate on AWS

 Note: I am also assuming you have basic to intermediate knowledge of AWS, Terraform and Ansible.


### TO Deploy this project 


Clone this repo

```php
git clone https://github.com/philemonnwanne/altschool-cloud-exercises.git
```


cd into the terraform directory and run 

```php
terraform init
```

 to know what changes terraform will make to your infrastructure run
```php
terraform plan to
```

Deploy terraform config

```php
terraform apply -auto-approve
```

Note: Don't forget to run `terraform destroy` when you're done to clean up
</br>
</br>
</br>

## Main Project structure

![project structure](./images/mini_project_dir_structure.png)

## Terraform Directory structure

![project structure](./images/terraform_dir_structure.png)

## Ansible Directory structure

![project structure](./images/ansible_dir_structure.png)