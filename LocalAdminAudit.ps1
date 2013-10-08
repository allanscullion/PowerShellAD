#REQUIRES -Version 2.0

<# 
.SYNOPSIS  
	Check local admin credentials on a list of servers

.DESCRIPTION  
	Check local admin credentials on a list of servers defined in a CSV file
	The CSV file format is as follows:

	Name
	MyServer1
	MyServer2

	The user will be prompted for the local admin username and password

.PARAMETER file
	Name of the CSV file specifying the servers (required)

.NOTES  
    File Name      : LocalAdminAudit.ps1
    Author         : Allan Scullion
    Prerequisite   : PowerShell V2, ActiveDirectory module

.EXAMPLE  
    .\LocalAdminAudit.ps1 -file Test.csv -action add

.EXAMPLE    
    .\LocalAdminAudit.ps1 -file Test.csv -action remove
#>

param (
	[parameter(Mandatory=$true)]
	[alias("f")]
    [string]$file = $(throw "-file is required.")
)

# What username should be tested?
$username = Read-Host "Local Admin Username"
$pass = Read-Host "Password" -AsSecureString

$dataSource = Import-Csv $file

# Find every computer in AD running an operating system with "Server" in its name.

foreach($dataRecord in $dataSource)
{
	$server = $dataRecord.Name

	# Make sure the server can be contacted
	if (Test-Connection $server -Quiet) 
	{
		# Build a local administrator credential
		$credential = New-Object System.Management.Automation.PSCredential("$($server)\$username",$pass)

		# Try to connect to the computer with the credential
		try
		{
			$null = Get-WmiObject Win32_OperatingSystem -Credential $credential -ComputerName $server
			Write-Host "$($server) :: Success" -ForegroundColor Green -BackgroundColor Black
		}
		catch
		{ 
			Write-Host "$($server) :: Fail" -ForegroundColor Red -BackgroundColor Black
		}
	}
}
