class NotepadPlusPlus : BaseEditor {
    hidden [string] $Path = "{0}\Notepad++\notepad++.exe" -f $env:ProgramFiles
    [string] $Name = "Notepad++"
    [int] $Priority = 102

    NotepadPlusPlus() : base()
    {
        if (-not $this.IsValid)
        {
            $86path = Join-Path ${env:ProgramFiles(x86)} "Notepad++\notepad.exe"
            if ((Test-Path -Path $86path))
            {
                $this.IsValid = $true
                $this.Executable = $86path
            }
        }
    }
}