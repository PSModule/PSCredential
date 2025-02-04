# PSCredential

`PSCredential` is a PowerShell module that provides functions for securely managing credentials. It allows users to create, save, and restore `PSCredential` objects using encrypted XML files.

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

You can save a credential securely to an XML file using `Save-PSCredential`:

```powershell
$credential = Get-Credential
Save-PSCredential -Credential $credential -Path 'C:\secure\credential.xml'
```

This securely saves the credential to `C:\secure\credential.xml`.

### Example 3: Restoring a `PSCredential` object from a file

To restore a credential object from a previously saved XML file:

```powershell
Restore-PSCredential -Path 'C:\secure\credential.xml'
```

Alternatively, you can use pipeline input:

```powershell
'C:\secure\credential.xml' | Restore-PSCredential
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

## Acknowledgements

A big thanks to all contributors and the [PSModule framework](https://github.com/PSModule) for providing the foundation for module development.
