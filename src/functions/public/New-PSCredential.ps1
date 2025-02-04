function New-PSCredential {
    <#

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
    [Cmdletbinding()]
    param(
        [Parameter()]
        [string] $Username = (Read-Host -Prompt 'Enter a username'),
        [Parameter()]
        [object] $Password = (Read-Host -Prompt 'Enter Password' -AsSecureString)
    )

    if ($Password -is [String]) {
        $Password = ConvertTo-SecureString -String $Password -AsPlainText -Force
    }

    New-Object -TypeName System.Management.Automation.PSCredential($Username, $Password)
}
