Multitenancy is a key property of most cloud computing service models, which makes isolation a critical component of most cloud computing security models. Aptible customers often need to explain to their own customers what kinds of isolation they provide, and what kinds of isolation are possible on the Aptible platform.

The [Reference Architecture Diagram](https://www.aptible.com/resources/enclave-reference-architecture-and-division-of-responsibilities/) helps illustrate some of the following concepts.

## Infrastructure
All Aptible resources are deployed using Amazon Web Services. AWS operates and secures the physical data centers that produce the underlying compute, storage, and networking functionality needed to run your apps and databases. 

When you provision an Aptible stack, you can specify the AWS Region where you want to run. An alternate geographic Region stores database backups. Data processing and storage is guaranteed to occur only within the US, for US stacks, and is guaranteed to occur only in the EU, for EU stacks.

When you scale an Aptible app service to two or more containers, the containers will be automatically deployed across multiple AWS Availability Zones in the same Region.

## Network/Stack
An Aptible “stack” is an AWS Virtual Private Cloud provisioned with EC2, ELB, and EBS assets and Aptible platform software. When you provision a dedicated stack on Aptible, you receive your own VPC, meaning you receive your own private and public subnets. 

You can provide network level isolation for your customers by provisioning a separate, isolated Aptible stack for them with a VPC add-on. The new stack will receive its own dedicated VPC and backing resources.

## Host
The Aptible layers where you apps and databases run are backed by AWS EC2 instances, or hosts. Each host is deployed in a single VPC. On a dedicated stack, this means you are the only Aptible customer using those EC2 virtual servers.

In a dedicated stack, these EC2 instances are AWS Dedicated Instances, meaning Aptible is the sole tenant of the underlying hardware. The AWS hypervisor enforces isolation between EC2 hosts running on the same underlying hardware.

Within a stack, the EC2 hosts are organized into Aptible services layers. Each EC2 instance belongs to only one layer, isolating against failures in other layers:

- App Layer: Runs your app containers, terminates SSL.
- Database Layer: Runs your database containers.
- Bastion Layer: Provides backend SSH access to your stack, builds your Docker images.

Because Aptible may need to rotate or deprovision the hosts in your stack to avoid disruptions in service, we do not expose the ability for you to select which specific hosts in your stack will perform a given workload. 

You can provide host-level isolation for your customers, by provisioning them a separate, isolated Aptible stack, with Aptible’s VPC add-on. 

## Environment
Aptible environments are used for access control. Each environment runs on a specific stack. Each stack can support multiple environments. Note that when you use environments to separate apps or databases, those resources will share networks and underlying hosts.

You can use separate environments to isolate access to specific apps or databases to specific members of your organization.

## Container
Aptible uses Docker to build and run your app and database containers. Each container is a lightweight virtual machine that isolates Linux processes running on the same underlying host. Containers are generally isolated from each other, but are the weakest level of isolation.

You can provide container-level isolation for your customers by provisioning them separate apps and databases.
