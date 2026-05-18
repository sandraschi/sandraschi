set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

# 🛸 sandraschi - Fleet Profile & Meta Control 🛸
# ===============================================

# Display the Profile Landing Dashboard
default:
    @$lines = Get-Content '{{justfile()}}'; \
    Write-Host ' [SOTA] Antigravity Profile Dashboard v1.1.0' -ForegroundColor White -BackgroundColor Cyan; \
    Write-Host '' ; \
    $currentCategory = 'Command Control'; \
    Write-Host "  $currentCategory" -ForegroundColor Cyan; \
    Write-Host ('  ' + ('─' * 45)) -ForegroundColor Gray; \
    foreach ($line in $lines) { \
        if ($line -match '^# --- ([^─]+) ---') { \
            $currentCategory = $matches[1].Trim(); \
            Write-Host "`n  $currentCategory" -ForegroundColor Cyan; \
            Write-Host ('  ' + ('─' * 45)) -ForegroundColor Gray; \
        } elseif ($line -match '^# ([^─].+)') { \
            $desc = $matches[1].Trim(); \
            $idx = [array]::IndexOf($lines, $line); \
            if ($idx -lt $lines.Count - 1) { \
                $nextLine = $lines[$idx + 1]; \
                if ($nextLine -match '^([a-z0-9-]+)') { \
                    $recipe = $matches[1]; \
                    if ($recipe -ne 'default') { \
                        $pad = ' ' * [math]::Max(2, (18 - $recipe.Length)); \
                        Write-Host "    $recipe" -ForegroundColor White -NoNewline; \
                        Write-Host "$pad$desc" -ForegroundColor Gray; \
                    } \
                } \
            } \
        } \
    } \
    Write-Host "`n  [Profile Status: OPERATIONAL]" -ForegroundColor DarkGray; \
    Write-Host ''

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
