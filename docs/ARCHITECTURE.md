# Architecture

This lab deploys a minimal FastAPI service to Azure Container Apps and focuses on the operational lifecycle around the service.

## Components

- **Resource group** — isolates all project resources for clean lifecycle management
- **Azure Container Apps environment** — managed runtime for the container
- **Container App** — runs the FastAPI image and exposes external HTTPS ingress
- **Health endpoints** — provide basic operational checks
- **Log Analytics** — receives platform and application logging from the managed environment
- **Azure CLI** — deploys, inspects, scales, and removes resources

## Request flow

1. A client sends an HTTPS request to the Container Apps FQDN.
2. Azure ingress routes the request to an active application replica.
3. Uvicorn serves the FastAPI application on port 8000.
4. Operators use Azure CLI commands to inspect revisions, replica counts, provisioning state, and logs.

## Operational goals

- keep the application externally reachable over managed HTTPS
- scale to zero when idle to reduce cost
- limit the demonstration to two replicas
- validate deployment through health checks and Azure resource state
- remove the dedicated resource group after testing
