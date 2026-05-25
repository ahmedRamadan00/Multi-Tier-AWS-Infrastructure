# Multi-Tier AWS Infrastructure with Terraform

AWS infrastructure built using Terraform following a modular and scalable architecture.

---

## 📌 Project Overview

This project provisions a highly available multi-tier AWS infrastructure using Terraform Infrastructure as Code (IaC).

The architecture includes:

- VPC Networking
- Public & Private Subnets
- NAT Gateways
- Application Load Balancer (ALB)
- EC2 Auto Scaling Group
- RDS PostgreSQL Multi-AZ
- S3 Storage
- IAM Roles
- Security Groups
- AWS KMS Encryption
- AWS Secrets Manager

---

## 🏗️ Architecture

### Infrastructure Design

- Multi-AZ deployment
- Three-tier architecture
- Secure private application layer
- Database isolation
- Infrastructure modularization

---

## 📂 Project Structure

```bash
terraform-aws-infra/
│
├── modules/
│   ├── networking/
│   ├── compute_module/
│   ├── Data_module/
│   ├── security_module/
│   └── storage_module/
│
├── environments/
│   ├── dev/
│   ├── staging/
│   └── prod/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
└── terraform.tfvars
```

---

## ⚙️ Technologies Used

- Terraform
- AWS
- EC2
- VPC
- RDS PostgreSQL
- S3
- IAM
- KMS
- Secrets Manager
- Auto Scaling
- Application Load Balancer

---

## 🔐 Security Features

- Private EC2 instances
- No public database access
- Security Group isolation
- KMS encryption
- Secrets Manager integration
- Least privilege IAM access

---

## 🚀 Deployment

### Initialize Terraform

```bash
terraform init
```

### Validate Configuration

```bash
terraform validate
```

### Preview Changes

```bash
terraform plan
```

### Apply Infrastructure

```bash
terraform apply
```
---

## 📄 License

This project is for educational and portfolio purposes.
