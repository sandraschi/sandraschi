# Fleet Dev Stack

> **Disclaimer: very technical.** This page is for developers building or maintaining fleet repos. Nontechnical readers: stop here and go back to [Why so many repos?](WHY_FLEET.md). What follows is the full inventory of tools, libraries, infra, patterns, and accumulated docs the fleet runs on.

---

## Contents

- [Docs hub and standards library](#docs-hub-and-standards-library)
- [Backend: FastMCP starter](#backend-fastmcp-starter)
- [Frontend: React, TS, shadcn recipe](#frontend-react-ts-shadcn-recipe)
- [Desktop: Tauri and NSIS](#desktop-tauri-and-nsis)
- [Linters and quality gates](#linters-and-quality-gates)
- [Tests: scaffolds plus e2e CUA](#tests-scaffolds-plus-e2e-cua)
- [CI and CD](#ci-and-cd)
- [Bug and pitfall depots](#bug-and-pitfall-depots)
- [Discord and automated reporting](#discord-and-automated-reporting)
- [Keeping up with the Joneses](#keeping-up-with-the-joneses)
- [Packaging and distribution](#packaging-and-distribution)
- [Conventions that hold it together](#conventions-that-hold-it-together)

---

## Docs hub and standards library

Two repos carry the accumulated knowledge:

- **[documentation-mcp](https://github.com/sandraschi/documentation-mcp)** - the docs server: project specs (including the [sandrafleetbot buildout plan](https://github.com/sandraschi/documentation-mcp/blob/main/docs/projects/sandrafleetbot/README.md)), audits, reports, per-repo docs served over MCP and the dashboard.
- **mcp-central-docs** - the standards library. 130+ files under `standards/`, and agents must read before coding. The load-bearing ones:
  - `AGENT_PROTOCOLS.md` / `AGENTS.md` - the protocol tree, tool routing, naming, critical don'ts
  - `TOOL_DESIGN_STANDARDS.md` - portmanteau tools, Prefab UI cards, pagination, no stub tools
  - `WEBAPP_SOTA_STANDARDS.md` - the catch-them-all page list, dark theme, LLM settings
  - `TAURI_PRODUCTION_PITFALLS.md` - the NSIS build gate checklist (sections A-J, mandatory pre-build audit)
  - `NAKED_PC_INSTALL_STANDARD.md` / `START_SCRIPT_STANDARD.md` - start.ps1 Require-Command, winget, start.bat wrapper
  - `MCPB_PACKAGING_STANDARDS.md` / `PACKAGING_STANDARDS.md` - two-track distribution, prompts 3-4-100 rule
  - `RAG_OPERATIONS_STANDARD.md`, `FLEET_CROSSCONNECT_STANDARD.md`, `LOCAL_LLM_STANDARDS.md`, `ONBOARDING_STANDARD.md`
  - `TRAPS_AND_PITFALLS.md`, `BUGS_DEPOT.md` (under `troubleshooting/`) - every found bug lands here (see below)
  - `FLEET_PROMOTION.md`, `RELEASE_TIERS.md`, `GITIGNORE_STANDARDS.md`, `TESTING_GUIDE.md`

New-repo gate: scaffolding a server means reading the gate list first and building to assfix-zero (first assessment finds nothing CRITICAL or HIGH). No runt scaffolds.

## Backend: FastMCP starter

- **FastMCP 3.4.x** (floor 3.4.4 for new repos, never downgrade). Portmanteau pattern: one tool per domain with an `operation` enum, not 40 loose tools. Dialogic returns (`success, message, data` plus next steps). Lifespan with shallow connectivity probe. Prefab cards on list/status/stats tools. No stubs - unimplemented ops raise, never pretend.
- **Python via uv**, `justfile` recipes (`bootstrap, lint, fix, test, serve, certify, mcpb-pack`), `start.ps1` + `start.bat` at every repo root, `.env` single source of truth with `.env.example` committed.
- **Skills per repo**: `skills/<name>/SKILL.md` (e.g. yahboom-operator, yahboom-robots-expert) - the bespoke domain expertise the chat page and agents ingest.
- **Local LLM wiring**: cline-mcp and local-llm-mcp default to Ollama / Muse Glimmer; cloud providers sit behind the gateway as capped fallback. Details: [Local LLM Stack](LOCAL_LLM_STACK.md).

## Frontend: React, TS, shadcn recipe

Every webapp, same stack (verified in-tree, e.g. yahboom dashboard):

- **React 19 + Vite + TypeScript + Tailwind**, React Router, dark Slate/Zinc only.
- **shadcn recipe**: Radix UI primitives + class-variance-authority + clsx + tailwind-merge. No Bootstrap, no jQuery, no light mode.
- **Zustand** stores (`store/llm.ts` + provider lib), **Framer Motion**, **Lucide** icons, **three.js** where 3D is needed.
- **Catch-them-all pages** (gate, not suggestion): Dashboard hero + KPIs, Inbox, Tools, Skills, Chat, Settings (LLM), Help, Logs, plus domain pages. Thin outbox-plus-stub-Settings webapps fail the gate. Tool lists are discovered from the MCP server, never hardcoded.
- Adjacent port pairs (backend N, frontend N+1), all registered in `operations/WEBAPP_PORTS.md` before allocating. Forbidden: 3000, 5000, 5173, 8000, 8080.

## Desktop: Tauri and NSIS

- **Tauri 2.x** (`@tauri-apps/api` in every webapp), embedded backend, NSIS `.exe` via `just build-native`. Same UI as the webapp, double-click install, no browser.
- **Mandatory pre-build audit** against TAURI_PRODUCTION_PITFALLS.md sections A-J. Post-build, the repo's BUILD_LOG.md records failures and fixes.
- **Naked-PC bar**: installer must work on a clean Windows box (no Python/Node/uv/winget required), WebView2 bootstrapper path, clean uninstall with no orphan backends.

## Linters and quality gates

- **ruff** (Python: check + format), **Biome** (JS/TS: `biome:ci` in every package.json), **tsc --noEmit**, plus actionlint, taplo, yamllint, hadolint, shellcheck, markdownlint where they apply.
- **pyright** on the backend. Pre-commit hooks via `just bootstrap`. Full paths or manager prefixes in shell calls, never naked tool names that risk command-not-found.
- Gate rule: fix gates before you leave them. A red lint/typecheck/test gate in a repo you touched is yours now, even if you did not break it.

## Tests: scaffolds plus e2e CUA

Standard layout per repo: `tests/{unit,integration,e2e,hardware}` + conftest. No undeclared mocks - fixtures, dry-runs, and fakes must be named and documented (TESTING_GUIDE.md).

- **e2e CUA workflows**: `cua_webapp_testing` (pre-Tauri browser verification) and `cua_nsis_smoke_testing` (installed-exe smoke test) are standard paths, not exotic extras.
- **Sandbox matrix**: virtualization-mcp consumer sandboxes run the naked-PC install probe - fresh Windows VM, silent NSIS install, health checks, reboot survival, clean uninstall, reinstall-after-fix loop.
- **Verification standards**: browser verification, coverage expectations, anti-loop guards. Fakefind audits hunt hardcoded mock data and dead buttons in webapps (report-only, then fix).

## CI and CD

- Lightweight **Windows-only CI file** (`.github/workflows/ci.yml`: ruff, Biome, pytest, tsc) ships with every repo, and `just ci` runs the same gates locally.
- Honest caveat, documented in GITHUB_ACTIONS_NO_PRIVATE_CI.md: private repos keep Actions account-disabled; agents run `just ci` locally and it must pass. The CI file exists so the gates are declared and public forks get them for free.

## Bug and pitfall depots

Bugs are fleet assets. Protocol on every find-and-fix:

1. **Document** it in the relevant pitfalls doc (TAURI_PRODUCTION_PITFALLS.md, TRAPS_AND_PITFALLS.md, or troubleshooting/BUGS_DEPOT.md).
2. **Audit** all other repos for the same antipattern (fleet-wide grep).
3. **File or fix** the findings.
4. **Update the standard** if the root cause was a template or spec pattern.

A bug fixed in one repo stays half-fixed until every repo with the same antipattern is checked. Fleet skills enforce the loop: **assfix** (full assess-fix-docs-package pass per repo), **fakefind** (mock-data audit), **drift-scan** (fleet-wide triage deciding what to assfix next), **quality-check** (strategic keep/archive verdicts).

## Discord and automated reporting

Our own Discord is load-bearing infrastructure, not a chat room:

- **discord-mcp fleet bot**: weekly fleet pulse, release summaries, community listening with tone lint. Outbox pattern: enqueue -> approve -> publish, nothing posts unapproved.
- **Agent channels** (#sfb-work task boundaries, #sfb-thoughts ideas, #sfb-alerts urgent-only) carry sanitized human summaries with posting budgets. Raw state never touches third-party clouds.
- **Surge paths**: high-urgency aiwatcher items and fritz_surveil hits page the agent via hub inbox and crosspost to alerts. Morning digests (git-github breakfast sweep, aiwatcher news) land in email and Discord on schedule.

## Keeping up with the Joneses

The field moves monthly; the fleet reads instead of guessing:

- **arxiv-mcp codehunt**: repoll hits fan out to aiwatcher ingestion and agent inbox. Papers before blog posts.
- **aiwatcher-mcp**: 10+ news sources, persona-scored relevance and urgency, HTML digests, surge mode for breaking items, archival into calibre-mcp.
- **advanced-memory-mcp**: 200+ skills, RAG over the corpus, external vault search. Findings that change how we build flow back into the standards library above - that is what the library is for.
- **Six-month rule** ([About](ABOUT.md)): any opinion older than six months has probably been overtaken by events. Dated snapshots, re-check before buying hardware or copying patterns.

## Packaging and distribution

- **Two tracks**: `.mcpb` bundles (manifest, `.mcpbignore`, prompts 3-4-100 rule: system prompt >= 3000 words, user prompt >= 4000, >= 100 tool-call examples) and Tauri NSIS installers.
- **Glama.ai** presence per repo (`glama.json`), llms.txt + llms-full.txt, README/INSTALL/ONBOARDING docs stack with screenshots and Preview sections.
- Promotion follows FLEET_PROMOTION.md (no spam): wrappee GitHub discussions, forums, Goodreads where earned.

## Conventions that hold it together

Batch-size limit (max 5 files per operation), timestamped `.bak` copies before any 3+ file mutation, checkpoint commits, qualified tool paths on Windows, ASCII-only generated prose, real timestamps from the clock never from memory, NSSM restarts via the service manager never taskkill. Full list: fleet AGENTS.md. These read as bureaucracy until the first time they save a repo - then they read as experience.

---

## Next

- Nontechnical start: [Why so many repos?](WHY_FLEET.md) - [Main page](README.md)
- The agent: [Fritz](FRITZ.md) - The brain: [Local LLM Stack](LOCAL_LLM_STACK.md) - The roadmap: [Coming Next](COMING_NEXT.md)
- Standards library: [mcp-central-docs](https://github.com/sandraschi/mcp-central-docs) - Docs server: [documentation-mcp](https://github.com/sandraschi/documentation-mcp)
