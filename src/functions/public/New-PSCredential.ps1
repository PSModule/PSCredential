function New-PSCredential {
    <#
        .SYNOPSIS
        Creates a new PSCredential object.

        .DESCRIPTION
        This function generates a PSCredential object using a specified username and password.
        The password can be provided as a secure string or a plain text string, which will be
        converted into a secure string automatically.

        .EXAMPLE
        New-PSCredential

        Prompts the user for a username and password and returns a PSCredential object.

        .EXAMPLE
        New-PSCredential -Username 'admin' -Password (ConvertTo-SecureString 'P@ssw0rd!' -AsPlainText -Force)

        Creates a PSCredential object for the specified username and password.

        .NOTES
        This function suppresses warnings about using plain text passwords because it is
        explicitly designed to create PSCredential objects.

        .LINK
        https://psmodule.io/PSCredential/Functions/New-PSCredential/
    #>

    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        'PSUseShouldProcessForStateChangingFunctions', '',
        Justification = 'Does not change state, just holding a credential in memory'
    )]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        'PSAvoidUsingUsernameAndPasswordParams', '',
        Justification = 'The function is for creating a PSCredential'
    )]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        'PSAvoidUsingConvertToSecureStringWithPlainText', '',
        Justification = 'The function is for creating a PSCredential'
    )]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        'PSAvoidUsingPlainTextForPassword', '',
        Justification = 'The function is for creating a PSCredential'
    )]
    [OutputType([System.Management.Automation.PSCredential])]
    [CmdletBinding()]
    param(
        # Specifies the username for the PSCredential object.
        [Parameter()]
        [string] $Username = (Read-Host -Prompt 'Enter a username'),

        # Specifies the password for the PSCredential object. Accepts a secure string or plain text.
        [Parameter()]
        [object] $Password = (Read-Host -Prompt 'Enter Password' -AsSecureString)
    )

    if ($Password -is [String]) {
        $Password = ConvertTo-SecureString -String $Password -AsPlainText -Force
    }

    New-Object -TypeName System.Management.Automation.PSCredential($Username, $Password)
}
