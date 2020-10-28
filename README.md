# Kata No. 1

## Objective 

Build a VPC with 1 Public Subnet and launch an EC2 instance in it with a Security Group allowing
SSH.

## Steps

These are the steps I took to learn while I created it:

1. Create a VPC
2. Create a public Subnet in the VPC
3. Create an Internet Gateway and attach it to the VPC
4. Create a Route Table and connect the Subnet with the Internet Gateway
5. From the AWS Console launch an EC2 instance in the public subnet and create a security group
   allowing SSH from anywhere OR your specific IP. 
6. Test the EC2 by connecting to it via SSH.
7. Destroy the EC2 instance from the AWS Console.
8. Create an EC2 instance
9. Create a Security Group allowing SSH inbound traffic to the EC2 instance
10. Test the EC2 and Security Group by connecting to it via SSH
11. Destroy all of the infrastructure

## Comments

There were many challenges along the way that required reading the AWS and Terraform documentation.
One usually lands on the correct place by making a google search with "aws terraform resource
<resource name>", i.e. "aws terraform resource vpc".
