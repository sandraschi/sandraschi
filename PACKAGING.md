# Packaging: .mcpb Bundles and NSIS Installers

Sub-sub readme of [Dev Stack](DEV_STACK.md): the two tracks that carry a repo to users. Technical. Standards underneath: `MCPB_PACKAGING_STANDARDS.md`, `PACKAGING_STANDARDS.md`, `GITIGNORE_STANDARDS.md`, `RELEASE_TIERS.md`.

---

## Two tracks, different jobs

| Track | Artifact | User | Install |
|---|---|---|---|
| MCPB bundle | `*.mcpb` (manifest + src + prompts + skills) | Agent/IDE users (Claude Desktop, Cursor, opencode) | 1-click import, server registers its tools |
| NSIS installer | `*_x64-setup.exe` | Humans on Windows | Double-click, Tauri winapp, no Python/Node/uv required |

A repo can ship either or both. The MCPB carries the agent face, the NSIS carries the human faces.

## The .mcpb bundle

Layout: manifest, `src/` (fresh copy, see below), `assets/prompts/` (system, user, examples), `assets/skills/`, `.mcpbignore`, icons and metadata (`glama.json` alongside for the Glama.ai listing).

- **`.mcpbignore` is mandatory.** Must exclude `.venv/`, `node_modules/`, `webapp/`, `src-tauri/`, `tests/`, `data/`, `target/`, build artifacts, `*.bak` and `*.bak.*`. Packing a venv or node_modules into a bundle is a gate fail.
- **Wipe and recopy before pack.** The pack script deletes `mcpb/src/` and recopies from `src/` immediately before `mcpb pack`. Gitignore alone does not stop a stale local twin from shipping.
- **`mcpb/src/` is never committed.** Exact copy of `src/`, staging only. Same for `*.mcpb` binaries.

## Prompts 3-4-100 (the anti-runt rule)

Bundles with stub prompts are rejected. Verified by word count plus JSON length before pack:

- `assets/prompts/system.md` >= 3,000 words
- `assets/prompts/user.md` >= 4,000 words
- `assets/prompts/examples.json` >= 100 tool-call example objects

TODO prompts are a gate fail. The rule exists because a bundle is often the first contact a new agent has with the repo - thin prompts mean a dumb agent.

## Release tiers and size gates

- Tiers per RELEASE_TIERS.md: what ships to Glama, what ships to GitHub Releases, what stays local.
- Size gates on NSIS output (installer bloat fails the build), clean uninstall with no orphan backends, per-user paths (no hardcoded `D:\Dev\repos`).
- Every repo carries llms.txt + llms-full.txt, README/INSTALL/ONBOARDING, docs/screenshots + README Preview. Promotion follows FLEET_PROMOTION.md (earned posts, no spam).

---

## Next

- Parent: [Dev Stack](DEV_STACK.md) - Sibling: [Tauri and NSIS pitfalls](TAURI_NSIS_PITFALLS.md) (the build that produces the .exe)
- Standards: mcp-central-docs `standards/MCPB_PACKAGING_STANDARDS.md`, `PACKAGING_STANDARDS.md`, `RELEASE_TIERS.md`
