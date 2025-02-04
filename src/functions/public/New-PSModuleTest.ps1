#Requires -Modules @{ModuleName='PSSemVer'; ModuleVersion='1.0'}

function New-PSModuleTest {
    <#
        .SYNOPSIS
        Greets a person by name.

        .DESCRIPTION
        This function greets a person by name.

        .EXAMPLE
        New-PSModuleTest -Name 'World'

        Greets the person named 'World'.

        .LINK
        https://psmodule.io/Functions/New-PSModuleTest/
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        'PSUseShouldProcessForStateChangingFunctions', '', Scope = 'Function',
        Justification = 'Reason for suppressing'
    )]
    [Alias('New-PSModuleTestAlias1')]
    [Alias('New-PSModuleTestAlias2')]
    [CmdletBinding()]
    param (
        # Name of the person to greet.
        [Parameter(Mandatory)]
        [string] $Name
    )
    Write-Output "Hello, $Name!"
}
