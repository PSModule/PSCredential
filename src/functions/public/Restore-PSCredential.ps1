function Restore-PSCredential {
    <#
        .SYNOPSIS
        Restores a PSCredential object from a file.

        .DESCRIPTION
        The Restore-PSCredential function retrieves a PSCredential object that was previously saved using `Save-PSCredential`.
        It reads the file from the specified path and ensures the content is a valid PSCredential object before returning it.

        .EXAMPLE
        Restore-PSCredential -Path 'C:\secure\mycredential.cred'

        Restores the PSCredential object from the file located at `C:\secure\mycredential.cred`.

        .EXAMPLE
        'C:\secure\mycredential.cred' | Restore-PSCredential

        Uses pipeline input to restore the PSCredential object from the specified file path.

        .LINK
        https://psmodule.io/PSCredential/Functions/Restore-PSCredential/
    #>

    [OutputType([System.Management.Automation.PSCredential])]
    [Alias('Import-PSCredential')]
    [CmdletBinding()]
    param(
        # Specifies the path to the credential file to restore.
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [System.IO.FileInfo] $Path
    )

    process {
        Write-Verbose "Restoring PSCredential from [$Path]"
        if (Test-Path $Path) {
            $credential = Import-Clixml -Path $Path
        } else {
            throw "Unable to locate a credential file for [$Path]"
        }

        if ($credential -isnot [System.Management.Automation.PSCredential]) {
            throw "Unable to restore a PSCredential object from [$Path]"
        }

        $credential
    }
}
