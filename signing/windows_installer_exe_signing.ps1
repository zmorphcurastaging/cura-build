# Get file name 
$path = "./windows-installers/output/"
$full_file_name = @(Get-ChildItem $path* -include *.exe, *.msi)
$file_name =  Split-Path $full_file_name -leaf
$extension = $file_name -split '\.' | select -Last 1

# change extension from .exe to .sha1 to save file
$sha_file_name = $file_name -replace $extension, '_verify.sha1'
# change directory to file folder, generate sha1sum and change directory back to other scripts work properly
cd $path
certutil -hashfile $file_name sha1 | Select -First 2 | Out-File $sha_file_name
cd ../../