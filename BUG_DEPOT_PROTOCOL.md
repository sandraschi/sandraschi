# Bug Depot Protocol

Sub-sub readme of [Dev Stack](DEV_STACK.md): what happens after a bug is found and fixed. Technical. The core insight: a bug fixed in one repo stays half-fixed until every repo with the same antipattern is checked.

---

## The four steps (mandatory)

1. **Document** it in the relevant depot: `TAURI_PRODUCTION_PITFALLS.md` for installer/build bugs, `TRAPS_AND_PITFALLS.md` for general traps, `troubleshooting/BUGS_DEPOT.md` for fleet-wide symptom lookup.
2. **Audit** all other repos for the same antipattern - fleet-wide grep across `D:\Dev\repos\`. The fix author runs the search, not "someone later".
3. **File or fix** the findings - at minimum log as issues, ideally fix on the spot (batch gates apply: max 5 files per operation, `.bak` copies first).
4. **Update the standard** if the root cause was a template or spec pattern, so new repos never grow the bug in the first place.

Skip step 2 and the fleet collects the same bug in twelve repos. This has happened. That is why the protocol exists.

## The depots

| Depot | Holds | Grows via |
|---|---|---|
| `TAURI_PRODUCTION_PITFALLS.md` (62 KB) | Installer/build failures, sections A-N checklist, per-repo postmortems (plex, blender, virtualization, qcad) | Every NSIS build + BUILD_LOG.md per repo |
| `TRAPS_AND_PITFALLS.md` (100 KB) | Numbered traps: temporal grounding, NSSM restarts, ASCII hygiene, HalluSquatting, batch limits... | Every agent session that hits one |
| `troubleshooting/BUGS_DEPOT.md` | Symptom lookup: known bugs, fleet-wide issues, fixes | Every find-and-fix |
| `audits/` + `logs/` (per hub repo) | Gate-sweep CSVs, pitfall scans, cold-install reports | Automated sweeps |

## The skill loop that enforces it

- **drift-scan** - fleet-wide triage: which repos deviate, what to assfix next. The decider, not a fixer.
- **assfix** - full assess-fix-docs-package pass on one repo, against current standards.
- **fakefind** - mock-data and dead-button audit of webapps (report-only, then fix).
- **quality-check** - strategic verdict: promote, archive, or deprecate the repo.

## Cautionary tale: the 204/205 FAIL sweep

A 2026-08 gate sweep reported 204 of 205 repos failing. Investigation showed the sweep itself was broken: pyright/Biome gates ran on repos without those deps, the ruff 0.16 migration fallout counted as failures, and "no tests ran" counted as FAIL. Lesson now encoded in the standards: sweeps audit against *declared* gates per repo, migrations go in small batches, and a red dashboard means "check the dashboard" before "fix 204 repos". The artifact analysis lives with the audit CSVs.

---

## Next

- Parent: [Dev Stack](DEV_STACK.md) - Siblings: [E2E testing](E2E_WEBAPP_TESTING.md), [Tauri pitfalls](TAURI_NSIS_PITFALLS.md)
- Skills: assfix, fakefind, drift-scan, quality-check (fleet skill registry)
