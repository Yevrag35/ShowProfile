class VSCode : BaseEditor {
    hidden [string] $Path = "{0}\Microsoft VS Code\bin\code.cmd" -f $env:ProgramFiles
    [string] $Name = "VSCode"
    [int] $Priority = 101

    VSCode() : base()
    {
        if (-not $this.IsValid)
        {
            $86path = "{0}\Microsoft VS Code\bin\code.cmd" -f ${env:ProgramFiles(x86)}
            if ((Test-Path -Path $86path))
            {
                $this.IsValid = $true
                $this.Executable = $86path
            }
        }
    }
}