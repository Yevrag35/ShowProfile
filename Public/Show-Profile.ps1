Function Show-Profile()
{
    [CmdletBinding()]
    param()
    DynamicParam
	{
		if ($null -eq $global:TextEditors)
		{
			$global:TextEditors=@()
			# Notepad ++ -- Priority #1
			$32npp = "$p86\Notepad++\notepad++.exe"
			$64npp = "$p64\Notepad++\notepad++.exe"
			if (Test-Path $32npp)
			{
				$test = $32npp
			}
			elseif (Test-Path $64npp)
			{
				$test = $64npp
			}
			if ($null -ne $test)
			{
				$global:TextEditors += New-Object PSObject -Property @{
					Name = "Notepad++"
					Path = $test
					Priority = 1
				}
			}
			# Add Visual Studio Code...
			$vsCode = "$p64\Microsoft VS Code\bin\code.cmd"
			if (Test-Path $vsCode)
			{
				$global:TextEditors += New-Object PSObject -Property @{
					Name = "VSCode"
					Path = $vsCode
					Priority = 2
				}
			}
			# Add Stupid Notepad...
			$global:TextEditors += New-Object psobject -Property @{
				Name = "Notepad"
				Path = "$env:WINDIR\System32\Notepad.exe"
				Priority = 3
			}
			# Add Stupid Console...
			$global:TextEditors += New-Object psobject -Property @{
				Name = "Console"
				Path = "Get-Content" # little trickery...
				Priority = 4
			}
        }

        # Create Dynamic Runtime Library
		$attName = "OpenIn"
		$editors = $global:TextEditors.Name
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
			$OpenIn = ($global:TextEditors | Sort Priority)[0]
		}
		else
		{
			$OpenIn = $global:TextEditors | ? Name -eq $chosen
		}
    }
    Process
    {
        if ($OpenIn.Path -like "*.exe")
		{
			Start-Process $OpenIn.Path -ArgumentList $profile
		}
		else
		{
			Invoke-Expression -Command "$($OpenIn.Path) $profile"
		}
    }
}