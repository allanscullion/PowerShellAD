#REQUIRES -Version 2.0

<# 
.SYNOPSIS  
    Check space on C: of all computers in the defined OU

.DESCRIPTION  
    Check space on C: of all computers in the defined OU.
    Report any computer with less than 15GB
    You can set a default OU in the script (see below) to save having to define it every time

.PARAMETER ou
    OU containing the computers you want to search

.NOTES  
    File Name      : WorkstationDiskSpaceCheck.ps1
    Author         : Allan Scullion
    Prerequisite   : PowerShell V2, ActiveDirectory module
#>

param (
    [parameter(Mandatory=$false)]
    [alias("o")]
    [string]$ou = "**enter your default OU here**"
)

Get-ADComputer -searchBase $ou -Properties * -Filter * | Sort-Object name |

ForEach-Object {

    try {

        $workstation = $_.name
        $description = $_.description

        $wmi = Get-WmiObject Win32_LogicalDisk -ComputerName $workstation -Filter "DeviceID='C:'" | Select-Object Name, Size, FreeSpace

        $freespace = [math]::round($wmi.freespace/1024/1024/1024, 2)

        if ($freespace -le 15) {
            "$workstation,$description,{0:N2}GB" -f $freeSpace
        }
    }
    catch {
        "Cannot contact $workstation"
    }

}
