# ShowProfile

A function utilising dynamic parameters and PowerShell classes to simplify opening the current user's [PowerShell profile](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles).

This module is also a good demonstration for how PowerShell classes have other uses outside of PowerShell DSC.

## [The Function](https://github.com/Yevrag35/ShowProfile/wiki/Show-Profile)

The <code>Show-Profile</code> function has 5 'default' editors/viewers incorporated.

1. Notepad
1. Console
1. PowerShell ISE
1. Notepad++
1. Visual Studio Code (VSCode)

One or more specified editors will open the current user's profile.

### Custom Editors

Custom editors/viewers can be added to be included in list of choices to pick from.