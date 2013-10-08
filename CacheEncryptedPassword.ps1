#REQUIRES -Version 2.0

<# 
.SYNOPSIS  
    Saves an encrypted version of a password in a text file for secure sscheduled scripting tasks

.DESCRIPTION  
    Saves an encrypted version of a password in a text file for secure sscheduled scripting tasks

    The user is prompted for a user name and password. The output is stored in EncryptedPassword-<username>.txt

.NOTES  
    File Name      : CacheEncryptedPassword.ps1
    Author         : Allan Scullion
    Prerequisite   : PowerShell V2, ActiveDirectory module

.EXAMPLE  
    .\CacheEncryptedPassword.ps1
#>

$user = Read-Host 'User'
$pass = Read-Host 'Password' -AsSecureString
$targetfile = "EncryptedPassword-$user.txt"

$pass_enc = ConvertFrom-SecureString $pass -key (1..16)
$pass_enc > $targetfile

echo "Encrypted password for user $user stored in $targetfile"
