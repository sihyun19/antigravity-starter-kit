# Antigravity Starter Kit - Windows One-Click Installer
$ErrorActionPreference = "Stop"

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "   Antigravity Starter Kit Installation" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

$geminiRoot = "$HOME\.gemini"
$configDir  = "$geminiRoot\config"
$skillsDir  = "$configDir\skills"
$backupDir  = "$geminiRoot\backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"

# 1. Create target directories
New-Item -ItemType Directory -Force -Path $skillsDir | Out-Null

# 2. Backup existing config if present
if (Test-Path "$geminiRoot\GEMINI.md") {
    Write-Host "[1/3] Existing GEMINI.md found. Creating backup..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
    Copy-Item -Path "$geminiRoot\GEMINI.md" -Destination "$backupDir\GEMINI.md" -Force
}
if (Test-Path "$configDir\config.json") {
    Write-Host "[1/3] Existing config.json found. Creating backup..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
    Copy-Item -Path "$configDir\config.json" -Destination "$backupDir\config.json" -Force
}

# 3. Copy files
Write-Host "[2/3] Installing GEMINI.md (Global Rules)..." -ForegroundColor Green
Copy-Item -Path "$PSScriptRoot\GEMINI.md" -Destination "$geminiRoot\GEMINI.md" -Force

Write-Host "[2/3] Installing config.json (Settings & Guardrails)..." -ForegroundColor Green
Copy-Item -Path "$PSScriptRoot\config\config.json" -Destination "$configDir\config.json" -Force

Write-Host "[3/3] Installing zero-setup skills..." -ForegroundColor Green
Get-ChildItem -Path "$PSScriptRoot\config\skills" -Directory | ForEach-Object {
    $targetSkill = Join-Path $skillsDir $_.Name
    Copy-Item -Path $_.FullName -Destination $targetSkill -Recurse -Force
    Write-Host "  + Installed skill: $($_.Name)" -ForegroundColor Gray
}

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host " [Success] Antigravity 설정 이식이 완료되었습니다!" -ForegroundColor Green
Write-Host " Antigravity 앱을 완전히 재시작(Reload)해 주세요." -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
