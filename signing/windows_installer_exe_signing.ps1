# Get file name 
$file_name = @(Get-ChildItem ./windows-installers/output/* -include *.exe)
$path = "./windows-installers/output/"
# extract file name from $file_name with .exe extension
$exe_file_name =  Split-Path $file_name -leaf
# change extension from .exe to .sha1 to save file
$sha_file_name = $exe_file_name -replace '.exe', '_verify.sha1'
# change directory to file folder, generate sha1sum and change directory back to other scripts work properly
cd $path
certutil -hashfile $exe_file_name sha1 | Select -First 2 | Out-File $sha_file_name
cd ../../