function Restore-PSCredential {
    <#

    #>
    [OutputType([System.Management.Automation.PSCredential])]
    [Alias('Import-PSCredential')]
    [CmdletBinding()]
    param(
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
            throw "Unable to locate a credential file for [$Username]"
        }

        if ($credential -isnot [System.Management.Automation.PSCredential]) {
            throw "Unable to restore a PSCredential object from [$Path]"
        }

        $credential
    }
}
