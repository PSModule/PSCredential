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
            # We can't directly assert the password text, but we can check it is a SecureString
            $result.Password | Should -BeOfType System.Security.SecureString
            $result.GetNetworkCredential().Password | Should -Be $testPasswordPlainText
        }
    }
    Context 'Function: Save-PSCredential' {
        It 'Should create a new file and write out the SecureString' {
            # Arrange
            $testUser = 'Admin2'
            $testPasswordPlainText = 'P@ssw0rd!2'
            $testPassword = $testPasswordPlainText | ConvertTo-SecureString -AsPlainText -Force
            $testCred = New-PSCredential -Username $testUser -Password $testPassword

            $filePath = '$HOME/Admin.cred'
            { Save-PSCredential -Credential $testCred -Path $filePath } | Should -Not -Throw
            Test-Path -Path $filePath | Should -Be $true
        }
        # It 'Should skip creating the file and just overwrite contents' {
        #     # Arrange
        #     $testUser = 'ExistingUser'
        #     $testCred = New-Object -TypeName System.Management.Automation.PSCredential(
        #         $testUser, (ConvertTo-SecureString 'ExistingPass' -AsPlainText -Force)
        #     )
        #     # Act
        #     Save-PSCredential -Credential $testCred -Path '$HOME/Admin.cred'
        # }
        # It 'Should throw an exception When file creation fails' {
        #     # Arrange
        #     $testCred = New-Object -TypeName System.Management.Automation.PSCredential(
        #         'ThrowUser', (ConvertTo-SecureString 'ThrowPass' -AsPlainText -Force)
        #     )
        #     # Act / Assert
        #     {
        #         Save-PSCredential -Credential $testCred
        #     } | Should -Throw -ErrorMessage '*Cannot create file*'
        # }
    }
    Context 'Function: Restore-PSCredential' {
        It 'Restore-PSCredential - restores a PSCredential object' {
            # Arrange
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
        It 'Should throw an error When credential file does NOT exist' {
            {
                Restore-PSCredential -UserName 'Admin' -Path 'C:\FakePath'
            } | Should -Throw -ErrorMessage '*Unable to locate a credential file*'
        }
    }
}
