[Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    'PSAvoidUsingConvertToSecureStringWithPlainText', '',
    Justification = 'Tests only; not for production code'
)]
[CmdletBinding()]
param()

Describe 'PSCredential' {
    Context 'Function: New-PSCredential' {
        It 'New-PSCredential - returns a valid PSCredential object' {
            $testUser = 'Admin'
            $testPasswordPlainText = 'P@ssw0rd!'
            $testPassword = $testPasswordPlainText | ConvertTo-SecureString -AsPlainText -Force
            $result = New-PSCredential -Username $testUser -Password $testPassword

            $result | Should -BeOfType System.Management.Automation.PSCredential
            $result.UserName | Should -Be $testUser
            $result.Password | Should -BeOfType System.Security.SecureString
            $result.GetNetworkCredential().Password | Should -Be $testPasswordPlainText
        }
    }
    Context 'Function: Save-PSCredential' {
        It 'Should create a new file and write out the SecureString' {
            $testUser = 'Admin2'
            $testPasswordPlainText = 'P@ssw0rd!2'
            $testPassword = $testPasswordPlainText | ConvertTo-SecureString -AsPlainText -Force
            $testCred = New-PSCredential -Username $testUser -Password $testPassword

            $filePath = '$HOME/Admin.cred'
            { Save-PSCredential -Credential $testCred -Path $filePath } | Should -Not -Throw
            Test-Path -Path $filePath | Should -Be $true

            $content = Get-Content -Path $filePath
            Write-Verbose ($content | Out-String) -Verbose
        }
    }
    Context 'Function: Restore-PSCredential' {
        It 'Restore-PSCredential - restores a PSCredential object' {
            $testUser = 'Admin3'
            $testPasswordPlainText = 'P@ssw0rd!3'
            $filePath = '$HOME/Admin3.cred'
            $testPassword = $testPasswordPlainText | ConvertTo-SecureString -AsPlainText -Force
            $testCred = New-PSCredential -Username $testUser -Password $testPassword
            { Save-PSCredential -Credential $testCred -Path $filePath } | Should -Not -Throw


            $result = Restore-PSCredential -Path $filePath
            $result | Should -BeOfType System.Management.Automation.PSCredential
            $result.UserName | Should -Be $testUser
            $result.Password | Should -BeOfType System.Security.SecureString
        }
    }
}
