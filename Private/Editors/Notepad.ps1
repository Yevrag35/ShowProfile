class Notepad : BaseEditor {

    hidden [string] $Path = "{0}\notepad.exe" -f [System.Environment]::GetFolderPath("Windows")
    [string] $Name = "Notepad"
    [int] $Priority = 199

    Notepad() : base()
    {
    }
}