# Tauri and NSIS Pitfalls

Sub-sub readme of [Dev Stack](DEV_STACK.md): why shipping a Windows .exe is the hardest gate in the fleet, and the checklist that makes it routine. Technical. Standard underneath: `TAURI_PRODUCTION_PITFALLS.md` (62 KB and growing - this page is the map, that doc is the territory).

---

## Why installers hurt

Dev runs source: `uv run` backend, Vite frontend, everything visible. The shipped app runs frozen binaries (PyInstaller onefile backend ~30-90 MB), a Tauri WebView2 frontend with a different origin, a Rust sidecar that spawns the backend, and NSIS hooks around all of it. Every seam is a failure mode the dev loop never exercises. Hence the mandatory pre-build audit: no NSIS build without walking sections A-J first.

## The A-J checklist (one line each)

- **A. Ports and naming** - one registry row per repo, no collisions, no forbidden ports.
- **B. Frontend production API** - absolute backend URL in production, never the dev proxy assumption.
- **C. Backend CORS** - open for Tauri + Tailscale + LAN origins.
- **D. `run_server.py`** - mandatory PyInstaller entry pattern (path setup before uvicorn, clean stderr).
- **E. PyInstaller spec** - backend spec per repo, frontend SPA mounted from `_MEIPASS` via StaticFiles.
- **F. Rust spawn** - `native/src/backend.rs` sidecar pattern.
- **G. Rust lifecycle** - `main.rs` start/stop, no orphan processes.
- **H. Build scripts** - sidecar + NSIS in one maintainer command.
- **I. NSIS hooks** - PREINSTALL + PREUNINSTALL. This fixes the install hang. Skipping it is the classic first-build failure.
- **J. MCP stdio vs Tauri spawn** - `app.py` must serve both without forking behavior.

Plus K (MCPB), L (release assets), M (5-minute release verify), N (frontend "Backend unreachable" connection-health standard).

## Postmortems that paid for the checklist

Each section above exists because a repo bled: **plex-mcp** (Jun 2026), **blender-mcp** (Jun 2026), **virtualization-mcp** (Jun 2026), **qcad-mcp** (Sep 2026, native exits -1, "Backend not reachable" in CUA Phase 3). Read the postmortems in the pitfalls doc before your first build - someone already paid your tuition.

## After the build

- **BUILD_LOG.md** per repo records every failure, regression, and fix. No log, no next build.
- **CUA NSIS smoke test** certifies the artifact: silent install, health, reboot survival, clean uninstall, reinstall-after-fix loop in the virtualization-mcp sandbox.
- **NSIS UX standard**: component selection where packs apply, WebView2 bootstrapper path, per-user paths, size gates.

---

## Next

- Parent: [Dev Stack](DEV_STACK.md) - Siblings: [Packaging](PACKAGING.md) (the other track), [E2E testing](E2E_WEBAPP_TESTING.md) (certification)
- Standard: mcp-central-docs `standards/TAURI_PRODUCTION_PITFALLS.md`
