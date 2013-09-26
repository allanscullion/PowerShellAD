#REQUIRES -Version 2.0

<# 
.SYNOPSIS  
	Export a list of potentially stale AD computer accounts to a CSV

.DESCRIPTION  
	Export a list of potentially stale AD computer accounts to a CSV

	The resulting output will show all AD computer entries with the no IPV4 address
	and no last login date

.PARAMETER csv
	Name of the CSV file output file

.NOTES  
    File Name      : StaleComputerAccounts.ps1
    Author         : Allan Scullion
    Prerequisite   : PowerShell V2, ActiveDirectory module

.EXAMPLE  
    StaleComputerAccounts.ps1 -csv stalecomputers.csv
#>
param (
    [string]$csv = $(throw "-csv is required.")
)

Get-ADComputer -Filter * -Property * | Select-Object Name, IPv4Address, CanonicalName, Created, Modified, LastLogonDate, OperatingSystem, OperatingSystemServicePack | where {$_.IPV4Address -like ""} | where {$_.LastLogonDate -like ""} | Select-Object Name, CanonicalName, Created, Modified, OperatingSystem, OperatingSystemServicePack | Export-CSV $csv -NoTypeInformation -Encoding UTF8
