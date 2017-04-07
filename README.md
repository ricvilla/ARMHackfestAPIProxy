
# Azure VMSS :heavy_plus_sign: Kong


## Overview
This ARM template can be used to spin up Kong running in Ubuntu on an AzureVM scale set. 

The template deploys a Linux VMSS with a desired count of VMs in the scale set. Once the VM Scale Sets is deployed, kong is installed with the use of a custom script extension.

The Autoscale rules are configured as follows
- sample for CPU (\\Processor\\PercentProcessorTime) in each VM every 1 Minute
- if the Percent Processor Time is greater than 50% for 5 Minutes, then the scale out action (add more VM instances, one at a time) is triggered
- once the scale out action is completed, the cool down period is 1 Minute

## Usage
1. Clone this repo
2. Enter the appropriate parameters in azuredeploy.parameters.json
3. Deploy azuredeploy.json using the Azure CLI, Powershell or through the Azure REST API 

## References
This template has been derived from two other ARM templates:
1. Azure VMSS Ubuntu quick start template: https://github.com/Azure/azure-quickstart-templates/tree/master/201-vmss-ubuntu-autoscale
2. jdevillards Kong-Azure VM ARM template: https://github.com/jdevillard/kong-azure
