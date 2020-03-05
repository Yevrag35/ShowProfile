. "$PSScriptRoot\Private\BaseEditor.ps1"
foreach ($file in $(Get-ChildItem -Path "$PSScriptRoot\Private\Editors" -Filter *.ps1))
{
    . $file.FullName
}

. "$PSScriptRoot\Private\Find-Editors.ps1"

$global:list = Find-Editors