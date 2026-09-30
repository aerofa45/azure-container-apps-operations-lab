# Operations Runbook

## Check the application

    az containerapp show --name azure-container-ops-api --resource-group rg-azure-container-ops-lab --output table

## Stream application logs

    az containerapp logs show --name azure-container-ops-api --resource-group rg-azure-container-ops-lab --follow

## List revisions

    az containerapp revision list --name azure-container-ops-api --resource-group rg-azure-container-ops-lab --output table

## Change scale limits

    az containerapp update --name azure-container-ops-api --resource-group rg-azure-container-ops-lab --min-replicas 0 --max-replicas 2

## Common troubleshooting

### Deployment fails during source build
- confirm Dockerfile is in the repository root
- confirm the local Docker build succeeds
- confirm Microsoft.App and Microsoft.OperationalInsights are registered
- confirm the Azure subscription is selected

### Public endpoint returns an error
- check the Container App provisioning state
- confirm target port 8000
- inspect application logs
- confirm the latest revision is active

### Application is slow on the first request
With minimum replicas set to zero, the application can scale down while idle. The first request after an idle period may take longer while Azure starts a replica.

## Cleanup

    az group delete --name rg-azure-container-ops-lab --yes

Using a dedicated resource group makes teardown straightforward and reduces the risk of leaving demonstration resources running.
