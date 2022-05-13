# This script builds a Cura release using the cura-build-environment Windows docker image.

param (
  # Branch name/number from github
[string]$branch=$args[0],
$branch_array = $branch.Split("."),
$fisrt_number = $branch_array[0],
$second_number = $branch_array[1],

# Docker parameters
  [string]$DockerImage = "soniqsoft/cura-build-environment:win1809-latest",
# Branch parameters
  [string]$CuraBranchOrTag = $branch,
  [string]$UraniumBranchOrTag = $branch,
  [string]$CuraEngineBranchOrTag = $branch,
  [string]$CuraBinaryDataBranchOrTag = $branch,
  [string]$FdmMaterialsBranchOrTag = $branch,
  [string]$LibCharonBranchOrTag = $branch,

# Cura release parameters
  [string]$CuraVersionExtra = "",
  [string]$CuraBuildType = "",
  [string]$NoInstallPlugins = "",
  [string]$CloudApiRoot = "https://api.ultimaker.com",
  [string]$CloudAccountApiRoot = "https://account.ultimaker.com",
  [int32]$CloudApiVersion = 1,
  [string]$MarketplaceRoot = "https://marketplace.ultimaker.com",
  [string]$DigitalFactoryURL = "https://digitalfactory.ultimaker.com",
  [boolean]$EnableDebugMode = $true,
  [boolean]$EnableCuraEngineExtraOptimizationFlags = $true,
  [string]$CuraWindowsInstallerType = "EXE",
  [string]$PFXfile = "C:\cura-build-src\docker\windows\certificate.pfx",
  [string]$CuraMsiProductGuid = "76d2b1f8-b19e-4e4c-9e35-f86fd105b899",
  [string]$CuraMsiUpgradeGuid = "e752a0b4-7be3-4536-99c8-5a1f9119cb0c",
  [boolean]$IsInteractive = $false,
  [boolean]$BindSshVolume = $false
)
if ($branch -eq "master") {
  [int32]$CuraVersionMajor = "0"
  [int32]$CuraVersionMinor = "0"
  [int32]$CuraVersionPatch  = "0"

}
else {
  [int32]$CuraVersionMajor = $fisrt_number
  [int32]$CuraVersionMinor = $second_number
  [int32]$CuraVersionPatch  = "1"
}

$ErrorActionPreference = "Continue"
$WarningPreference = "SilentlyContinue"

$outputDirName = "windows-installers"
$buildOutputDirName = "build"

New-Item $outputDirName -ItemType "directory" -Force
$repoRoot = Join-Path $PSScriptRoot -ChildPath "..\.." -Resolve
$outputRoot = Join-Path (Get-Location).Path -ChildPath $outputDirName -Resolve

$CURA_DEBUG_MODE = "OFF"
if ($EnableDebugMode) {
  $CURA_DEBUG_MODE = "ON"
}

$CURAENGINE_ENABLE_MORE_COMPILER_OPTIMIZATION_FLAGS = "OFF"
if ($EnableCuraEngineExtraOptimizationFlags) {
  $CURAENGINE_ENABLE_MORE_COMPILER_OPTIMIZATION_FLAGS = "ON"
}

if ($CuraWindowsInstallerType -eq "EXE") {
  $CPACK_GENERATOR = "NSIS"
}
elseif ($CuraWindowsInstallerType -eq "MSI") {
  $CPACK_GENERATOR = "WIX"
  if ($CuraMsiProductGuid -eq "" -Or $CuraMsiUpgradeGuid -eq "") {
    Write-Error `
      -Message "Missing CuraMsiProductGuid or CuraMsiUpgradeGuid." `
      -Category InvalidArgument
    exit 1
  }
}
else {
  Write-Error `
    -Message "Invalid value [$CuraWindowsInstallerType] for CuraWindowsInstallerType. Must be EXE or MSI" `
    -Category InvalidArgument
  exit 1
}

$dockerExtraArgs = New-Object Collections.Generic.List[String]
if ($IsInteractive) {
  $dockerExtraArgs.Add("-it")
}

if ($BindSshVolume) {
  $oldPath = pwd
  cd ~
  $homePath = pwd
  cd $oldPath
  $sshPath = "$homePath\.ssh"
  $dockerExtraArgs.Add("--volume")
  $dockerExtraArgs.Add("${sshPath}:C:\Users\ContainerAdministrator\.ssh")
}

& docker.exe run $dockerExtraArgs `
  --rm `
  --volume ${repoRoot}:C:\cura-build-src `
  --volume ${outputRoot}:C:\cura-build-output `
  --env CURA_BUILD_SRC_PATH=C:\cura-build-src `
  --env CURA_BUILD_OUTPUT_PATH=C:\cura-build-output `
  --env CURA_BRANCH_OR_TAG=$CuraBranchOrTag `
  --env URANIUM_BRANCH_OR_TAG=$UraniumBranchOrTag `
  --env CURAENGINE_BRANCH_OR_TAG=$CuraEngineBranchOrTag `
  --env CURABINARYDATA_BRANCH_OR_TAG=$CuraBinaryDataBranchOrTag `
  --env FDMMATERIALS_BRANCH_OR_TAG=$FdmMaterialsBranchOrTag `
  --env LIBCHARON_BRANCH_OR_TAG=$LibCharonBranchOrTag `
  --env CURA_VERSION_MAJOR=$CuraVersionMajor `
  --env CURA_VERSION_MINOR=$CuraVersionMinor `
  --env CURA_VERSION_PATCH=$CuraVersionPatch `
  --env CURA_VERSION_EXTRA=$CuraVersionExtra `
  --env CURA_BUILD_TYPE=$CuraBuildType `
  --env CURA_NO_INSTALL_PLUGINS=$NoInstallPlugins `
  --env CURA_CLOUD_API_ROOT=$CuraCloudApiRoot `
  --env CURA_CLOUD_API_VERSION=$CuraCloudApiVersion `
  --env CURA_CLOUD_ACCOUNT_API_ROOT=$CuraCloudAccountApiRoot `
  --env CURA_MARKETPLACE_ROOT=$MarketplaceRoot `
  --env CURA_DIGITAL_FACTORY_URL=$DigitalFactoryURL `
  --env CURA_DEBUG_MODE=$CURA_DEBUG_MODE `
  --env CURAENGINE_ENABLE_MORE_COMPILER_OPTIMIZATION_FLAGS=$CURAENGINE_ENABLE_MORE_COMPILER_OPTIMIZATION_FLAGS `
  --env CPACK_GENERATOR=$CPACK_GENERATOR `
  --env CURA_MSI_PRODUCT_GUID=$CuraMsiProductGuid `
  --env CURA_MSI_UPGRADE_GUID=$CuraMsiUpgradeGuid `
  --env WINDOWS_IDENTITIY_PFX_FILE=$PFXfile `
  $DockerImage `
  powershell.exe -Command cmd /c "C:\cura-build-src\docker\windows\build_in_docker_vs2019.cmd"
