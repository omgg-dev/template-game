# Script that renames a OMGG Template Package into a new name

param(
    [string]$NewName
)

$OldName    = "template-game"
$RootDir    = Get-Location
$ProjectDir = "$RootDir\$OldName"

if (-not $NewName) {
    Write-Host "Use: .\rename.ps1 NewName"
    exit
} if (-not (Test-Path $ProjectDir)) {
    Write-Host "Folder $OldName not found."
    exit
}

Write-Host "Renaming Unity project to: $NewName"

# 1. Renaming root folder
Rename-Item $ProjectDir "$NewName"

# 2. Modifying ProjectSettings
$SettingsFile = "$RootDir\$NewName\ProjectSettings\ProjectSettings.asset"

(Get-Content $SettingsFile) -replace $OldName, $NewName | Set-Content $SettingsFile

# 3. Renaming template-game and .meta
$PackageDir = "$RootDir\$NewName\Assets\OMGG\Package"

if (Test-Path "$PackageDir\template-game") {
    Rename-Item "$PackageDir\template-game" $NewName

    if (Test-Path "$PackageDir\template-game.meta") {
        Rename-Item "$PackageDir\template-game.meta" "$NewName.meta"
    }
}

# 4. Renaming .asmdef and .asmdef.meta
$AsmdefFile = "$RootDir\Assets\Scripts\template-game.asmdef"

if (Test-Path $AsmdefFile) {
    Rename-Item $AsmdefFile "$NewName.asmdef"

    if (Test-Path "$AsmdefFile.meta") {
        Rename-Item "$AsmdefFile.meta" "$NewName.asmdef.meta"
    }

    (Get-Content "$RootDir\Assets\Scripts\$NewName.asmdef") -replace "template-game", "$NewName" | Set-Content "$RootDir\Assets\Scripts\$NewName.asmdef"
}

# 4bis. Renaming installer script (.iss) and icon (.ico)
if (Test-Path "template-game.iss") {
    Rename-Item "template-game.iss" "$NewName.iss"

    (Get-Content "$NewName.iss") -replace "template-game", $NewName | Set-Content "$NewName.iss"
}

if (Test-Path "template-game.ico") {
    Rename-Item "template-game.ico" "$NewName.ico"
}

# 5. Renaming $OldName to $NewName variables in .github/workflows

$WorkflowsDir = "$RootDir\.github\workflows"

if (Test-Path $WorkflowsDir) {
    Get-ChildItem $WorkflowsDir -Recurse -File | ForEach-Object {
        (Get-Content $_.FullName) -replace $OldName, $NewName | Set-Content $_.FullName
    }
}

# 6. Renaming $OldName to $NewName in rename.ps1 script
$RenameFile = "$RootDir\rename.ps1"

(Get-Content $RenameFile) -replace $OldName, $NewName | Set-Content $RenameFile
(Get-Content $RenameFile) -replace "template-game", $NewName | Set-Content $RenameFile

# 7. Renaming $OldName to $NewName in README.md
$ReadmeFile = "$RootDir\README.md"

if (Test-Path $ReadmeFile) {
    (Get-Content $ReadmeFile) -replace $OldName, $NewName | Set-Content $ReadmeFile
    (Get-Content $ReadmeFile) -replace "PACKAGE_NAME", $NewName | Set-Content $ReadmeFile
}

Write-Host "Project successfully renamed to $NewName"
