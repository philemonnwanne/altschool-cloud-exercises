NOTE: 
nginx is available in Amazon Linux Extra topic "nginx1"

To use, run
# sudo amazon-linux-extras install nginx1

1. update apt or yum repo
2. install nginx package
3. start nginx service
4. copy the stateless application code from github
5. 
 Create VPC: vpc-0ceb27953ab4046b9
 Enable DNS hostnames
 Enable DNS resolution
 Verifying VPC creation: vpc-0ceb27953ab4046b9  
 Create S3 endpoint: vpce-0c41b7ae3af393834  
 Create subnet: subnet-02f86b773c91ab649  
 Create subnet: subnet-0c08a5b3719745fb7  
 Create subnet: subnet-09aaaf462462d77ec  
 Create subnet: subnet-010ef7f7e7fe9b439  
 Create internet gateway: igw-0f660d1d3269eba73  
 Attach internet gateway to the VPC
 Create route table: rtb-00368a3cfa9246a4a  
 Create route
 Associate route table
 Associate route table
 Create route table: rtb-0c4fb5afc07deedf7  
 Associate route table
 Create route table: rtb-098876a5e0f5fd4d1  
 Associate route table
 Verifying route table creation
 Associate S3 endpoint with private subnet route tables: vpce-0c41b7ae3af393834  


<!-- Deploy 2 bastion hosts in each public availability zone for redundancy -->

aws_nat_instance_id - ami-04027ecc3f40c1801


eval `ssh-agent -s`

ssh-add my-key

ssh -A -i "my-key.pem" ec2-user@ec2-44-197-229-45.compute-1.amazonaws.com 

cd portfolio/
cd && rm -R portfolio/ && cp -R /vagrant/portfolio/ . && cd portfolio/
ansible-playbook -i inventory/hosts playbook.yml

Note: Dynamic inventory file must be named aws_ec2.yml 