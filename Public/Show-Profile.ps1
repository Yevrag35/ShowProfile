Function Show-Profile()
{
	<#
		.EXTERNALHELP ..\en-US\ShowProfile.psm1-Help.xml
	#>
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
		$attName = "Editor"
		[string[]]$editors = $global:TextEditors.Where({$_.IsValid}).Name
		$rtDict = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
		$attCol = New-Object 'System.Collections.ObjectModel.Collection[System.Attribute]'
		$pAtt = New-Object System.Management.Automation.ParameterAttribute -Property @{
			Mandatory = $false
			Position = 0
		}
		$attCol.Add($pAtt)
		$alias = New-Object System.Management.Automation.AliasAttribute("OpenIn", "in")
		$attCol.Add($alias)
		$valSet = New-Object System.Management.Automation.ValidateSetAttribute($editors)
		$attCol.Add($valSet)
		$rtParam = New-Object System.Management.Automation.RuntimeDefinedParameter($attName, [string[]], $attCol)
		$rtDict.Add($attName, $rtParam)
		return $rtDict;
	}
    Begin
    {
        [string[]]$chosen = $PSBoundParameters["Editor"]
		if ($null -eq $chosen -or $chosen.Length -le 0)
		{
			# ...then go by priority
			$OpenIn = $global:TextEditors | Sort-Object Priority | Select-Object -First 1
		}
		else
		{
			$OpenIn = $global:TextEditors.Where({$_.Name -in $chosen})
		}
    }
    Process
    {
		$OpenIn.Start($profile)
    }
}