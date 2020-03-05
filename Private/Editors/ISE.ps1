class PowerShellISE : BaseEditor {
    hidden [string] $Path = "{0}\System32\WindowsPowerShell\v1.0\powershell_ise.exe" -f $env:windir
    [string] $Name = "ISE"
    [int] $Priority = 103

    PowerShellISE() : base()
    {
    }
}