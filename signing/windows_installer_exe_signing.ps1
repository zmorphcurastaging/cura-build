param ($certificate)
$ToolFolder = "C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\signtool.exe"
$env:Path = $env:Path + ";" + $ToolFolder
signtool sign  /fd SHA256 /a /f $certificate ./windows-installers/output/Ultimaker_Cura*.exe