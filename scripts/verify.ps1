param(
    [string]$ResourceGroup = "rg-azure-container-ops-lab",
    [string]$AppName = "azure-container-ops-api"
)

$ErrorActionPreference = "Stop"

$fqdn = az containerapp show --name $AppName --resource-group $ResourceGroup --query "properties.configuration.ingress.fqdn" --output tsv
if (-not $fqdn) { throw "Container App FQDN was not found." }

Write-Host "Checking https://$fqdn/health"
Invoke-RestMethod -Uri "https://$fqdn/health"

Write-Host ""
Write-Host "Active revision:"
az containerapp revision list --name $AppName --resource-group $ResourceGroup --query "[?properties.active].{Name:name,Traffic:properties.trafficWeight,Replicas:properties.replicas}" --output table

Write-Host ""
Write-Host "Container App status:"
az containerapp show --name $AppName --resource-group $ResourceGroup --query "{Name:name,ProvisioningState:properties.provisioningState,FQDN:properties.configuration.ingress.fqdn,MinReplicas:properties.template.scale.minReplicas,MaxReplicas:properties.template.scale.maxReplicas}" --output table
