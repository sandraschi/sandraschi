# sandraschi - Profile & Meta Control
# ----------------------------------

set shell := ["powershell", "-c"]

# This is a meta-informational orchestration layer.
# It does not assume any fleet tools are installed.

# --- 🚀 Default Dashboard ---

# Show the profile landing dashboard
@default:
    @Write-Host "--- 🛸 Antigravity: sandraschi Landing Page ---" -ForegroundColor Cyan
    @Write-Host "This repository manages your GitHub profile and fleet-wide documentation."
    @Write-Host ""
    @Write-Host "What is 'Just'?" -ForegroundColor Yellow
    @Write-Host "Just is a command runner that serves as the 'industrial substrate' for the fleet."
    @Write-Host "It allows us to centralize operations like starting servers, linting, and syncing."
    @Write-Host ""
    @Write-Host "Available Guide Recipes:" -ForegroundColor Yellow
    @just --list

# --- 🛰️ Fleet Discovery ---

# List all repositories in the Antigravity fleet
inventory:
    @Write-Host "Scanning fleet substrate..." -ForegroundColor Cyan
    @Get-ChildItem .. -Directory | Select-Object Name

# Display simple metadata for current profile documentation
status:
    @Write-Host "--- Profile Documentation Status ---" -ForegroundColor Green
    @Get-ChildItem *.md | Select-Object Name, @{Name="Size(KB)";Expression={$_.Length / 1KB}}, LastWriteTime

# --- 🧪 Documentation Quality ---

# Check markdown files for basic consistency (no dependencies)
lint:
    @Write-Host "Checking documentation handles..." -ForegroundColor Yellow
    @Get-ChildItem *.md | ForEach-Object { \
        $content = Get-Content $_.FullName; \
        if ($content -match "TODO") { Write-Host "[!] $($_.Name) contains TODOs" -ForegroundColor Red } \
        else { Write-Host "[✓] $($_.Name) is clean" -ForegroundColor Green } \
    }

# --- 🧹 Maintenance ---

# Standard cleanup for this repository
clean:
    @Write-Host "Purging temporary artifacts..." -ForegroundColor Gray
    @Remove-Item -Recurse -Force .venv, .pytest_cache -ErrorAction SilentlyContinue
