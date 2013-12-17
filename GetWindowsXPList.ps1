#REQUIRES -Version 2.0

<# 
.SYNOPSIS  
    Creates a CSV file containing the name of all Windows XP machines in AD

.DESCRIPTION  
    Creates a CSV file containing the name of all Windows XP machines in AD
    The CSV file format is as follows:

    Name
    WS1
    WS2

.PARAMETER file
    Name of the CSV output file (required)

.NOTES  
    File Name      : GetWindowsXPList.ps1
    Author         : Allan Scullion
    Prerequisite   : PowerShell V2, ActiveDirectory module

.EXAMPLE  
    .\GetWindowsXPList.ps1 -file Test.csv
#>

param (
    [parameter(Mandatory=$true)]
    [alias("f")]
    [string]$file = $(throw "-file is required.")
)


# Select the base OU to conduct the AD search

$OUBase = "ou=Computers,dc=mydomain,dc=local"

Get-ADComputer -searchBase $OUBase -Filter { OperatingSystem -like "*Windows XP*" } -Property * | Select-Object Name, Description, WhenCreated | Sort-Object name | Export-CSV $file -NoTypeInformation -Encoding UTF8
