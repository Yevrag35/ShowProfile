[string[]]$functionFolders = @("$PSScriptRoot\Private", "$PSScriptRoot\Public")

# BaseEditor MUST be added to the session 1st.
Write-Verbose "Importing Class:`tBaseEditor"
. "$PSScriptRoot\Private\Editors\BaseEditor.ps1"

foreach ($file in $(Get-ChildItem -Path $functionFolders -Filter *.ps1 -Exclude "BaseEditor.ps1" -Recurse))
{
    Write-Verbose "Importing Class/Function: $($file.BaseName)"
    Write-Host $file.FullName
    . $file.FullName
}