# PowerShellAD

Useful Active Directory Tasks Scripted in PowerShell 2

## Overview

*   [Requirements](#requirements)
*   [Scripts](#scripts)
    *   [SetUserGroupMembership](#setusergroupmembership)
    *   [StaleComputerAccounts](#stalecomputeraccounts)
    *   [CacheEncryptedPassword](#cacheencryptedpassword)
    *   [GetServerList](#getserverlist)
    *   [LocalAdminAudit](#localadminaudit)
    *   [ArchiveSubFolders](#archivesubfolders)
    *   [GetWindowsXPList](#getwindowsxplist)
    *   [GetRebootTime](#getreboottime)

## Requirements

PowerShell 2 with ActiveDirectory Module  

See [this link][psad] on how to install the Active Directory module on a Windows 7 client

## Scripts

### SetUserGroupMembership

Add or Remove users from groups defined in a CSV file (see: SetUserGroupExample.csv)

The CSV file format is as follows:

	UserName,Group
	MyUserExample,MyADGroupExample
	MyUserExample,MyADGroupExample2
	MyUserExample2,MyADGroupExample
	MyUserExample3,MyADGroupExample2

PARAMETER file

	Name of the CSV file specifying the users and groups (required)

PARAMETER action

	Specify the action to perform:

	add 	- Adds the user to the specified group (default)
	remove  - Remove the user for the specified group

EXAMPLES

    .\SetUserGroupMembership.ps1 -file .\Test.csv -action add  
    .\SetUserGroupMembership.ps1 -file .\Test.csv -action remove

### StaleComputerAccounts

Export a list of potentially stale AD computer accounts to a CSV

The resulting output will show all AD computer entries with the no IPV4 address
and no last login date

PARAMETER csv

	Name of the CSV file output file

EXAMPLE

    StaleComputerAccounts.ps1 -csv stalecomputers.csv

### CacheEncryptedPassword

Saves an encrypted version of a password in a text file for secure sscheduled scripting tasks

The user is prompted for a user name and password. The output is stored in EncryptedPassword-<username>.txt

EXAMPLE

    .\CacheEncryptedPassword.ps1

### GetServerList

Creates a CSV file containing the name of all servers found in AD

The CSV file format is as follows:

    Name
    MyServer1
    MyServer2

PARAMETER file

    Name of the CSV output file (required)

EXAMPLE
    .\GetServerList.ps1 -file Test.csv

### LocalAdminAudit

Check local admin credentials on a list of servers defined in a CSV file

The CSV file format is as follows:

    Name
    MyServer1
    MyServer2

The user will be prompted for the local admin username and password

PARAMETER file

    Name of the CSV file specifying the servers (required)

EXAMPLE

    .\LocalAdminAudit.ps1 -file Test.csv

### ArchiveSubFolders

Archive all sub folders into individual zip files then delete the source folders

*WARNING* This script will zip all subfolders then each one without prompting.
** Do not run this script from the root of any drive. **

For example:

Source "Folder A" contains the following sub folders and files:

    Folder1
    Folder2
    Folder3
    File1.txt
    File2.csv

After running this script the contents of "Folder A" will be:

    Folder1.zip
    Folder2.zip
    Folder3.zip
    File1.txt
    File2.csv

Individual files in the source folder are left untouched

Requires 7-Zip to be installed in the default path "C:\Program Files\7-Zip\7z.exe"

### GetWindowsXPList

Creates a CSV file containing the name of all Windows XP machines in AD
The CSV file format is as follows:

    Name
    WS1
    WS2

PARAMETER file

    Name of the CSV output file (required)

EXAMPLE

    .\GetWindowsXPList.ps1 -file Test.csv

### GetRebootTime

Get last reboot for a list of servers defined in a CSV file
The CSV file format is as follows:

    Name
    MyServer1
    MyServer2

PARAMETER file

    Name of the CSV file specifying the servers (required)

EXAMPLE

    .\GetRebootTime.ps1 -file Test.csv

[psad]:http://blogs.msdn.com/b/rkramesh/archive/2012/01/17/how-to-add-active-directory-module-in-powershell-in-windows-7.aspx
