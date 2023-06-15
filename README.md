# terraform-azurerm-aad-windows-vm

Module to create an Azure VM with the AAD extension configured. Uses the Windows Server 2022 Azure Edition for hot patching benefits.

It also includes a valid custom_data.ps1 and FirstLogonCommands.xml to install the following under OOBE:

* Azure CLI
* PowerShell 7.2.1
* Az Powershell module

It also extends the PATH environment variable with the CLI directory.

> Note that this approach configures autologon. One benefit is it allows the custom script extension to be added later if desired. May switch to DSC at some point instead.

Intended for use by the [examples](https://github.com/terraform-azurerm-examples)
