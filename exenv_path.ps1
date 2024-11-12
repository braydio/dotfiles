# Define the path for the execution environment
$env:EXEC_ENV_DIR = "C:\Users\YourUsername\execution_env"

# Create the execution environment directory if it doesn't exist
if (!(Test-Path -Path $env:EXEC_ENV_DIR)) {
    New-Item -ItemType Directory -Path $env:EXEC_ENV_DIR
}

# Function to open the execution environment, optionally copying a file/directory
function exec-env {
    param(
        [string]$itemPath
    )

    # Check if a file or directory is specified and exists
    if ($itemPath) {
        if (Test-Path -Path $itemPath) {
            Copy-Item -Path $itemPath -Destination $env:EXEC_ENV_DIR -Recurse
            Write-Output "Copied $itemPath to execution environment."
        } else {
            Write-Output "Error: $itemPath does not exist."
            return
        }
    }

    # Open the execution environment in PowerShell
    Set-Location -Path $env:EXEC_ENV_DIR
    Write-Output "Entered execution environment at $env:EXEC_ENV_DIR."
}
