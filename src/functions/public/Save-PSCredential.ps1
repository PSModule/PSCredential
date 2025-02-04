function Save-PSCredential {
    <#

    #>
    [OutputType([void])]
    [CmdletBinding()]
    param(
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
