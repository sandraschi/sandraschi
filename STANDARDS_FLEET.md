# The Standards Fleet

Yes, the standards are their own meta fleet. 130+ docs with readers, writers, versioning, deprecations, and migration fallout - everything the repo fleet has, except the wrapee is *how we build*. Haha. But also serious: this page explains how the library is organized, how it evolves, and in what order to read it.

Home: [mcp-central-docs](https://github.com/sandraschi/mcp-central-docs) (`standards/`). Enforcer: every agent reads before coding; "I didn't read it" is never an accepted explanation.

---

## The groups (the fleet's districts)

- **Agent protocols** - AGENTS.md, AGENT_PROTOCOLS.md, TOOLING_COST_MODEL.md, LOCAL_LLM_FIRST_DOCTRINE.md. Who does what, with which tools, at what cost.
- **Tool design** - TOOL_DESIGN_STANDARDS.md (portmanteau, Prefab, pagination), DIALOGIC_RETURNS.md, SKILLS_ECOSYSTEM_2026.md, ai-sampling.md, ai-rag-2026.md.
- **Webapp** - WEBAPP_SOTA_STANDARDS.md, BUN_STANDARDS.md, BIOME_STANDARDS.md, REACT_HARDENING.md, APPS_PAGE_STANDARD.md, README_WEBAPP_SCREENSHOTS.md, chat/skills/Prefab rules.
- **Desktop and install** - TAURI_PRODUCTION_PITFALLS.md, NAKED_PC_INSTALL_STANDARD.md, START_SCRIPT_STANDARD.md, ONBOARDING_STANDARD.md, WINDOWS_SERVICE_STANDARDS.md.
- **Packaging and release** - PACKAGING_STANDARDS.md, MCPB_PACKAGING_STANDARDS.md, GITIGNORE_STANDARDS.md, RELEASE_TIERS.md, FLEET_PROMOTION.md, MCP_REGISTRY_PUBLISHING.md.
- **Testing and verification** - TESTING_GUIDE.md, VERIFICATION_STANDARDS.md, CUA rules (nsis/webapp smoke), playwright_e2e_sota.md, QUALITY_GATES.md.
- **Safety and git** - SAFETY_PROTOCOLS.md, GIT_REPOSITORY_SAFETY.md, GIT_WORKFLOW.md, GITHUB_ACTIONS_NO_PRIVATE_CI.md, PROMPT_INJECTION_HARDENING.md, threats/ (incl. HalluSquatting).
- **Fleet ops** - FLEET_CROSSCONNECT_STANDARD.md, FLEET_GRADING_STANDARDS.md, RAG_OPERATIONS_STANDARD.md, VOICE_COMMAND_BUS.md, JUNE_2026_STANDARDS_BAR.md (version floor, retired tools).
- **Language specifics** - POWERSHELL_STANDARDS.md (+ rules/), PY_STANDARDS.md, UV_STANDARDS.md, RUFF_STANDARDS.md, YAHBOOM_ROBOTICS_STANDARD.md, and the rules/ directory of deep dives.

## How the meta fleet evolves

Same lifecycle as the repo fleet, one level up:

1. **A repo bleeds** - qcad native exits -1, plex install hangs, sweep misfires on 204 repos.
2. **The depot records it** - postmortem or trap entry with symptoms, cause, fix ([Bug Depot Protocol](BUG_DEPOT_PROTOCOL.md)).
3. **The standard absorbs it** - checklist section, gate, or rule update. Root-cause-in-template means the template changes, not just the repo.
4. **Rollout by skill loop** - drift-scan finds holders of the old pattern, assfix migrates them in 5-file batches.
5. **Retirement** - JUNE_2026_STANDARDS_BAR.md records version floors and retired tools so nobody follows dead guidance (see also the six-month rule in [About](ABOUT.md)).

Standards are versioned by git history like everything else. Breaking changes go through the same `.bak`-and-checkpoint discipline as code - the library has its own backup files to prove it.

## Reading order

- **First contact (mandatory 13)**: the Primary Read List - JUNE_2026_STANDARDS_BAR, AGENTS.md, GIT_REPOSITORY_SAFETY, TOOL_DESIGN_STANDARDS, STARLETTE_NO_PYDANTIC_STANDARD, NAKED_PC_INSTALL_STANDARD, PACKAGING_STANDARDS, MCPB_PACKAGING_STANDARDS, TAURI_PRODUCTION_PITFALLS, tauri_nsis_building, WEBAPP_SOTA_STANDARDS, VERIFICATION_STANDARDS, BUGS_DEPOT.
- **New MCP server**: the New Repo Gate list (18 standards + ship checklist) - build to assfix-zero in one pass.
- **Domain work**: pick the district above (PowerShell, Tauri, RAG, robotics...) and read that shelf only.
- **Something broke**: BUGS_DEPOT symptom lookup first, TRAPS_AND_PITFALLS second, full doc third.

---

## Next

- Parent: [Dev Stack](DEV_STACK.md) - Library: [mcp-central-docs](https://github.com/sandraschi/mcp-central-docs)
- Enforcement arm: [Bug Depot Protocol](BUG_DEPOT_PROTOCOL.md) - Consumer: every agent, every session
