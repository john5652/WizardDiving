# Windows Setup Script for Wizard Diver Game
# Run this script in PowerShell (as Administrator if needed)

Write-Host "=== Wizard Diver Game - Windows Setup ===" -ForegroundColor Cyan
Write-Host ""

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Note: Some operations may require Administrator privileges." -ForegroundColor Yellow
}

# Function to check if a command exists
function Test-Command {
    param($command)
    $null = Get-Command $command -ErrorAction SilentlyContinue
    return $?
}

# Function to install via winget if available
function Install-WithWinget {
    param($packageName, $displayName)
    if (Test-Command winget) {
        Write-Host "Installing $displayName via winget..." -ForegroundColor Green
        winget install --id $packageName --accept-package-agreements --accept-source-agreements
        return $?
    }
    return $false
}

# Function to install via Chocolatey if available
function Install-WithChoco {
    param($packageName, $displayName)
    if (Test-Command choco) {
        Write-Host "Installing $displayName via Chocolatey..." -ForegroundColor Green
        choco install $packageName -y
        return $?
    }
    return $false
}

# Check and install Git
Write-Host "Checking Git installation..." -ForegroundColor Yellow
if (Test-Command git) {
    $gitVersion = git --version
    Write-Host "✓ Git is installed: $gitVersion" -ForegroundColor Green
} else {
    Write-Host "Git not found. Attempting to install..." -ForegroundColor Yellow
    $installed = $false
    
    # Try winget first
    if (Test-Command winget) {
        $installed = Install-WithWinget "Git.Git" "Git"
    }
    
    # Try Chocolatey if winget failed
    if (-not $installed -and Test-Command choco) {
        $installed = Install-WithChoco "git" "Git"
    }
    
    # Manual installation instructions
    if (-not $installed) {
        Write-Host "Could not auto-install Git. Please install manually:" -ForegroundColor Red
        Write-Host "  Download from: https://git-scm.com/download/win" -ForegroundColor Yellow
        Write-Host "  Or install winget/Chocolatey and run this script again." -ForegroundColor Yellow
        exit 1
    }
}

# Check and install Python (for content generation tools)
Write-Host ""
Write-Host "Checking Python installation..." -ForegroundColor Yellow
if (Test-Command python) {
    $pythonVersion = python --version
    Write-Host "✓ Python is installed: $pythonVersion" -ForegroundColor Green
} else {
    Write-Host "Python not found. Attempting to install..." -ForegroundColor Yellow
    $installed = $false
    
    if (Test-Command winget) {
        $installed = Install-WithWinget "Python.Python.3.12" "Python 3.12"
    }
    
    if (-not $installed -and Test-Command choco) {
        $installed = Install-WithChoco "python" "Python"
    }
    
    if (-not $installed) {
        Write-Host "Could not auto-install Python. Please install manually:" -ForegroundColor Red
        Write-Host "  Download from: https://www.python.org/downloads/" -ForegroundColor Yellow
        Write-Host "  Make sure to check 'Add Python to PATH' during installation." -ForegroundColor Yellow
    }
}

# Check for Godot
Write-Host ""
Write-Host "Checking Godot installation..." -ForegroundColor Yellow
$godotPath = $null

# Check common installation locations
$godotPaths = @(
    "$env:LOCALAPPDATA\Programs\Godot\Godot_v4*.exe",
    "$env:USERPROFILE\Downloads\Godot*.exe",
    "C:\Program Files\Godot\Godot*.exe",
    "C:\Godot\Godot*.exe"
)

foreach ($path in $godotPaths) {
    $found = Get-ChildItem -Path $path -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($found) {
        $godotPath = $found.FullName
        break
    }
}

if ($godotPath) {
    Write-Host "✓ Godot found at: $godotPath" -ForegroundColor Green
} else {
    Write-Host "Godot not found. You'll need to install it manually:" -ForegroundColor Yellow
    Write-Host "  1. Download Godot 4.x from: https://godotengine.org/download" -ForegroundColor Yellow
    Write-Host "  2. Extract to a folder (e.g., C:\Godot)" -ForegroundColor Yellow
    Write-Host "  3. Optionally add to PATH or create a shortcut" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  For easy access, you can add Godot to your PATH:" -ForegroundColor Yellow
    Write-Host "    [Environment]::SetEnvironmentVariable('Path', `$env:Path + ';C:\Godot', 'User')" -ForegroundColor Cyan
}

# Verify Git configuration
Write-Host ""
Write-Host "Checking Git configuration..." -ForegroundColor Yellow
$gitUser = git config --global user.name 2>$null
$gitEmail = git config --global user.email 2>$null

if ($gitUser -and $gitEmail) {
    Write-Host "✓ Git configured: $gitUser <$gitEmail>" -ForegroundColor Green
} else {
    Write-Host "Git user information not configured. Please set it:" -ForegroundColor Yellow
    Write-Host "  git config --global user.name 'Your Name'" -ForegroundColor Cyan
    Write-Host "  git config --global user.email 'your.email@example.com'" -ForegroundColor Cyan
}

# Summary
Write-Host ""
Write-Host "=== Setup Summary ===" -ForegroundColor Cyan
Write-Host "✓ Git: " -NoNewline
if (Test-Command git) { Write-Host "Installed" -ForegroundColor Green } else { Write-Host "Not Found" -ForegroundColor Red }
Write-Host "✓ Python: " -NoNewline
if (Test-Command python) { Write-Host "Installed" -ForegroundColor Green } else { Write-Host "Not Found" -ForegroundColor Yellow }
Write-Host "✓ Godot: " -NoNewline
if ($godotPath) { Write-Host "Found" -ForegroundColor Green } else { Write-Host "Not Found - Install Manually" -ForegroundColor Yellow }

Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. If Git wasn't configured, set your user name and email" -ForegroundColor White
Write-Host "2. Install Godot 4.x if not already installed" -ForegroundColor White
Write-Host "3. Clone the repository: git clone <repository-url>" -ForegroundColor White
Write-Host "4. Open the project in Godot: godot-project/project.godot" -ForegroundColor White
Write-Host ""
Write-Host "Setup complete!" -ForegroundColor Green
