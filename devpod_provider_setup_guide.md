# DevPod Setup Guide

[![DevPod](https://img.shields.io/badge/DevPod-Development%20Environment-blue?style=flat-square)](https://devpod.sh)
[![Docker](https://img.shields.io/badge/Docker-Supported-2496ED?style=flat-square&logo=docker)](https://www.docker.com/)
[![AWS](https://img.shields.io/badge/AWS-Supported-FF9900?style=flat-square&logo=amazon-aws)](https://aws.amazon.com/)
[![GCP](https://img.shields.io/badge/GCP-Supported-4285F4?style=flat-square&logo=google-cloud)](https://cloud.google.com/)
[![Azure](https://img.shields.io/badge/Azure-Supported-0078D4?style=flat-square&logo=microsoft-azure)](https://azure.microsoft.com/)
[![DigitalOcean](https://img.shields.io/badge/DigitalOcean-Supported-0080FF?style=flat-square&logo=digitalocean)](https://www.digitalocean.com/)
[![Fly.io](https://img.shields.io/badge/Fly.io-Supported-8B5CF6?style=flat-square)](https://fly.io/)
[![Rackspace Spot](https://img.shields.io/badge/Rackspace%20Spot-Supported-E31937?style=flat-square)](https://spot.rackspace.com/)

This guide provides comprehensive setup instructions for using DevPod with various providers, including local Docker, major cloud platforms, and manual setup for services like Rackspace.

## Table of Contents

- [Local Docker Setup](#local-docker-setup-🐳)
- [DigitalOcean Setup](#digitalocean-setup-💧)
- [AWS Setup](#aws-setup-🌩️)
- [GCP Setup](#gcp-setup-☁️)
- [Azure Setup](#azure-setup-🚀)
- [Fly.io Setup](#flyio-setup-✈️)
- [Rackspace Spot Setup](#rackspace-spot-setup-🎯)

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

## Fly.io Setup ✈️

Use Fly.io Machines for globally distributed development environments with edge deployment capabilities.

### Prerequisites
- Fly.io account (credit card required for signup)
- `flyctl` CLI installed

### Installing flyctl

**macOS (Homebrew)**:
```bash
brew install flyctl
```

**Linux**:
```bash
curl -L https://fly.io/install.sh | sh
```

**Windows (PowerShell)**:
```powershell
pwsh -Command "iwr https://fly.io/install.ps1 -useb | iex"
```

After installation, add flyctl to your PATH if prompted.

### Setup Steps

1. **Create a Fly.io Account** (if you don't have one):
   ```bash
   fly auth signup
   ```

2. **Authenticate with Fly.io**:
   ```bash
   fly auth login
   # This opens a browser for authentication
   ```

3. **Verify Authentication**:
   ```bash
   fly auth whoami
   ```

4. **Add the SSH Provider with Fly.io Machine**:
   
   Since Fly.io doesn't have an official DevPod provider, you can use the SSH provider with a Fly.io Machine:

   a. **Create a Fly.io App for DevPod**:
   ```bash
   fly apps create devpod-workspace
   ```

   b. **Create a Machine with Docker installed**:
   ```bash
   fly machine run ubuntu:22.04 \
     --app devpod-workspace \
     --region iad \
     --vm-size shared-cpu-1x \
     --vm-memory 1024
   ```

   c. **SSH into the Machine and install Docker**:
   ```bash
   fly ssh console --app devpod-workspace
   # Inside the machine:
   apt-get update && apt-get install -y docker.io
   ```

   d. **Issue SSH credentials**:
   ```bash
   fly ssh issue --agent
   ```

   e. **Add the SSH Provider**:
   ```bash
   devpod provider add ssh -o HOST=root@devpod-workspace.fly.dev
   ```

5. **Create a Workspace**:
   ```bash
   devpod up https://github.com/your/repo --provider ssh
   ```

### Alternative: Using Fly.io with WireGuard

For a more secure connection, set up WireGuard VPN:

1. **Create a WireGuard tunnel**:
   ```bash
   fly wireguard create
   ```

2. **Import the configuration into your WireGuard client** and connect.

3. **Use the internal Fly.io address** for SSH:
   ```bash
   devpod provider add ssh -o HOST=root@<machine-id>.vm.<app-name>.internal
   ```

### Available Fly.io Regions

| Region ID | Location |
|-----------|----------|
| ams | Amsterdam, Netherlands |
| cdg | Paris, France |
| dfw | Dallas, Texas (US) |
| ewr | Secaucus, NJ (US) |
| fra | Frankfurt, Germany |
| gru | São Paulo, Brazil |
| iad | Ashburn, Virginia (US) |
| lax | Los Angeles, California (US) |
| lhr | London, United Kingdom |
| nrt | Tokyo, Japan |
| ord | Chicago, Illinois (US) |
| sin | Singapore |
| sjc | San Jose, California (US) |
| syd | Sydney, Australia |
| yyz | Toronto, Canada |

### VM Sizes

Common VM size options for development workspaces:

| Size | CPUs | Memory | Use Case |
|------|------|--------|----------|
| `shared-cpu-1x` | 1 shared | 256MB | Light development |
| `shared-cpu-2x` | 2 shared | 512MB | Standard development |
| `shared-cpu-4x` | 4 shared | 1GB | Medium workloads |
| `performance-1x` | 1 dedicated | 2GB | Performance-sensitive |
| `performance-2x` | 2 dedicated | 4GB | Heavy development |

**Example with custom sizing**:
```bash
fly machine run ubuntu:22.04 \
  --app devpod-workspace \
  --region ord \
  --vm-size shared-cpu-2x \
  --vm-memory 2048
```

### Cost Considerations

- Fly.io uses pay-as-you-go pricing with billing per second
- Stopped machines only incur storage costs (~$0.15/GB/month)
- Consider using `fly machine stop` when not developing to save costs
- Machines can be automatically stopped with the `--auto-stop` flag

### Useful Fly.io Commands

```bash
# List all machines
fly machines list --app devpod-workspace

# Stop a machine
fly machine stop <machine-id> --app devpod-workspace

# Start a machine
fly machine start <machine-id> --app devpod-workspace

# Delete a machine
fly machine destroy <machine-id> --app devpod-workspace

# View logs
fly logs --app devpod-workspace

# SSH into the machine
fly ssh console --app devpod-workspace
```

## Rackspace Spot Setup 🎯

> ⚠️ **Beta Notice**: VM CloudSpaces are currently in beta. The instructions below cover both Kubernetes CloudSpaces (generally available) and VM CloudSpaces (beta).

Use Rackspace Spot for cost-effective development environments with market-based pricing. Rackspace Spot offers cloud infrastructure through an open market auction, delivering fully managed Kubernetes clusters or standalone VMs at significantly reduced prices compared to traditional cloud providers.

### Prerequisites
- Rackspace Spot account (sign up at [spot.rackspace.com](https://spot.rackspace.com))
- `spotctl` CLI installed (for command-line management)
- API token from the Rackspace Spot dashboard

### Installing spotctl

Download the binary from the [releases page](https://github.com/rackspace-spot/spotctl/releases):

**Linux/macOS**:
```bash
# Download the appropriate binary for your platform
curl -LO https://github.com/rackspace-spot/spotctl/releases/latest/download/spotctl-linux-amd64
chmod +x spotctl-linux-amd64
sudo mv spotctl-linux-amd64 /usr/local/bin/spotctl
```

**Windows**:
Download the Windows binary from the releases page and add it to your PATH.

### Setup Steps

1. **Create a Rackspace Spot Account**:
   - Visit [spot.rackspace.com](https://spot.rackspace.com)
   - Sign up using GitHub, Google, or email/password

2. **Get Your API Token**:
   - Log in to the Rackspace Spot dashboard
   - Navigate to **API Access** in the left sidebar
   - Copy your access token

3. **Configure spotctl**:
   ```bash
   spotctl configure
   # Follow the interactive prompts to enter:
   # - Organization name
   # - Region
   # - Refresh token
   ```

---

### Option A: Kubernetes CloudSpaces

Use DevPod with Rackspace Spot's fully managed Kubernetes clusters.

#### Create a Kubernetes CloudSpace

**Using spotctl**:
```bash
spotctl cloudspaces create \
  --name devpod-cluster \
  --region us-central-dfw-1 \
  --org your-org-name \
  --spot-nodepool "serverclass=gp.vs1.medium-dfw,desired=2,bidprice=0.09"
```

**Using Terraform**:
```hcl
terraform {
  required_providers {
    spot = {
      source = "rackerlabs/spot"
    }
  }
}

variable "rackspace_spot_token" {
  description = "Rackspace Spot authentication token"
  type        = string
  sensitive   = true
}

provider "spot" {
  token = var.rackspace_spot_token
}

resource "spot_cloudspace" "devpod" {
  cloudspace_name    = "devpod-cluster"
  region             = "us-central-dfw-1"
  hacontrol_plane    = false
  wait_until_ready   = true
  kubernetes_version = "1.31.1"
  cni                = "calico"
}

resource "spot_spotnodepool" "workers" {
  cloudspace_name      = spot_cloudspace.devpod.cloudspace_name
  server_class         = "gp.vs1.medium-dfw"
  bid_price            = 0.09
  desired_server_count = 2
}
```

#### Add the Kubernetes Provider to DevPod

1. **Get your kubeconfig**:
   ```bash
   spotctl cloudspaces get-config devpod-cluster --file ~/.kube/config-rackspace-spot
   ```

2. **Add the Kubernetes provider**:
   ```bash
   devpod provider add kubernetes
   ```

3. **Configure the provider** to use your Rackspace Spot cluster:
   ```bash
   export KUBECONFIG=~/.kube/config-rackspace-spot
   devpod provider set-options kubernetes --option KUBERNETES_CONTEXT=devpod-cluster
   ```

4. **Create a Workspace**:
   ```bash
   devpod up https://github.com/your/repo --provider kubernetes
   ```

---

### Option B: VM CloudSpaces (Beta)

> ⚠️ **Beta**: VM CloudSpaces are currently in beta and provide standalone virtual machines with spot pricing.

#### Create a VM CloudSpace

**Using spotctl**:
```bash
spotctl cloudspaces create \
  --name devpod-vm \
  --region us-central-dfw-1 \
  --org your-org-name \
  --ondemand-nodepool "serverclass=gp.vs1.large-dfw,desired=1"
```

#### Connect with SSH Provider

1. **Get the VM's IP address** from the Rackspace Spot dashboard or CLI

2. **Configure SSH access** to your VM

3. **Add the SSH Provider**:
   ```bash
   devpod provider add ssh -o HOST=root@<your-vm-ip>
   ```

4. **Create a Workspace**:
   ```bash
   devpod up https://github.com/your/repo --provider ssh
   ```

---

### Available Regions

| Region ID | Location |
|-----------|----------|
| us-central-dfw-1 | Dallas, Texas (US) |
| us-central-dfw-2 | Dallas, Texas (US) |
| us-central-ord-1 | Chicago, Illinois (US) |
| us-east-iad-1 | Ashburn, Virginia (US) |
| eu-west-lon-1 | London, United Kingdom |
| apac-syd-1 | Sydney, Australia |
| apac-hkg-1 | Hong Kong |

### Server Classes

Common server classes for development workspaces:

| Server Class | vCPUs | Memory | Use Case |
|--------------|-------|--------|----------|
| `gp.vs1.small-dfw` | 1 | 1GB | Light development |
| `gp.vs1.medium-dfw` | 2 | 2GB | Standard development |
| `gp.vs1.large-dfw` | 4 | 4GB | Medium workloads |
| `gp.vs1.xlarge-dfw` | 8 | 8GB | Heavy development |
| `mem.vs1.large-dfw` | 4 | 16GB | Memory-intensive |

> **Note**: Replace `-dfw` suffix with your region code (e.g., `-ord`, `-iad`, `-lon`).

### GPU Server Classes

For AI/ML development workloads:

| Server Class | GPU | Use Case |
|--------------|-----|----------|
| `gpu.a30.vs2.xlarge` | NVIDIA A30 | ML training/inference |
| `gpu.h100.vs2.mega-xlarge` | NVIDIA H100 | Large-scale AI workloads |

### Cost Considerations

- **Market-Based Pricing**: Prices are determined by real-time supply and demand
- **Bid Strategy**: Set a maximum bid price; you pay the market rate up to your bid
- **Preemption**: Lower bids may be preempted when demand increases
- **Savings**: Typically 80-95% cheaper than traditional cloud providers
- **No Commitments**: No long-term contracts or reserved instances required

### Preemption Handling

Set up Slack notifications for node preemption:

```bash
spotctl cloudspaces create \
  --name devpod-cluster \
  --region us-central-dfw-1 \
  --org your-org-name \
  --preemption-webhook "https://hooks.slack.com/services/YOUR/WEBHOOK/URL" \
  --spot-nodepool "serverclass=gp.vs1.medium-dfw,desired=2,bidprice=0.09"
```

### Useful Rackspace Spot Commands

```bash
# List all cloudspaces
spotctl cloudspaces list

# Get cloudspace details
spotctl cloudspaces get --name devpod-cluster

# List spot node pools
spotctl nodepools spot list --cloudspace devpod-cluster

# Scale a node pool
spotctl nodepools spot update \
  --name my-nodepool \
  --cloudspace devpod-cluster \
  --desired 3 \
  --bidprice 0.10

# Delete a cloudspace
spotctl cloudspaces delete --name devpod-cluster

# List available server classes
spotctl serverclasses list

# Get kubeconfig for a cluster
spotctl cloudspaces get-config devpod-cluster --file ~/.kube/config

# List organizations
spotctl organizations list
```

### Terraform Resources

The Rackspace Spot Terraform provider is available on the [Terraform Registry](https://registry.terraform.io/providers/rackerlabs/spot/latest/docs):

```bash
# Initialize Terraform with the Spot provider
terraform init

# Plan your infrastructure
terraform plan -var="rackspace_spot_token=$SPOT_TOKEN"

# Apply changes
terraform apply -var="rackspace_spot_token=$SPOT_TOKEN"
```
