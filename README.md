# Kata No. 3

## Objective

Expand the VPC from Kata No. 2 to include:
- An additional Private Subnet
- Two additional Availability Zone deployments
- Be able to run `yum check-updates` on instances in private subnet

Constraints:
The same constraints for Kata No. 2
The deployments need to be in different Availability Zones

## Comments

With over 600+ lines of code, it is becoming increasingly burdensome to make changes in the right places.

Gotchas:
- Although the CIDR blocks for the private and public subnets should account for 256 ip addresses, minus the first four (4) and last one (1) that AWS reserves, the console shows 249 vailable for the public subnets, 250 for the app layer subnets, and 251 for the data layer subnets.