# dyninno-project


> ⚠️ **Security Warning:**  
> This repository contains **hardcoded secrets** in the code. It is strongly recommended to **remove them** and use a **secure secrets management** solution like:
> - AWS Secrets Manager  
> - HashiCorp Vault  


## Table of Contents
- [Overview](#overview)
- [Secrets](#secrets)
- [Directory Structure](#directory-structure)
- [Work In Progress](#work-in-progress)

## Overview

This is a **complete end-to-end automated platform** where you only need to run the workflows.

- **Validate Infra Workflow**: Validates your Terraform scripts.
- **Apply Infra Workflow**: Once validation is complete, it automatically requests approval to proceed with the infrastructure deployment.
- After deployment, you can **log in to the EC2 instance** and run the following command to check the deployed pods:

  ```sh
  kubectl get pods
  ```
- Expected output can be seen below.

  ![Screenshot](pictures/screenshot.png)


## Secrets 

You need to set below secrets at repo level

- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- DOCKER_PASSWORD
- DOCKER_USERNAME
- GH_PAT (Personal Access Token for authentication)

## Directory Structure
```
.
├── README.md
├── app
│   ├── reader
│   │   ├── reader.py
│   │   └── requirements.txt
│   └── writer
│       ├── requirements.txt
│       └── writer.py
├── devops
│   ├── reader.Dockerfile
│   └── writer.Dockerfile
├── manifests
│   ├── mysql.yaml
│   ├── reader.yaml
│   ├── writer.yaml
│   └── writer.yaml_bkup
├── pictures
│   └── screenshot.png
├── remote-backend
│   ├── main.tf
│   ├── terraform.tfvars
│   └── variables.tf
├── scripts
│   ├── install.sh
│   └── install.sh_bkup
└── terraform
    ├── backend.tf
    ├── main.tf
    └── variables.tf

10 directories, 20 files
```

## Work In Progress
- Implement monitoring
- Implement continous replication between master-slave mysql
