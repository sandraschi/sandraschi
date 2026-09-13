# Fritz: the Inhouse Universal Agent

Fritz is the fleet's own agent. Not a chatbot, not a demo: the reasoning loop that senses, decides, acts, and remembers across all 190 repos. Work in progress, running daily, heading toward [sandrafleetbot](COMING_NEXT.md) - the free local GrokBot. Technical spec: [sandrafleetbot README](https://github.com/sandraschi/documentation-mcp/blob/main/docs/projects/sandrafleetbot/README.md).

---

## What Fritz is

One agent with the whole fleet as hands. News comes in via aiwatcher, code leads via arxiv codehunt, fleet health via fritz_surveil; Fritz reasons over them with the local model, acts through the hub tool router (any of ~190 MCP wrappers), and writes everything to the board, the inbox, and the agent diary. Surfaces for humans: hub Board page, Fritz console webapp (:10997), Intel Hub digest, Discord channels with sanitized summaries, and a spoken morning briefing.

Repo: [fleet-agent-mcp](https://github.com/sandraschi/fleet-agent-mcp). Status: reasoning loop, comm bus, senses, memory, and surfaces shipped Aug 2026 (P0-P5). Channels, hardening, and packs follow (P6-P8).

## Tasks: configurable YAML workflows

Fritz does not improvise its job description. Work is declared as YAML workflows: steps, branches, schedules.

- **Coworker flows** (9 scheduled): fleet pulse reports, heartbeat wakeups, recurring checks.
- **Agent steps**: a workflow step can spawn a coding agent (cline-mcp `agent_run`) on the local model; its JSON output feeds the next step. E2E verified: agent run -> report composed by the model, not a template.
- **fritz_contribute**: clone -> lint -> issue -> branch -> fix -> PR. End-to-end agentic PRs on test repos.
- **fritz_surveil**: triage engine over two domains (external news, fleet logs and health). Restart loop 3x in 10 min -> urgent. Transition-aware: it fires when a healthy server goes bad, not for permanently dead ones (that is registry hygiene, not an alert).
- **Memory hooks**: every agent task ends with a memory note plus a diary entry. Repeated manual asks auto-suggest a cron schedule after 3 in 7 days. Skills are first-class memory cards.
- **Voice loop**: wake word -> briefing spoken aloud -> report on the board. Verified live, fully local.

## Connectors: everything through the hub

Fritz never calls servers directly. One rule: the hub is the only registry and the only tool router.

- **Tool router**: `POST /api/v1/tools/call` reaches fileops, winops, gitops, plex, robots, blender, email, discord - the whole fleet.
- **Senses**: aiwatcher surge (urgency >= 8.5 pages Fritz immediately), arxiv codehunt, device telemetry.
- **Comms**: board (broadcast + archive), inbox (addressed delivery), agent diary (queryable record), Discord mirror (#sfb-work, #sfb-thoughts, #sfb-alerts).
- **Memory**: memops knowledge graph, zettel notes, RAG, skills.

## Safety: the crucial part

An agent with hands in your files, robots, and accounts must be caged. Fritz is caged five ways:

1. **Confirmation gates.** Destructive actions keep SOUL policy checks, workflow branches, and DESTRUCTIVE annotations. The agent proposes; the human approves in the dashboard.
2. **No raw data on third-party clouds.** Discord carries sanitized human summaries only - never tool output, tokens, paths, or credentials. Raw state stays in board and diary on the box.
3. **Posting budgets.** Max 2 posts per task, 1 thought per hour per agent, alerts only on real thresholds. Routine success stays on the board.
4. **Auth boundary.** FLEET_TOKEN on hub management endpoints; single-tenant by design. Multi-user isolation is explicit future work, not an accident waiting to happen.
5. **Transition-aware alerting.** Alerts fire on change (healthy -> bad), with 60-minute dedupe and escalation override. No alert storms.

## Cloud tokens: minimised and capped

Local-first is a rule, not a preference: ALL inference routes to Ollama / llama.cpp / LM Studio. Cloud is a documented fallback only.

- **Fast tier**: a small local distil (9B class) handles triage and routine steps; the 30B brain wakes for real reasoning.
- **Truncating proxy**: oversized requests are trimmed and tools whitelisted before they reach the model.
- **Spend watch**: cloud fallback budget under $20/month with threshold alerts. Monthly cloud spend target: EUR 0, or a documented exception.

## Segue: Fritz grows into sandrafleetbot

Fritz is the agent; sandrafleetbot is the product around it (operator shell, install packs, channels, naked-PC installer). Same loop - sense -> reason -> act -> remember - same zero-token economics, packaged for one user deeply instead of millions shallowly. Roadmap: [Coming Next](COMING_NEXT.md). The brain it runs on: [Local LLM Stack](LOCAL_LLM_STACK.md).

## Backlog: the filcher (star-velocity scout)

Motivation: had this run last January, OpenClaw's hundreds-of-stars-a-day takeoff would have hit the morning report months before the MSM noticed. Never again. Filchy filch filch.

- **Sources.** GitHub's own trending lists (daily/weekly, scraped) plus Search API queries (`created:>` recent + `stars:>` threshold, sorted by stars). Trending catches velocity, search catches accumulation. Authenticated search budget: 30 req/min - schedule accordingly, cache aggressively.
- **Velocity store.** Daily star snapshots per watched repo in SQLite (same pattern as the digest state). Velocity = delta, not total. A 200-star repo gaining 150/day outranks a 10k-star repo gaining 5. Transition-aware alerting, same as fritz_surveil: fire on change in velocity tier, dedupe 60 min. Prior art in-fleet: [gitee-mcp](https://github.com/sandraschi/gitee-mcp)'s humming radar already tracks momentum and surge on the PRC forge - the filcher generalizes the pattern to GitHub trending plus search.
- **Triage (local model).** For each hit: what it does, fleet overlap (which of our repos it threatens or teaches), filch-worthy features (concrete capabilities, not vibes), license check (MIT = fair game with attribution; anything else = hands off, note why).
- **MSM cross-check.** aiwatcher companion query: has mainstream coverage hit yet? Covered = follow fast. Not covered = early window, read deeper.
- **Output.** Morning filch report on the board + Discord #sfb-thoughts: repo, velocity graph, overlap map, top-3 filch candidates with file pointers. Approval-gated clone for gap analysis (git-github-mcp connected for search + clone + read). Human picks what gets filched; Fritz never auto-ports.
- **Where it lives.** Sibling to fritz_surveil (external-news domain extended to repo velocity), git-github-mcp for search/clone primitives, aiwatcher for the MSM check. Gallery entry: [Sneaky Feats](SNEAKY_FEATS.md).
