class BaseEditor {
    hidden [string] $Path = ""
    [string] $Executable
    [bool] $IsValid
    [string] $Name
    [int] $Priority

    hidden BaseEditor()
    {
        $this.Check()
    }

    hidden [void] Check()
    {
        if (-not [string]::IsNullOrWhiteSpace($this.Path) -and (Test-Path -Path $this.Path))
        {
            $this.Executable = $this.Path
            $this.IsValid = $true
        }
        else
        {
            $this.IsValid = $false
        }
    }

    [void] Start([string] $profilePath)
    {
        Start-Process -FilePath $this.Executable -ArgumentList $profilePath -NoNewWindow
    }
}