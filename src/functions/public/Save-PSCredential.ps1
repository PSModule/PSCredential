function Save-PSCredential {
    <#
        .SYNOPSIS
        Saves a PSCredential object to a file.

        .DESCRIPTION
        This function takes a PSCredential object and exports it to a file.
        If the specified file path does not exist, it creates the necessary directory structure before saving the credential.

        .EXAMPLE
        $credential = Get-Credential
        Save-PSCredential -Credential $credential -Path 'C:\secure\credential.cred'

        Prompts for a username and password, then saves the credential securely to `C:\secure\credential.cred`.

        .EXAMPLE
        $password = ConvertTo-SecureString 'MyPassword' -AsPlainText -Force
        $credential = New-PSCredential -Username 'UserName' -Password $password
        Save-PSCredential -Credential $credential -Path 'C:\secure\mycreds.cred'

        Saves the predefined credential securely to `C:\secure\mycreds.cred`.

        .LINK
        https://psmodule.io/PSCredential/Functions/Save-PSCredential/
    #>

    [OutputType([void])]
    [CmdletBinding()]
    param(
        # The PSCredential object to be saved.
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [System.Management.Automation.PSCredential] $Credential,

        # The file path to save the PSCredential to.
        [Parameter(Mandatory)]
        [string] $Path
    )

    process {
        Write-Verbose "Saving PSCredential to [$Path]"
        $pathExists = Test-Path $Path
        if (-not $pathExists) {
            # Create the folder structure to the file if they don't exist, including an empty file.
            $null = New-Item -ItemType File -Path $Path -ErrorAction Stop -Force
        }
        $Credential | Export-Clixml -Path $Path
    }
}
