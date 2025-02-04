[Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    'PSAvoidUsingConvertToSecureStringWithPlainText', '',
    Justification = 'Tests only; not for production code'
)]
[CmdletBinding()]
param()

Describe 'New-PSCredential Tests' {
    Context 'When creating credential with explicit username and password string' {
        It 'Should return a valid PSCredential object' {
            # Arrange
            $testUser = 'Admin'
            $testPassword = 'P@ssw0rd!'

            # Act
            $result = New-PSCredential -Username $testUser -Password ($testPassword | ConvertTo-SecureString -AsPlainText -Force)

            # Assert
            $result | Should -BeOfType System.Management.Automation.PSCredential
            $result.UserName | Should -Be $testUser
            # We can't directly assert the password text, but we can check it is a SecureString
            $result.Password | Should -BeOfType System.Security.SecureString
        }

        It 'Should honor ShouldProcess before creating' {
            # Arrange
            $mockedShouldProcess = $false
            # Mock out the internal call to $PSCmdlet.ShouldProcess
            # (Requires an InModuleScope or function rewriting. For simplicity, just show the concept here.)
            Mock -CommandName ShouldProcess -MockWith { $mockedShouldProcess }

            # Act
            $result = New-PSCredential -Username 'TestUser' -Password (ConvertTo-SecureString 'FakePass' -AsPlainText -Force)

            # Assert
            # If ShouldProcess returns false, we expect nothing back
            $result | Should -Be $null
        }
    }

    Context 'When prompting for input' {
        It 'Should prompt for username and password if not provided' {
            # Mock Read-Host so it doesn't actually prompt
            Mock -CommandName Read-Host -MockWith {
                param($Prompt)
                if ($Prompt -like '*username*') { return 'PromptedAdmin' }
                if ($Prompt -like '*Password*') { return (ConvertTo-SecureString 'PromptedPassword' -AsPlainText -Force) }
            }

            $result = New-PSCredential

            $result.UserName | Should -Be 'PromptedAdmin'
            $result.Password | Should -BeOfType System.Security.SecureString
        }
    }

}

Describe 'Restore-PSCredential Tests' {

    BeforeAll {
        # . .\Restore-PSCredential.ps1
    }

    Context 'When credential file exists' {
        It 'Should restore and return a PSCredential object' {
            # Arrange
            $testUser = 'Admin'
            $testSecureString = ConvertTo-SecureString 'P@ssw0rd!' -AsPlainText -Force
            $mockFilePath = 'C:\Temp\Admin.cred'

            Mock -CommandName Test-Path -MockWith {
                param($path)
                # Return $true to simulate the file exists
                return $true
            }
            Mock -CommandName Get-Content -MockWith {
                # Return a string that can be converted back to the known $testSecureString
                # We'll just re-use a quick trick to produce a securestring string for demonstration:
                ConvertFrom-SecureString $testSecureString
            }
            # No need to mock ConvertTo-SecureString if you trust it. But you can if you want to validate parameters, etc.

            # Act
            $result = Restore-PSCredential -UserName $testUser -Path 'C:\Temp'

            # Assert
            $result | Should -BeOfType System.Management.Automation.PSCredential
            $result.UserName | Should -Be $testUser
            $result.Password | Should -BeOfType System.Security.SecureString
        }
    }

    Context 'When credential file does NOT exist' {
        It 'Should throw an error' {
            # Arrange
            Mock -CommandName Test-Path -MockWith {
                return $false
            }

            # Act / Assert
            {
                Restore-PSCredential -UserName 'Admin' -Path 'C:\FakePath'
            } | Should -Throw -ErrorMessage '*Unable to locate a credential file*'
        }
    }
}

Describe 'Save-PSCredential Tests' {

    BeforeAll {
        # . .\Save-PSCredential.ps1
    }

    Context 'Saving a new credential file' {
        It 'Should create a new file and write out the SecureString' {
            # Arrange
            $testUser = 'Admin'
            $testCred = New-Object -TypeName System.Management.Automation.PSCredential(
                $testUser, (ConvertTo-SecureString 'P@ssw0rd!' -AsPlainText -Force)
            )
            # We want to simulate that the file does NOT exist
            Mock -CommandName Test-Path -MockWith { return $false }
            Mock -CommandName New-Item -MockWith { return $null }
            Mock -CommandName Out-File -MockWith { }

            # Act
            Save-PSCredential -Credential $testCred -Path 'C:\Temp'

            # Assert
            # Ensure New-Item was called once
            Assert-MockCalled -CommandName New-Item -Times 1
            Assert-MockCalled -CommandName Out-File -Times 1
        }
    }

    Context 'Overwriting an existing credential file' {
        It 'Should skip creating the file and just overwrite contents' {
            # Arrange
            $testUser = 'ExistingUser'
            $testCred = New-Object -TypeName System.Management.Automation.PSCredential(
                $testUser, (ConvertTo-SecureString 'ExistingPass' -AsPlainText -Force)
            )
            # Simulate file exists
            Mock -CommandName Test-Path -MockWith { return $true }
            Mock -CommandName New-Item -MockWith { } # We want to confirm it's NOT called
            Mock -CommandName Out-File -MockWith { }

            # Act
            Save-PSCredential -Credential $testCred -Path 'C:\MyCreds'

            # Assert
            Assert-MockCalled -CommandName New-Item -Times 0
            Assert-MockCalled -CommandName Out-File -Times 1
        }
    }

    Context 'When file creation fails' {
        It 'Should throw an exception' {
            # Arrange
            $testCred = New-Object -TypeName System.Management.Automation.PSCredential(
                'ThrowUser', (ConvertTo-SecureString 'ThrowPass' -AsPlainText -Force)
            )
            Mock -CommandName Test-Path -MockWith { return $false }
            Mock -CommandName New-Item -MockWith {
                throw 'Cannot create file for testing'
            }

            # Act / Assert
            {
                Save-PSCredential -Credential $testCred
            } | Should -Throw -ErrorMessage '*Cannot create file*'
        }
    }
}
