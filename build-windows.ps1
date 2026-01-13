# Windows Build Script for Wizard Diver Game
# Builds the game for Windows platform

param(
    [string]$GodotPath = "",
    [string]$ExportPreset = "Windows Desktop"
)

Write-Host "=== Wizard Diver Game - Windows Build ===" -ForegroundColor Cyan
Write-Host ""

# Find Godot if path not provided
if ($GodotPath -eq "") {
    $godotPaths = @(
        "$env:LOCALAPPDATA\Programs\Godot\Godot_v4*.exe",
        "$env:USERPROFILE\Downloads\Godot*.exe",
        "C:\Program Files\Godot\Godot*.exe",
        "C:\Godot\Godot*.exe"
    )
    
    foreach ($path in $godotPaths) {
        $found = Get-ChildItem -Path $path -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($found) {
            $GodotPath = $found.FullName
            break
        }
    }
}

if ($GodotPath -eq "" -or -not (Test-Path $GodotPath)) {
    Write-Host "Godot not found. Please specify path:" -ForegroundColor Red
    Write-Host "  .\build-windows.ps1 -GodotPath 'C:\Godot\Godot.exe'" -ForegroundColor Yellow
    exit 1
}

Write-Host "Using Godot: $GodotPath" -ForegroundColor Green
Write-Host ""

# Create builds directory
$buildsDir = "builds\windows"
if (-not (Test-Path $buildsDir)) {
    New-Item -ItemType Directory -Force -Path $buildsDir | Out-Null
}

# Build the game
Write-Host "Building game..." -ForegroundColor Yellow
$projectPath = "godot-project\project.godot"
$exportPath = Resolve-Path $buildsDir

# Note: This requires export presets to be configured in Godot
# For now, this is a template - you'll need to configure exports in Godot first
Write-Host ""
Write-Host "To build the game:" -ForegroundColor Cyan
Write-Host "1. Open Godot and load: godot-project\project.godot" -ForegroundColor White
Write-Host "2. Go to Project > Export" -ForegroundColor White
Write-Host "3. Add 'Windows Desktop' export preset" -ForegroundColor White
Write-Host "4. Configure export settings" -ForegroundColor White
Write-Host "5. Click 'Export Project' and choose: $buildsDir\WizardDiver.exe" -ForegroundColor White
Write-Host ""
Write-Host "Or use command line (after configuring export):" -ForegroundColor Cyan
Write-Host "  & '$GodotPath' --headless --export-release 'Windows Desktop' '$buildsDir\WizardDiver.exe'" -ForegroundColor White

Write-Host ""
Write-Host "Build script ready!" -ForegroundColor Green
