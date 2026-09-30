param([string]$ResourceGroup = "rg-azure-container-ops-lab")

$ErrorActionPreference = "Stop"
Write-Host "Deleting resource group $ResourceGroup..."
az group delete --name $ResourceGroup --yes --no-wait
Write-Host "Deletion started."
