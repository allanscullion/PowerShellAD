#REQUIRES -Version 2.0

<# 
.SYNOPSIS  
    Check all computers in an OU and display services that run using the defined login name

.DESCRIPTION  
    Check all computers in an OU and display services that run using the defined login name
    Useful if you need to reset the password of a service account and you need to know what
    is running using that account name.

.PARAMETER account
    Account name to find

.PARAMETER ou
    OU containing the computers you want to search

.NOTES  
    File Name      : ServiceCheck.ps1
    Author         : Allan Scullion
    Prerequisite   : PowerShell V2, ActiveDirectory module
#>

param (
    [parameter(Mandatory=$true)]
    [alias("a")]
    [string]$account = $(throw "-account is required."),
    [parameter(Mandatory=$true)]
    [alias("o")]
    [string]$ou = $(throw "-ou is required.")
)

Get-ADComputer -searchBase $ou -Properties * -Filter * | Sort-Object name |

ForEach-Object {
    $rtn = Test-Connection -CN $_.dnshostname -Count 1 -BufferSize 16 -Quiet

    if ($rtn -match 'True') {

        $server = $_.name 

        Get-WMIObject Win32_Service -ComputerName $_.name | 
            Where-Object{$_.StartName -eq $account -and $_.StartMode -ne 'Disabled'} | 
            Sort-Object -Property StartName | 

        ForEach-Object {
            $service = $_.Name
            $login = $_.StartName
            "$server,$service,$login"
        }
    }
}
