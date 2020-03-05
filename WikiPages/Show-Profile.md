# Show-Profile

## SYNOPSIS
Shows the PowerShell profile in chosen editor(s) or console.

## SYNTAX

### _AllParameterSets (Default)
```
Show-Profile [-Editor [<string[]>]] [<CommonParameters>]
```

## DESCRIPTION
Open the current user's PowerShell profile in one or more of the specified editors and/or the PowerShell console.

The default editors packed with this module are:
(Sorted by default priority)

1. VSCode
2. Notepad++
3. ISE
4. Notepad
5. Console

If no editor is specified, the one with the highest priority will be selected from the available valid choices.

## EXAMPLES

### Example 1
Open Profile in VSCode

```powershell
C:\PS> Show-Profile -Editor VSCode
```

### Example 2
Using an alias to open profile in Notepad++

```powershell
C:\PS> profile Notepad++
```

## PARAMETERS

### Editor
The editor(s) that will open or display the current user's PowerShell profile.  This is a dynamic parameter that will be populated based on the registered editors that are available and valid (exist).

```yaml
Type: string[]
Parameter Sets: _AllParameterSets
Aliases: OpenIn, in

Required: false
Position: named
Default Value:
Pipeline Input: False
Dynamic: true
```

### &lt;CommonParameters&gt;
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### &lt;None&gt;


## OUTPUTS

### &lt;None&gt;


## NOTES

### Custom Editors
Custom Editors can be added to be used with this command by creating the applicable PowerShell class in the <code>"Documents\\&lt;PowerShell&gt;\ShowProfile-Editors"</code> directory in the current user's UserProfile where '__PowerShell__' is the folder depending on which version of PowerShell is currently running.

* Folder name for PowerShell 5 & 5.1 - "Documents\WindowsPowerShell\ShowProfile-Editors"
* Folder name for PowerShell Core (6, 7+)   - "Documents\PowerShell\ShowProfile-Editors"

  * _A 'symlink' can be created to keep both folders consistent._

A few prerequisites for the custom editor classes are as follows:

1. It must inherit from <code>BaseEditor</code>.
2. It must implement a parameter-less constructor that calls the base constructor.
3. It must implement 2 public properties:
    1. __[string $Name__
    2. __[int] $Priority__

4. It must implement 1 hidden property:
    1. __hidden [string] $Path__

### Override Priorities
Default editor priorities can be overridden by including specific variables in the PowerShell profile.

The variable must:
  1. Start with "ShowProfile_"
  2. End with the name of the Editor whose priority you wish to override (case insensitive).

An example would be: you would like to override the priorities to make "Notepad++" the 'Default' editor.  Therefore, you would create this variable in the PowerShell profile:

```powershell
New-Variable -Name "ShowProfile_Notepad++" -Value 1
```

When an editor uses special characters (like in Notepad++'s case), you must use the "New-Variable" cmdlet to create the variable.  For others, simply adding:

```powershell
$ShowProfile_Notepad = 1
```

...would suffice.
