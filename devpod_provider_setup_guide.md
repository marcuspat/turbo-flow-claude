# DevPod Setup Guide

[![DevPod](https://img.shields.io/badge/DevPod-Development%20Environment-blue?style=flat-square)](https://devpod.sh)
[![Docker](https://img.shields.io/badge/Docker-Supported-2496ED?style=flat-square&logo=docker)](https://www.docker.com/)
[![AWS](https://img.shields.io/badge/AWS-Supported-FF9900?style=flat-square&logo=amazon-aws)](https://aws.amazon.com/)
[![GCP](https://img.shields.io/badge/GCP-Supported-4285F4?style=flat-square&logo=google-cloud)](https://cloud.google.com/)
[![Azure](https://img.shields.io/badge/Azure-Supported-0078D4?style=flat-square&logo=microsoft-azure)](https://azure.microsoft.com/)
[![DigitalOcean](https://img.shields.io/badge/DigitalOcean-Supported-0080FF?style=flat-square&logo=digitalocean)](https://www.digitalocean.com/)

This guide provides comprehensive setup instructions for using DevPod with various providers, including local Docker, major cloud platforms, and manual setup for services like Rackspace.

## Table of Contents

- [Local Docker Setup](#local-docker-setup-🐳)
- [DigitalOcean Setup](#digitalocean-setup-💧)
- [AWS Setup](#aws-setup-🌩️)
- [GCP Setup](#gcp-setup-☁️)
- [Azure Setup](#azure-setup-🚀)
- [Rackspace Setup (via SSH)](#rackspace-setup-via-ssh-⚙️)

## Local Docker Setup 🐳

The simplest setup option, perfect for getting started. Uses your local Docker installation.

### Prerequisites
- Docker Desktop (or Docker Engine on Linux) installed and running

### Setup Steps

1. **Add the Provider** (DevPod usually detects Docker automatically):
   ```bash
   devpod provider add docker
   ```

2. **Create a Workspace**:
   ```bash
   devpod up https://github.com/loft-sh/devpod-example-simple
   ```

DevPod will pull the necessary image and start a container on your local machine.

## DigitalOcean Setup 💧

Create development workspaces on DigitalOcean Droplets.

### Prerequisites
- DigitalOcean account
- `doctl` CLI installed and configured
- Personal Access Token (PAT) with read/write permissions

### Setup Steps

1. **Authenticate with doctl**:
   ```bash
   doctl auth init --access-token YOUR_DIGITALOCEAN_TOKEN
   ```

2. **Add the DigitalOcean Provider**:
   ```bash
   devpod provider add digitalocean
   ```

3. **Create a Workspace**:
   ```bash
   devpod up https://github.com/your/repo --provider digitalocean
   ```

   **Customize region and instance size**:
   ```bash
   devpod up https://github.com/your/repo --provider digitalocean --option region=nyc3
   ```

## AWS Setup 🌩️

Use Amazon EC2 instances for your workspaces with optional Spot Instance support for cost savings.

### Prerequisites
- AWS account
- AWS CLI installed
- AWS credentials configured (`aws configure` or environment variables)

### Setup Steps

1. **Authenticate with AWS CLI**:
   ```bash
   aws configure
   # Follow prompts: Access Key ID, Secret Access Key, region, output format
   ```

2. **Add the AWS Provider**:
   ```bash
   devpod provider add aws
   ```

3. **Create a Workspace (Standard Instance)**:
   ```bash
   devpod up https://github.com/your/repo --provider aws
   ```

4. **Create a Workspace (Spot Instance)**:
   ```bash
   devpod up https://github.com/your/repo --provider aws --option spot-instance=true
   ```

   **Set maximum spot price**:
   ```bash
   devpod up https://github.com/your/repo --provider aws --option spot-instance=true --option spot-price=0.03
   ```

## GCP Setup ☁️

Provision workspaces on Google Compute Engine (GCE) virtual machines.

### Prerequisites
- Google Cloud Platform account with project created
- `gcloud` CLI installed
- Billing enabled and Compute Engine API enabled for your project

### Setup Steps

1. **Authenticate with gcloud**:
   ```bash
   gcloud auth application-default login
   gcloud config set project YOUR_PROJECT_ID
   ```

2. **Add the GCP Provider**:
   ```bash
   devpod provider add gcp
   ```

3. **Create a Workspace**:
   ```bash
   devpod up https://github.com/your/repo --provider gcp
   ```

   **Customize zone and machine type**:
   ```bash
   devpod up https://github.com/your/repo --provider gcp --option zone=us-central1-a --option machine-type=e2-medium
   ```

## Azure Setup 🚀

Use Azure Virtual Machines for your development environments.

### Prerequisites
- Azure account with active subscription
- Azure CLI (`az`) installed

### Setup Steps

1. **Authenticate with Azure CLI**:
   ```bash
   az login
   # Follow browser-based login process
   ```

2. **Set active subscription**:
   ```bash
   az account set --subscription "YOUR_SUBSCRIPTION_NAME_OR_ID"
   ```

3. **Add the Azure Provider**:
   ```bash
   devpod provider add azure
   ```

4. **Create a Workspace**:
   ```bash
   devpod up https://github.com/your/repo --provider azure
   ```

   **Specify location and VM size**:
   ```bash
   devpod up https://github.com/your/repo --provider azure --option location=eastus --option vm-size=Standard_B2s
   ```

## Rackspace Setup (via SSH) ⚙️

> **Note**: DevPod doesn't have a native Rackspace provider. This method uses manual server provisioning with the SSH provider.

### Prerequisites
- Rackspace account
- SSH key pair (public/private)

### Setup Steps

1. **Manually Provision Rackspace Server**:
   - Log into your Rackspace Cloud account
   - Create a server and inject your public SSH key during creation
   - Note the public IP address

2. **Add SSH Provider to DevPod**:
   ```bash
   devpod provider add ssh
   ```
   
   You'll be prompted for:
   - **Host**: IP address of your Rackspace server
   - **User**: Username (e.g., `root` or `ubuntu`)
   - **Private Key Path**: Full path to private key (e.g., `~/.ssh/id_rsa`)

3. **Create a Workspace**:
   ```bash
   devpod up https://github.com/your/repo --provider ssh
   ```

> **Important**: You are responsible for the lifecycle and cost management of the Rackspace server.

## Contributing

Feel free to submit issues and pull requests to improve this guide!

## License

This guide is provided as-is for educational purposes.
