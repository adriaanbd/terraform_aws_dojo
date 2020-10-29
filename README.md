# 3-Tiered AWS Network Layout

Deploys a three (3) tiered network layout in three (3) availability zones (AZs).

## Description

It consists of the following main components inside a VPC with an Internet Gateway, replicated in 3 AZs:
- A Public Subnet with a Bastion Host, a public route table and a NAT Gateway.
- A Private Subnet with an App Host and a private route table.
- A Private Subnet for the Database with nothing inside it.
- A Security Group for each instance, with the following specs:
    1. The Bastion Host allows SSH ingress from anywhere
    2. The Bastion Host allows SSH egress to the App Host's Security Group
    3. The Bastion Host allows ICMP egress for Echo Requests
    4. The App Host allows SSH ingress from the Bastion Host's Security Group
    5. The App Host allows TCP egress over HTTP port 80 to perform updates.
    6. The App Host allows ICMP egress for Echo Requests

## Requirements

You'll need the Terraform CLI and AWS CLI. Please read the corresponding documentation online.

## Getting Started

### Initialize and Deploy

```
$ terraform init && terraform plan
$ terraform apply -auto-approve
```

### Login to Bastion Host

#### Setup SSH Agent

```
$ eval `ssh-agent -s`
```

#### Add SSH Key and check it is added:

```
$ ssh-add -k key.pem
$ ssh-add -L
```

#### Access Bastion Host and Ping

```
$ ssh -A ec2-user@public_ip
$ ping google.com
```

#### Access Private Instance, Ping and Yum

```
$ ssh ec2-user@private_ip
$ ping google.com
$ yum check-updates
```

### Destroy Resources

```
$ terraform destroy -auto-approve
```
