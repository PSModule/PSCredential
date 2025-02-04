# PSCredential

`PSCredential` is a PowerShell module that provides functions for managing credentials.
It allows users to create, save, and restore `PSCredential` objects from disk.

## Prerequisites

This module requires:

- The [PSModule framework](https://github.com/PSModule) for building, testing, and publishing the module.

## Installation

To install the module from the PowerShell Gallery, you can use the following command:

```powershell
Install-PSResource -Name PSCredential
Import-Module -Name PSCredential
```

## Usage

Here are some typical use cases for the module.

### Example 1: Creating a new `PSCredential` object

This function generates a `PSCredential` object using user input.

```powershell
New-PSCredential
```

This prompts the user for a username and password and returns a `PSCredential` object.

Alternatively, you can specify the credentials explicitly:

```powershell
New-PSCredential -Username 'admin' -Password (ConvertTo-SecureString 'P@ssw0rd!' -AsPlainText -Force)
```

### Example 2: Saving a `PSCredential` object to a file

You can save a credential to a file using `Save-PSCredential`:

```powershell
$credential = Get-Credential
Save-PSCredential -Credential $credential -Path 'C:\secure\credential.cred'
```

This saves the credential to `C:\secure\credential.cred`.

### Example 3: Restoring a `PSCredential` object from a file

To restore a credential object from a previously saved file:

```powershell
Restore-PSCredential -Path 'C:\secure\credential.cred'
```

Alternatively, you can use pipeline input:

```powershell
'C:\secure\credential.cred' | Restore-PSCredential
```

### Find more examples

To find more examples of how to use the module, please refer to the [examples](examples) folder.

Alternatively, you can use the following commands:

- Find available commands in the module:

  ```powershell
  Get-Command -Module PSCredential
  ```

- Get examples for a specific command:

  ```powershell
  Get-Help -Examples New-PSCredential
  ```

## Documentation

For further documentation, please refer to:

- [PSCredential](https://psmodule.io/PSCredential/)

## Contributing

Whether you're a coder or not, you can contribute to this project!

### For Users

If you experience unexpected behavior, errors, or missing functionality, you can help by submitting bug reports and feature requests.
Please visit the [issues tab](https://github.com/PSModule/PSCredential/issues) and submit a new issue.

### For Developers

If you are a developer, we welcome your contributions!
Please read the [Contribution Guidelines](CONTRIBUTING.md) for more information.
You can either help by picking up an existing issue or submit a new one if you have an idea for a feature or improvement.

## Disclaimer

The Export-Clixml cmdlet is used to save credentials to disk, is not secure on Linux and MacOS, and should be used with caution.
For more information read the [Export-Clixml](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-clixml?view=powershell-7.5#example-4-exporting-a-credential-object-on-linux-or-macos) documentation.
