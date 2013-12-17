#REQUIRES -Version 2.0

<# 
.SYNOPSIS  
	Get last reboot for a list of servers

.DESCRIPTION  
	Get last reboot for a list of servers defined in a CSV file
	The CSV file format is as follows:

	Name
	MyServer1
	MyServer2

.PARAMETER file
	Name of the CSV file specifying the servers (required)

.NOTES  
    File Name      : GetRebootTime.ps1
    Author         : Allan Scullion
    Prerequisite   : PowerShell V2, ActiveDirectory module

.EXAMPLE    
    .\GetRebootTime.ps1 -file Test.csv
#>

param (
	[parameter(Mandatory=$true)]
	[alias("f")]
    [string]$file = $(throw "-file is required.")
)

$dataSource = Import-Csv $file

# Loop over every computer in the list and use WMI to get the reboot time

foreach($dataRecord in $dataSource)
{
	$server = $dataRecord.Name

	try
	{
		$wmi = Get-WmiObject -Class Win32_OperatingSystem -Computer "$server"
		$bootTime = $wmi.ConvertToDateTime($wmi.LastBootUpTime)
		$bootTime = Get-Date $bootTime -Format 'yyyy-MM-dd hh:mm:ss'
		"$server,$bootTime"
	}
	catch
	{ 
		Write-Host "$($server) :: Fail" -ForegroundColor Red -BackgroundColor Black
	}
}
