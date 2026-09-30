param(
    [string]$ResourceGroup = "rg-azure-container-ops-lab",
    [string]$Location = "eastus",
    [string]$AppName = "azure-container-ops-api"
)

$ErrorActionPreference = "Stop"

Write-Host "Registering Azure providers..."
az provider register --namespace Microsoft.App | Out-Null
az provider register --namespace Microsoft.OperationalInsights | Out-Null

Write-Host "Creating resource group..."
az group create --name $ResourceGroup --location $Location --output none

Write-Host "Deploying Azure Container App..."
az containerapp up --name $AppName --resource-group $ResourceGroup --location $Location --source . --ingress external --target-port 8000

Write-Host "Configuring scale limits..."
az containerapp update --name $AppName --resource-group $ResourceGroup --min-replicas 0 --max-replicas 2 --output none

$fqdn = az containerapp show --name $AppName --resource-group $ResourceGroup --query "properties.configuration.ingress.fqdn" --output tsv

Write-Host ""
Write-Host "Application URL: https://$fqdn"
Write-Host "Health:          https://$fqdn/health"
Write-Host "Swagger:         https://$fqdn/docs"
