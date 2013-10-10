#REQUIRES -Version 2.0

<# 
.SYNOPSIS  
    Archive all sub folders into individual zip files then delete the source folders

.DESCRIPTION  
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

.NOTES  
    File Name      : ArchiveSubFolders.ps1
    Author         : Allan Scullion
    Prerequisite   : PowerShell V2, ActiveDirectory module, 7-Zip
#>

Set-Alias sz "C:\Program Files\7-Zip\7z.exe"

echo "*************"
echo "** WARNING **"
echo "*************"
echo "This script will Zip then *delete* all subfolders in the current working directory"
echo "Are you really sure you want to do this?"

$choice = ""
while ($choice -notmatch "[y|n]")
{
    $choice = Read-Host "Continue? (Y/N)"
}

if ($choice -eq "y")
{
    $folders = Get-ChildItem | ?{ $_.PSIsContainer } | select name

    if ($folders)
    {
        foreach ($folder in $folders)
        {
            $target = $folder.name
            sz a -tzip $target $target
            Remove-Item -Force -Confirm:$false -Recurse $target
        }
    }
}
