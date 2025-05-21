#Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$SearchString,
    
    [Parameter(Mandatory=$true, Position=1)]
    [string]$OutputFile,
    
    [Parameter(Position=2)]
    [string]$Directory = "."
)

# Validate directory exists
if (-not (Test-Path -Path $Directory -PathType Container)) {
    Write-Error "Directory '$Directory' does not exist or is not accessible"
    exit 1
}

# Check if output file exists and prompt for overwrite
if (Test-Path -Path $OutputFile) {
    $confirmation = Read-Host "The file '$OutputFile' already exists. Overwrite? (y/n)"
    if ($confirmation -notmatch "^[yY]$") {
        Write-Host "Operation cancelled."
        exit
    }
}

Write-Host "Searching for '$SearchString' in .txt files under '$Directory'..."

try {
    # Find all .txt files containing the search string
    $matchingFiles = Get-ChildItem -Path $Directory -Recurse -Filter "*.txt" -File |
                    Select-String -Pattern $SearchString -List |
                    Select-Object -ExpandProperty Path
    
    if ($matchingFiles) {
        # Save results to output file
        $matchingFiles | Out-File -FilePath $OutputFile
        $count = $matchingFiles.Count
        Write-Host "Found $count matching files. Results saved to '$OutputFile'"
    }
    else {
        Write-Host "No .txt files containing '$SearchString' were found."
        # Remove empty output file if created
        if (Test-Path -Path $OutputFile) {
            Remove-Item -Path $OutputFile
        }
    }
}
catch {
    Write-Error "An error occurred during the search: $_"
    exit 1
}