# PSCredential Examples

This documentation provides details on three PowerShell functions for managing `PSCredential` objects:

- **`New-PSCredential`**: Creates a new `PSCredential` object.
- **`Save-PSCredential`**: Saves a `PSCredential` object to a file.
- **`Restore-PSCredential`**: Restores a `PSCredential` object from a file.

---

## `New-PSCredential`

### Description

This function generates a `PSCredential` object using a specified username and password.
The password can be provided as a secure string or a plain text string, which will be automatically converted into a secure string.

### Examples

#### Example 1: Prompting for Credentials

```powershell
New-PSCredential
```
Prompts the user for a username and password and returns a `PSCredential` object.

#### Example 2: Creating a `PSCredential` Object with a Predefined Password

```powershell
New-PSCredential -Username 'admin' -Password (ConvertTo-SecureString 'P@ssw0rd!' -AsPlainText -Force)
```
Creates a `PSCredential` object for the specified username and password.

---

## `Save-PSCredential`

### Description

This function takes a `PSCredential` object and exports it as an encrypted XML file using `Export-Clixml`.
If the specified file path does not exist, the function creates the necessary directory structure before saving the credential.

### Examples

#### Example 1: Saving Credentials from User Input

```powershell
$credential = Get-Credential
Save-PSCredential -Credential $credential -Path 'C:\secure\credential.xml'
```
Prompts for a username and password, then securely saves the credential to `C:\secure\credential.xml`.

#### Example 2: Saving Predefined Credentials

```powershell
$password = ConvertTo-SecureString 'MyPassword' -AsPlainText -Force
$credential = New-PSCredential -Username 'UserName' -Password $password
Save-PSCredential -Credential $credential -Path 'C:\secure\mycreds.xml'
```
Saves the predefined credential securely to `C:\secure\mycreds.xml`.

---

## `Restore-PSCredential`

The `Restore-PSCredential` function retrieves a `PSCredential` object that was previously saved using `Export-Clixml`.
It reads the file from the specified path and ensures the content is a valid `PSCredential` object before returning it.


### Example 1: Restoring Credentials from a File

```powershell
Restore-PSCredential -Path 'C:\secure\mycredential.xml'
```

Restores the `PSCredential` object from the file located at `'C:\secure\mycredential.xml'`.

### Example 2: Using Pipeline Input to Restore Credentials

```powershell
'C:\secure\mycredential.xml' | Restore-PSCredential
```

Uses pipeline input to restore the `PSCredential` object from the specified file path.

---
