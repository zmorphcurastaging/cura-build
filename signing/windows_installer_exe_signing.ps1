$file_name = @(Get-ChildItem ./windows-installers/output/* -include *.exe)
$file = $file_name[0]
certutil -hashfile $file sha1 | Select -First 2 | Out-File ./windows-installers/output/$file.sha1