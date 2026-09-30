# Azure Container Apps Operations Lab

A cloud operations portfolio project built around deploying and operating a containerized FastAPI service on Azure Container Apps.

## What this project demonstrates

- Azure CLI-based deployment
- Azure Container Apps
- Docker containerization
- external HTTPS ingress
- health and readiness checks
- Log Analytics integration
- revision and scaling configuration
- operational verification and troubleshooting
- cost-aware resource cleanup
- GitHub Actions validation

## Architecture

```text
Client
  |
HTTPS
  |
Azure Container Apps Ingress
  |
Container App
  |
FastAPI service
  |
Health endpoint

Operations
  |
Azure CLI
  +--> revisions
  +--> logs
  +--> replicas
  +--> scaling
  +--> resource cleanup

Observability
  |
Log Analytics Workspace
```

## Repository structure

```text
.
├── .github/workflows/ci.yml
├── app/
│   └── main.py
├── docs/
│   ├── ARCHITECTURE.md
│   └── OPERATIONS_RUNBOOK.md
├── scripts/
│   ├── deploy.ps1
│   ├── verify.ps1
│   └── cleanup.ps1
├── .dockerignore
├── .gitignore
├── Dockerfile
└── requirements.txt
```

## Local test

```powershell
docker build -t azure-container-apps-operations-lab .
docker run --rm -p 8000:8000 azure-container-apps-operations-lab
```

Open:

```text
http://127.0.0.1:8000/health
http://127.0.0.1:8000/docs
```

## Deploy

Authenticate and select the Azure subscription:

```powershell
az login
az account set --subscription "Azure subscription 1"
```

Then run:

```powershell
.\scripts\deploy.ps1
```

The script creates a resource group, deploys the source as an Azure Container App with external ingress, and prints the public URL.

## Verify

```powershell
.\scripts\verify.ps1
```

The verification script checks the application FQDN, health endpoint, active revision, and replica state.

## Operations

See `docs/OPERATIONS_RUNBOOK.md` for commands covering logs, revisions, scaling, troubleshooting, and cleanup.

## Cleanup

```powershell
.\scripts\cleanup.ps1
```

The lab uses a dedicated resource group so the demonstration environment can be removed cleanly after testing.
