#REQUIRES -Version 2.0

<# 
.SYNOPSIS  
    Creates a CSV file containing the name of all servers found in AD

.DESCRIPTION  
    Creates a CSV file containing the name of all servers found in AD
    The CSV file format is as follows:

    Name
    MyServer1
    MyServer2

.PARAMETER file
    Name of the CSV output file (required)

.NOTES  
    File Name      : GetServerList.ps1
    Author         : Allan Scullion
    Prerequisite   : PowerShell V2, ActiveDirectory module

.EXAMPLE  
    .\GetServerList.ps1 -file Test.csv
#>

param (
    [parameter(Mandatory=$true)]
    [alias("f")]
    [string]$file = $(throw "-file is required.")
)

Get-ADComputer -Filter { OperatingSystem -like "*Server*" } -Property * | Select-Object Name | Sort-Object name | Export-CSV $file -NoTypeInformation -Encoding UTF8
