# Play / Know / Home

Sound and video, memory and research, everyday life. Same pattern as [Make / Move / Meet](FLEET_MAKE_MOVE_MEET.md): one wrapped thing per repo, human dashboard each, optional links between neighbours.

Start with [Why so many repos?](WHY_FLEET.md). Full index: [MCP Catalog](MCP_CATALOG.md).

---

## Contents

- [Play: sound, DJ, video](#play-sound-dj-video)
- [Know: memory, books, papers, proofs](#know-memory-books-papers-proofs)
- [Home: media, house, Vienna](#home-media-house-vienna)

---

## Play: sound, DJ, video

For working musicians, mobile DJs, and VJs - not club-install fantasies.

| Repo | What it wraps | When you want it |
|---|---|---|
| [mixx-dj-mcp](https://github.com/sandraschi/mixx-dj-mcp) + [mixxxxx](https://github.com/sandraschi/mixxxxx) | Mixxx DJ + experimental fork | Decks, OSC, BPM sync; fork adds video, ButterChurn visuals, local stem separation |
| [stems-mcp](https://github.com/sandraschi/stems-mcp) | HTDemucs v4 (ONNX, local GPU) | Vocals / drums / bass as separate decks, no cloud round-trip |
| [resolume-mcp](https://github.com/sandraschi/resolume-mcp) | Resolume Arena | NDI video from the DJ rig to venue projection mapping |
| [butterchurn-mcp](https://github.com/sandraschi/butterchurn-mcp) | ButterChurn / MilkDrop | Audio-reactive WebGL visuals for the projector or stream |
| [reaper-mcp](https://github.com/sandraschi/reaper-mcp) | REAPER DAW | Tracks, FX, render queue; sound FX for robots too |
| [virtualdj-mcp](https://github.com/sandraschi/virtualdj-mcp) | VirtualDJ | Alternate deck control when the gig rider says so |
| [obs-mcp](https://github.com/sandraschi/obs-mcp) | OBS Studio | Scenes and stream control for the Twitch version of the night |
| [davinci-resolve-mcp](https://github.com/sandraschi/davinci-resolve-mcp) | DaVinci Resolve | Post-production and color after the gig |
| [suno-mcp](https://github.com/sandraschi/suno-mcp) / [songgeneration-mcp](https://github.com/sandraschi/songgeneration-mcp) | Suno / song gen | Sketch tracks and lyrics before the studio |

Deep dive (separate page, not inlined): [Fleet Highlights](HIGHLIGHTS.md) - the 5,000-line C++ fork story and why upstream did not have to carry it.

## Know: memory, books, papers, proofs

Research you can ask questions of.

| Repo | What it wraps | When you want it |
|---|---|---|
| [advanced-memory-mcp](https://github.com/sandraschi/advanced-memory-mcp) | Zettelkasten + RAG (LanceDB) | 200+ skills, conversational recall, the fleet's long-term memory |
| [calibre-mcp](https://github.com/sandraschi/calibre-mcp) | Calibre ebooks (13k) | Full-text + semantic search over your own library |
| [arxiv-mcp](https://github.com/sandraschi/arxiv-mcp) | arXiv papers | Search, full text, citation trace, ingest into memory |
| [aiwatcher-mcp](https://github.com/sandraschi/aiwatcher-mcp) | News + fleet observability | Daily digest to email, breaking-news TTS, archive to Calibre |
| [leanforge-mcp](https://github.com/sandraschi/leanforge-mcp) | Lean 4 proofs | LLM proposes, compiler verifies, loop until proven. No math degree needed |
| [obsidian-mcp](https://github.com/sandraschi/obsidian-mcp) | Obsidian vault | Read/write notes programmatically |

Pipeline: aiwatcher spots a paper, arxiv fetches it, Calibre finds the cited book chapter, memory links both into the graph. Nobody hired a librarian.

## Home: media, house, Vienna

The unglamorous half that earns its keep daily.

| Repo | What it wraps | When you want it |
|---|---|---|
| [plex-mcp](https://github.com/sandraschi/plex-mcp) / [jellyfin-mcp](https://github.com/sandraschi/jellyfin-mcp) | Plex / Jellyfin | Library curation without the click marathon |
| [devices-mcp](https://github.com/sandraschi/devices-mcp) / [home-assistant-mcp](https://github.com/sandraschi/home-assistant-mcp) | Smart home / Home Assistant | One grid for plugs, lights, doorbell alerts to voice |
| [alexa-mcp](https://github.com/sandraschi/alexa-mcp) / [speech-mcp](https://github.com/sandraschi/speech-mcp) | Alexa / TTS+STT gateway | Command routing in, spoken readouts out ("render done", "intrusion alert") |
| [mywienerlinien](https://github.com/sandraschi/mywienerlinien) | Wiener Linien transit | Real-time departures for the 9th District |
| [email-mcp](https://github.com/sandraschi/email-mcp) / [discord-mcp](https://github.com/sandraschi/discord-mcp) | Email / Discord | Digests in, approvals out, community listening with tone lint |
| [immich-mcp](https://github.com/sandraschi/immich-mcp) | Immich photos | Self-hosted photo grid, Benny pictures included |
| [nuki-mcp](https://github.com/sandraschi/nuki-mcp) / [ring-mcp](https://github.com/sandraschi/ring-mcp) / [tapo-mcp](https://github.com/sandraschi/tapo-mcp) | Nuki lock / Ring / Tapo | Door, camera, plugs - each optional, each dashboarded |

---

## Advanced flows: three repos at full power

This is the section that would turn the main page into a leporello, so it lives here. Each flow shows both sides: what the agent does through MCP, what you do in the webapp or Tauri winapp.

### docker-mcp: your containers with an agent on call

Repo: [docker-mcp](https://github.com/sandraschi/docker-mcp). Three faces: MCP control plane, React dashboard, NSIS Windows installer (`just build-native`, run the `-setup.exe`).

- **You see:** containers, images, volumes, networks, Compose projects. Overview page has quick actions: Run MCP tools, Diagnose, Backup, Recover Docker. A `/tools` runner (pick a tool, fill the form, Run) plus volumes, networks, compose, and AI chat pages.
- **The agent does:** "List all running containers and show resource usage." "Compare nginx:1.25 and nginx:1.26 - what changed?" "Back up my database volume before the upgrade." "Analyze container my-app - why is it restarting?" That last one is logs plus stats plus health analysis, summarized in plain words.
- **Typical morning:** stale-image list for pruning, crash-log trawl on anything restarting, Compose health check after deploy. Human approves the prune and the backup in the dashboard.

### git-github-mcp: the morning sweep

Repo: [git-github-mcp](https://github.com/sandraschi/git-github-mcp). Backend `:10713`, frontend `:10714`. Onboarding is `gh auth login`, nothing else.

- **You see:** repo hero with KPIs and stars glance, recent changes, CI tiles (success/failed with log tails), stars boards with stargazer trajectory, lectures and help pages.
- **The agent does:** "List open PRs across my repos that went stale this week." Maintainer autopilot (`/breakfast`): morning digest, stale flags, 15 fleet ops plus full suite. CI monitor: rerun plus AI diagnose on failures.
- **Typical morning:** open the dashboard, read the digest, click through stale PRs and failed runs, approve or rerun. The sweep is the product - raw `git log` never gave you that.

### aiwatcher-mcp: news in, digest out, Discord included

Repo: [aiwatcher-mcp](https://github.com/sandraschi/aiwatcher-mcp). Backend `:10946`, frontend `:10947`. Polls 10+ AI news sources (RSS/Atom, Gmail newsletters, ArXiv, Readly), scores every item for relevance and urgency with your persona, distills on a schedule (default every 4 hours).

- **You see:** dashboard with KPIs and manual Poll / Distill / Alerts, bundles with health panel, scheduled runs plus pipeline liveness, source list with feed health, log ring buffer.
- **The agent does:** poll feeds, distill pending items, check alerts, generate the HTML digest. Breaking items fire cross-fleet TTS wake-ups; the daily digest goes out via email-mcp and archives into calibre-mcp.
- **Discord:** opt-in. Set the discord-mcp URL and digest channel and the summary posts to your guild. Approval-gated like everything else - drafts sit until you say yes.
- **Typical morning:** digest in your inbox, top items on the Intel hub for iPad reading, nothing to configure unless a feed goes stale (the health panel tells you).

---

Next: [Make / Move / Meet](FLEET_MAKE_MOVE_MEET.md) - [Why the fleet](WHY_FLEET.md) - [Coming Next](COMING_NEXT.md) (local agent plan, separate page) - [Workshop](WORKSHOP.md)
