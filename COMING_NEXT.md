# 🔮 Coming Next: Sovereign Fleet Intelligence

Roadmap and upcoming architectural milestones for the `sandraschi` sovereign agent fleet.

---

### sandrafleetbot: The Free, Sovereign GrokBot

[GrokBot](https://x.ai) is a marvel and a subscription: frontier agentic coding, real-time news, voice, image generation, tool use -- metered per token, cloud-locked, served to millions at once.

**Sandrafleetbot** is the inverse bet: the same job, running entirely on one consumer GPU (RTX 4090), Apache 2.0, fully private, **EUR 0 per token**. The brain is Bonsai 2 27B PQ2_0 -- 27B-class 3-bit build, tools + vision, ~12 GB resident via :11436 sidecar. Same param count as Glimmer, ~8 GB cheaper in VRAM, leaving room for 65k+ ctx, full KV, and a second specialist resident. Muse Glimmer 27B Q4 stays warm on :11439 as escalation fallback; cheap cloud midlevels (Muse Spark 1.3 contributor, GPT-6 Luna) are fallback only, never default. The hands are this fleet: **190+ MCP servers become the agent's tool surface** -- my files, my Plex, my Calibre library, my robots, my Windows control plane. No API key, no metering, no cloud round-trip, no data leaving the box.

GrokBot serves millions of users shallowly; sandrafleetbot serves one user deeply (or a dozen, on a single H200-class GPU). Same agent loop -- sense → reason → act → remember -- different economics: horizontal SaaS vs vertical sovereignty. The fleet's own glue does the rest: a private agent board + inbox (moltbot-style, self-hosted), news surge from the AIWatcher pipeline, arXiv codehunt as a second sense, and an RTX 4090 doing the thinking, the voice, and the image generation.

**Status: spec ratified, buildout in progress -- P0 (brain tier) shipped 2026-08-14, P1 (Fritz reasoning loop) shipped 2026-08-15, P2 (comm bus + bulletin board), P3 (surge + fritz_surveil triage), P4 (memory hooks + skills + cron suggestions) and P5 (Board page + Fritz console + FLEET_TOKEN + voice loop) shipped 2026-08-15.** Bonsai 2 27B PQ2_0 runs on the RTX 4090 (chat, tool-calling, vision verified -- zero cloud cost), and the fleet's agent runners default to it (opencode `bonsai/bonsai-2-27b` + `bonsai-lean`). Fritz now runs reasoning workflows end-to-end: flowforge `agent` steps spawn cline-mcp `agent_run` on bonsai, with Glimmer :11439 as escalation, results persist, hub discovery refreshes 69 servers. Plan: P0→P8 (agent loop → board/inbox → senses → memory → surfaces → channels → hardening → packs + naked-PC gate). [Spec →](https://github.com/sandraschi/documentation-mcp/blob/main/docs/projects/sandrafleetbot/README.md)

Two sub-pages carry the detail so this page stays a roadmap:
- **[Fritz](FRITZ.md)** - the inhouse universal agent: configurable YAML tasks, hub connectors, five-layer safety cage, cloud-token minimisation, WIP status.
- **[Local LLM Stack](LOCAL_LLM_STACK.md)** - hardware (16 GB NVIDIA minimum, MacBook caveat), engines (Ollama / LM Studio / llama.cpp / vLLM), and the current US vs PRC open-weight champions.

Predecessor worth knowing: **[RoboFang](ROBOFANG.md)** tried the command-center idea first (Beta, neglected). Its safety thinking and federation patterns feed this roadmap - read it before designing v2 of anything.

---
