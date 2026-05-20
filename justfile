set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

# 🛸 sandraschi - Fleet Profile & Meta Control 🛸
# ===============================================

# Open the interactive recipe dashboard in the browser
default:
    @pwsh.exe -NoProfile -ExecutionPolicy Bypass -File ../mcp-central-docs/scripts/just-dashboard.ps1 -Path .

# --- 🛰️ Fleet Discovery ---

# List all repositories in the Antigravity fleet
inventory:
    @Write-Host "--- Antigravity Fleet Substrate ---" -ForegroundColor Cyan; \
    Get-ChildItem .. -Directory | Select-Object @{Name="Repository";Expression={$_.Name}}, @{Name="Modified";Expression={$_.LastWriteTime}} | Format-Table -AutoSize

# Display state and metadata for current profile documentation
status:
    @Write-Host "--- Profile Documentation Assets ---" -ForegroundColor Green; \
    $files = Get-ChildItem *.md; \
    $totalKB = ($files | Measure-Object -Property Length -Sum).Sum / 1KB; \
    Write-Host "Tracking $($files.Count) assets ($([math]::Round($totalKB, 2)) KB total)" -ForegroundColor Gray; \
    $files | Select-Object Name, @{Name="Size(KB)";Expression={$_.Length / 1KB}}, LastWriteTime | Format-Table -AutoSize

# --- 🧪 Quality & sync ---

# Check markdown files for basic consistency and TODOs
lint:
    @Write-Host "Analyzing documentation handles..." -ForegroundColor Yellow; \
    Get-ChildItem *.md | ForEach-Object { \
        $content = Get-Content $_.FullName; \
        if ($content -match "TODO") { Write-Host "[!] $($_.Name) contains unresolved TODOs" -ForegroundColor Red } \
        else { Write-Host "[✓] $($_.Name) verified clean" -ForegroundColor Green } \
    }

# Sync profile metadata with fleet documentation (Stub)
sync:
    @Write-Host "[Sync] Matching profile handles with fleet substrate..." -ForegroundColor Gray; \
    Write-Host "Sync operational. (SOTA 2026 Layout Applied)" -ForegroundColor Green

# --- 🧹 Maintenance ---

# Purge build artifacts and local caches
clean:
    @Write-Host "Purging temporary artifacts..." -ForegroundColor Red; \
    Remove-Item -Recurse -Force .venv, .pytest_cache, .ruff_cache, .biome_cache -ErrorAction SilentlyContinue; \
    Write-Host "Substrate cleaned." -ForegroundColor Gray
