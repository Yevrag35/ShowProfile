class ConsoleView : BaseEditor {
    [string] $Name = "Console"
    [int] $Priority = 1000

    ConsoleView() : base()
    {
        $this.Executable = "Get-Content"
        $this.IsValid = $true
    }

    [void] Start([string] $profilePath)
    {
        Write-Host $(Get-Content -Path $profilePath -Raw)
    }
}