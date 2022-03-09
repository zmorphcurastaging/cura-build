param ($certificate)
signtool sign  /fd SHA256 /a /f $certificate ./windows-installers/output/Ultimaker_Cura*.exe