# setup.ps1 - Initializes dotfiles setup for PowerShell

# Ensure the PowerShell profile exists
if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
}

# Append the loading of aliases to the PowerShell profile if not already included
$dotfilesPath = "$HOME\dotfiles\PowerShell\aliases.ps1"
$profileContent = Get-Content -Path $PROFILE

if ($profileContent -notcontains ". `$dotfilesPath") {
    Add-Content -Path $PROFILE -Value "`n. `$dotfilesPath"
    Write-Output "Added dotfiles aliases to PowerShell profile."
}

Write-Output "Dotfiles setup completed. Please restart PowerShell or run `. $PROFILE` to apply changes."

# Define directories
$env:EXEC_ENV_DIR = "$HOME\exec"
$env:MISC_STORAGE_DIR = "$HOME\misc"

# Ensure directories exist
if (!(Test-Path -Path $env:EXEC_ENV_DIR)) {
    New-Item -ItemType Directory -Path $env:EXEC_ENV_DIR
}

if (!(Test-Path -Path $env:MISC_STORAGE_DIR)) {
    New-Item -ItemType Directory -Path $env:MISC_STORAGE_DIR
}

# Execution environment function (short alias: `exenv`)
function exenv {
    param([string]$itemPath)
    if ($itemPath -and (Test-Path -Path $itemPath)) {
        Copy-Item -Path $itemPath -Destination $env:EXEC_ENV_DIR -Recurse
        Write-Output "Copied $itemPath to execution environment."
    }
    Set-Location -Path $env:EXEC_ENV_DIR
    Write-Output "Entered execution environment at $env:EXEC_ENV_DIR."
}

# Alias to open miscellaneous storage (short alias: `misc`)
Set-Alias ms "Set-Location -Path $env:MISC_STORAGE_DIR"

# Organize files in miscellaneous storage by extension (short alias: `org`)
function org {
    Set-Location -Path $env:MISC_STORAGE_DIR
    Get-ChildItem -File | ForEach-Object {
        $ext = $_.Extension.TrimStart(".")
        if ($ext) {
            $targetDir = Join-Path -Path $env:MISC_STORAGE_DIR -ChildPath $ext
            if (!(Test-Path -Path $targetDir)) {
                New-Item -ItemType Directory -Path $targetDir
            }
            Move-Item -Path $_.FullName -Destination $targetDir
        }
    }
    Write-Output "Files in $env:MISC_STORAGE_DIR organized by type."
}
