Function Show-Profile()
{
	[CmdletBinding()]
	[Alias("shpf", "profile")]
    param()
    DynamicParam
	{
		if ($null -eq $global:TextEditors)
		{
			$global:TextEditors = Find-Editors
		}

        # Create Dynamic Runtime Library
		$attName = "OpenIn"
		[string[]]$editors = $global:TextEditors.Where({$_.IsValid}).Name
		$rtDict = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
		$attCol = New-Object 'System.Collections.ObjectModel.Collection[System.Attribute]'
		$pAtt = New-Object System.Management.Automation.ParameterAttribute -Property @{
			Mandatory = $false
			Position = 0
		}
		$attCol.Add($pAtt)
		$alias = New-Object System.Management.Automation.AliasAttribute("o", "oi")
		$attCol.Add($alias)
		$valSet = New-Object System.Management.Automation.ValidateSetAttribute($editors)
		$attCol.Add($valSet)
		$rtParam = New-Object System.Management.Automation.RuntimeDefinedParameter($attName, [string], $attCol)
		$rtDict.Add($attName, $rtParam)
		return $rtDict;
	}
    Begin
    {
        $chosen = $PSBoundParameters["OpenIn"]
		if ($null -eq $chosen)
		{
			# ...then go by priority
			$OpenIn = $global:TextEditors | Sort Priority | Select-Object -First 1
		}
		else
		{
			$OpenIn = $global:TextEditors.Where({$_.Name -eq $chosen})
		}
    }
    Process
    {
		$OpenIn.Start($profile)
    }
}