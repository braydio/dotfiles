# Define directories
$env:EXEC_ENV_DIR = "$HOME\execution_env"
$env:MISC_STORAGE_DIR = "$HOME\misc_storage"

# Ensure directories exist
if (!(Test-Path -Path $env:EXEC_ENV_DIR)) {
}

if (!(Test-Path -Path $env:MISC_STORAGE_DIR)) {
    New-Item -ItemType Directory -Path $env:EXEC_ENV_DIR
    New-Item -ItemType Directory -Path $env:MISC_STORAGE_DIR
}

# Execution environment function
function exec-env {
    param([string]$itemPath)
    if ($itemPath -and (Test-Path -Path $itemPath)) {
        Copy-Item -Path $itemPath -Destination $env:EXEC_ENV_DIR -Recurse
        Write-Output "Copied $itemPath to execution environment."
    }
    Set-Location -Path $env:EXEC_ENV_DIR
    Write-Output "Entered execution environment at $env:EXEC_ENV_DIR."
}

# Alias to open miscellaneous storage
Set-Alias misc "Set-Location -Path $env:MISC_STORAGE_DIR"

# Organize files in miscellaneous storage by extension
function organize-misc {
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
