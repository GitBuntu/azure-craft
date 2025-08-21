# Set base directory
$baseDir = "D:\source\AllReact"
$projectName = "nike-clone"
$projectPath = Join-Path $baseDir $projectName

# Create project folder if it doesn't exist
if (-not (Test-Path $projectPath)) {
    New-Item -ItemType Directory -Path $projectPath | Out-Null
}

# Move into project folder
Set-Location $projectPath

# Scaffold Vite React+TS app in current folder
npm create vite@latest . -- --template react-ts

# Leave terminal open
Write-Host "`n✅ React + TypeScript app created in '$projectPath'"
Write-Host "You can now run 'npm run dev' when you're ready."
