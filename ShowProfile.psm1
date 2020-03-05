[string[]]$functionFolders = @("$PSScriptRoot\Private", "$PSScriptRoot\Public")

# BaseEditor MUST be added to the session 1st.
Write-Verbose "Importing Class:`tBaseEditor"
. "$PSScriptRoot\Private\Editors\BaseEditor.ps1"

# Add 'default' editor classes and functions
foreach ($file in $(Get-ChildItem -Path $functionFolders -Filter *.ps1 -Exclude "BaseEditor.ps1" -Recurse))
{
    Write-Verbose "Importing Class/Function: $($file.BaseName)"
    . $file.FullName
}

# Search and Add Custom Editor classes
$customEditorDir = "{0}\ShowProfile-Editors" -f (Split-Path -Path $profile -Parent)
if ((Test-Path -Path $customEditorDir -PathType Container))
{
    foreach ($customClassFile in $(Get-ChildItem -Path $customEditorDir -Filter "ShowProfile_*.ps1" -File))
    {
        Write-Verbose "Importing Custom Class: $($customClassFile.BaseName)"
        . $customClassFile.FullName
    }
}

