Function Find-Editors()
{
    [CmdletBinding()]
    param ()

    $listOfEditors = New-Object -TypeName "System.Collections.Generic.List[BaseEditor]"

    $allAsses = [System.AppDomain]::CurrentDomain.GetAssemblies()
    $dynAsses = $allAsses.Where({$_.IsDynamic -and $_.DefinedTypes.Length -gt 0})
    foreach ($ass in $dynAsses)
    {
        $eTypes = $ass.DefinedTypes.Where({$_.IsPublic -and $_.BaseType -eq [BaseEditor]})
        if ($eTypes.Count -gt 0)
        {
            foreach ($e in $eTypes)
            {
                $listOfEditors.Add(([System.Activator]::CreateInstance($e) -as [BaseEditor]))
            }
        }
    }
    $listOfEditors
}