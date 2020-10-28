# Kata No. 2

## Objective

Expand the VPC from Kata No. 1 to include:
- 1 Private Subnet
- 1 EC2 Instance

Constraints:
The private instance should only be reachable by the Bastion Host through SSH
The private instance should be able to ping the internet

## Comments

Gotchas:
- Specific Ingress and Egress rules
- Cycle error on Security Groups
- SSH Keychain and Agent Forwarding
