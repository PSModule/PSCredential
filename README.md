# PSCredential

PSCredential is a PowerShell module for managing PSCredential objects.

## Installation

Install the module from the PowerShell Gallery:

```powershell
Install-PSResource -Name PSCredential
Import-Module -Name PSCredential
```

## Documentation

Documentation is published at [psmodule.io/PSCredential](https://psmodule.io/PSCredential/).

Saved credentials use PowerShell's `Export-Clixml` protection model. Review the command help before using saved credentials outside your own user profile and machine context.

Use PowerShell help and command discovery for module details:

```powershell
Get-Command -Module PSCredential
Get-Help Save-PSCredential -Examples
```

## Contributing

Issues and pull requests are welcome. Please use the repository issue tracker to report bugs, request features, or discuss improvements.
