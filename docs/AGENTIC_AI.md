# The Agentic Revolution

> **TL;DR** — I design the architecture and judge the output. AI generates the code.
> This fleet of 130+ MCP servers is built by one person because agentic coding collapsed
> the gap between what I can design and what I can implement. Everything here runs daily.
> It's not demos.

- [What changed](#what-changed)
- [Current tool stack](#current-tool-stack-june-2026)
- [Keeping 130+ repos coherent](#keeping-130-repos-coherent)
- [The remaining challenges](#the-remaining-challenges)
- [The mesh: what 150+ MCP servers can do](#the-mesh-what-150-mcp-servers-can-do-when-they-talk-to-each-other)
- [Further reading](#further-reading)

## What changed

In early 2026, agentic coding quality crossed a threshold. The repositories in this fleet
are **human-architected, AI-implemented** — architecture, integration patterns, and aesthetic
choices are mine. The code is generated and iterated by AI agents under my direction.

The human job shifted from typing to thinking. Architecture, taste, judgment, knowing when
the output is wrong. The agent handles syntax, plumbing, tests, formatting, and the grind
work that used to be 80% of the job.

## Current Tool Stack (June 2026)

The stack has three layers: editor, model, and the bridge between them.

| Layer | Tool | Role |
|-------|------|------|
| **Editor** | [Cursor Ultra](https://cursor.com) or [opencode](https://github.com/anomalyco/opencode) | Cursor when the deal is good (currently 50% off). opencode as the permanent free fallback. Both are MCP-aware[^mcp]; the IDE choice matters less than the model behind it. |
| **Primary model** | [DeepSeek v4](https://openrouter.ai/deepseek/deepseek-v4) via OpenRouter | Daily driver. Fractions of a cent per million tokens. 1M+ context window[^contextwindow]. Code quality at parity with Claude Opus 4 on architecture/refactoring, better at bulk generation. Text-only. |
| **Premium model** | [Anthropic Fable 5](https://anthropic.com) | Temporary freebie (free until June 22, 2026). Outstanding quality — used for planning and complex architectural reasoning. Gets replaced when the deal ends. |
| **Deal-driven** | Claude (Fable 5 freebie) | Temporary free tier — used while it lasts, dropped when it ends. The stack is fluid by design. |
| **Local fallback** | RTX 4090, 24 GB VRAM | DeepSeek v4 INT4 quant fits. Distilled models expected soon — then the entire stack runs **zero-cloud**[^zerocloud] (no token costs, no subscriptions). |

**Strategy: ride the deals.** Use what's best at the best price, switch when the deal
changes. Cursor Ultra + Fable 5 today. opencode + DeepSeek v4 when deals lapse. Local
RTX 4090 when distilled models land. Decouple editor from model — that's the durable
setup. The stack is fluid by design; only the separation of concerns is permanent.

**Why this matters:** 2026 is the year of the cloud token cost explosion. Enterprises
that bet everything on GPT-4/Claude Opus API calls are seeing bills that make CFOs
choke — tokenmaxxing[^tokenmax] every prompt, chasing leaderboard[^leaderboard] scores, CTOs publicly pumping
the brakes. The fleet sidestepped this entirely by design: DeepSeek v4 at fractional-cent
pricing, deal-driven premium access, and a local GPU path that will eventually eliminate
cloud costs altogether. The trap was obvious from the start: don't build your stack on
a meter that runs $0.15 every time you tab-complete.

## Keeping 130+ repos coherent

A fleet this size doesn't stay healthy by accident. Every repo follows the same
playbook: same tooling (FastMCP 3.2, uv, Ruff, justfile), same response patterns
(dialogic returns with message + next_steps), same startup scripts (start.ps1),
same CI (ruff + pytest), same Tauri NSIS installer template. The fleet standard
lives in `mcp-central-docs/standards/` and is enforced by linting and code review —
the agent is told "comply with fleet standards" and it does, because the standards
are documented, not tribal.

The failure mode is not code quality. The model produces solid code when the
architecture is well-specified. The failure mode is **context drift**[^contextdrift] — an agent
that worked perfectly on one repo starts hallucinating because it lost track of
the constraints. The answer is aggressive context management (compact, /clear,
spec-first planning) and not pretending agents have infinite memory.

## The remaining challenges

The 2023–2024 critique of AI code (hallucinated APIs, confident wrongness) is
largely solved by agentic loops — the model reads its output, tests it, fixes
failures, iterates. What replaces it are subtler issues:

- **Volume asymmetry**: generating a PR takes seconds, reviewing it takes an hour.
  Better automated test gates are the answer, not slowing down.
- **Context drift**: long sessions degrade. Active compaction and fresh starts help.
- **Stale PRs**: fast generation means hundreds of changes. Not all get reviewed
  promptly. The answer is smaller, focused PRs and automated CI gates.

## What this means for this fleet

130+ repos. One person. Working software, not prototypes.

That ratio wasn't possible before. The bottleneck used to be implementation bandwidth —
the gap between what you could design and what you could type. That gap is now closed.
The binding constraint is correctly: having something worth building, understanding it
well enough to direct the build, and knowing when the result is good.

The fleet is real infrastructure I use daily. The calibre RAG, the transit monitor, the
robotics bridges, the memory system — these run. They are not demos.

## The mesh: what 150+ MCP servers can do when they talk to each other

The fleet isn't a collection of isolated tools. Each server exposes its domain via FastMCP
3.2, and the MCP bridge layer lets them call each other. The result is a **composable
maker pipeline** that didn't exist before — and wouldn't exist without agentic coding.

### Maker input → CAD → Simulation → Viz + Robotics → Export

```
blender-mcp ──┐
gimp-mcp ────┤
inkscape ────┤  ┌─────────────┐   ┌──────────┐   ┌──────────┐
osc-apps ────┼──│ freecad-mcp  │──▶│ FluidX3D │──▶│ godot-mcp │
worldlabs ───┘  │  qcad-mcp   │   │ (GPU CFD)│   └─────┬────┘
                └─────────────┘   └──────────┘         │
                                                       │
vroid-mcp ──┐                                          │
avatar-mcp ─┼──────────────────────────────────────────┤
yahboom ────┤         The Maker Mesh                    │
robotics ───┤                                          │
dreame ─────┘                                          │
                                                       │
        ┌──────────┬──────────┬──────────┬─────────────┼──────────┐
        ▼          ▼          ▼          ▼             ▼          ▼
   Resonite XR  Games    Architecture  CFD/FEM      Robotics    Avatars
              (godot!)   (BIM/freecad)              (sim+real)  (VRM)
```

**Creative input layer** — [blender-mcp](https://github.com/sandraschi/blender-mcp),
[gimp-mcp](https://github.com/sandraschi/gimp-mcp), Inkscape, [worldlabs-mcp](https://github.com/sandraschi/worldlabs-mcp),
[osc-mcp](https://github.com/sandraschi/osc-mcp). These wrap professional creative tools
as MCP servers, giving an agent direct control over 3D modeling, image editing, vector
graphics, terrain generation, and real-time OSC control surfaces.

**CAD/BIM layer** — [freecad-mcp](https://github.com/sandraschi/freecad-mcp) and
[qcad-mcp](https://github.com/sandraschi/qcad-mcp). Parametric CAD and 2D/3D drafting
via MCP tools. FreeCAD handles STEP/BIM/IFC for architecture and mechanical engineering.
QCAD produces DXF/STL for fabrication. Both export geometry downstream.

**Simulation layer** — [FluidX3D](https://github.com/ProjectPhysX/FluidX3D) on the GPU.
Computational fluid dynamics at interactive speeds. The qcad→freecad pipeline generates
boundary geometry, FluidX3D simulates the flow, and godot-mcp ingests the velocity field
as CSV.

**Visualization layer** — [godot-mcp](https://github.com/sandraschi/godot-mcp). Imports
STL geometry, loads CFD velocity fields, spawns GPU particle systems, assigns PBR materials,
creates cameras with orbit controls, and exports to HTML5/WebAssembly. It's the render
endpoint for the entire pipeline.

**Export and distribution** — Godot scenes go to [Resonite](https://github.com/sandraschi/resonite-mcp)
for collaborative XR, to the browser as lightweight HTML5 games, to desktop as Tauri native
apps (~5 MB), or to architecture and scientific visualization toolchains. The same scene
can be a game, a CFD demo, or a BIM walkthrough — the pipeline composes, not locks you in.

**Robotics layer** — [robotics-mcp](https://github.com/sandraschi/robotics-mcp),
[yahboom-mcp](https://github.com/sandraschi/yahboom-mcp), and
[dreame-mcp](https://github.com/sandraschi/dreame-mcp). Physical and simulated robots
controlled via MCP. Yahboom handles educational robotics kits (ROS-compatible, sensor
telemetry, motor control). Dreame wraps the DreameHome robot vacuum API — mapping,
navigation, cleaning schedules — which sounds trivial until you realize a lidar-equipped
home robot with MCP control is a ready-made autonomous platform for indoor mapping and
presence. robotics-mcp bridges ROS2 and simulation environments. The same agent that
designs a CAD model can deploy it to a physical robot for fabrication or inspection.
This is just the beginning — the mesh can absorb any MCP-wrappable hardware platform.

**Avatar layer** — [vroid-mcp](https://github.com/sandraschi/vroidstudio-mcp) and
[avatar-mcp](https://github.com/sandraschi/avatar-mcp). VRoid Studio produces VRM 3D
avatars with full bone rigs and blend shapes. avatar-mcp manages the avatar pipeline:
import, configure, animate, export. Take a VRM avatar from VRoid, give it to godot-mcp
for game integration, and deploy it to Resonite for XR presence. The avatar becomes the
visual embodiment of whatever agent is behind it — a game character, a virtual assistant,
a robot interface. The robotics and avatar layers are converging: a virtual avatar that
drives a physical robot, or a physical robot that streams its sensor data to a visualization.

### Why this matters

No single company ships this pipeline. It crosses CAD vendors (Autodesk, Dassault),
game engines (Unity, Unreal, Godot), creative suites (Adobe, Blender, GIMP),
scientific computing (Ansys, OpenFOAM), robotics frameworks (ROS, Yahboom), and
XR platforms (Resonite, Meta Quest). Each is a walled garden.

The fleet doesn't ask permission. It wraps each tool as an MCP server, gives them a
common protocol, and lets an agent orchestrate across all of them. The result is a
maker pipeline that costs nothing, runs on a single machine, and is entirely under
your control.

This is what agentic coding unlocks: not writing one file faster, but **composing
systems that were never designed to work together**, at a scale that was previously
impossible for an individual.

## Further reading

- **[Fleet standards](https://github.com/sandraschi/mcp-central-docs/tree/master/standards)** — the playbook every repo follows. Tool design, response patterns, Tauri NSIS, PowerShell rules.
- **[leanforge-mcp](https://github.com/sandraschi/leanforge-mcp)** — Lean 4 formal proof search via LLM + compiler feedback loop. The most ambitious current project.
- **[arxiv-mcp](https://github.com/sandraschi/arxiv-mcp)** — pipe into arXiv for the empirical literature on agentic coding.
- Simon Willison's **[Agentic Engineering Patterns](https://simonwillison.net/2026/Feb/23/agentic-engineering-patterns/)** — the best writing on working in this mode. His *vibe coding*[^vibe] vs. *agentic engineering*[^agentic] distinction maps directly to how this fleet is built.

---

## Terms

| Term | Meaning |
|------|---------|
| Term | See |
|------|-----|
| **MCP-aware** | [^mcp] |
| **Tokenmaxxing** | [^tokenmax] |
| **Leaderboard-chasing** | [^leaderboard] |
| **Open-weight vs FOSS** | [^openweight] |
| **Zero-cloud** | [^zerocloud] |
| **Vibe coding** | [^vibe] |
| **Agentic engineering** | [^agentic] |
| **Context window** | [^contextwindow] |
| **Context drift** | [^contextdrift] |
| **INT4 quantization** | [^int4] |

[^mcp]: The [Model Context Protocol](https://modelcontextprotocol.io) — a standard for AI tools to discover and call external capabilities. An MCP-aware editor can talk to any MCP server.
[^tokenmax]: **Tokenmaxxing** — pumping ever-larger token volumes into premium API models, chasing marginal quality gains while the bill compounds. The opposite of efficient prompt design.
[^leaderboard]: **Leaderboard-chasing** — optimizing for benchmark scores (LMSYS, HumanEval) rather than real-world task performance. Models that top leaderboards sometimes fail at simple production tasks.
[^openweight]: **Open-weight ≠ FOSS.** Open-weight models (DeepSeek, Llama) publish trained weights under permissive licenses — you can download, run, fine-tune them. But the training data, curation methodology, and training code are proprietary. This is not FOSS (Free and Open Source Software), which requires full source transparency. Calling open-weight models "open source" is inaccurate.
[^zerocloud]: **Zero-cloud** — running the entire AI stack on local hardware. No API calls, no token costs, no subscriptions.
[^vibe]: **Vibe coding** — letting AI generate code with minimal direction. Term coined by [Andrej Karpathy](https://x.com/karpathy/status/1886192184808149383).
[^agentic]: **Agentic engineering** — human specifies architecture and constraints, AI implements under supervision, tests verify, human reviews. Term coined by [Simon Willison](https://simonwillison.net/2026/Feb/23/agentic-engineering-patterns/).
[^contextwindow]: **Context window** — the token limit a model can process per prompt. Grew from 2K (GPT-2, 2019) → 4K (GPT-3, 2020) → 32K (GPT-4, 2023) → 200K (Claude 3, 2024) → **1M+** (SOTA 2026). Bigger context means more code, docs, or history in one shot — but costs more compute and memory.
[^contextdrift]: **Context drift** — degradation of AI output quality over a long session as the model loses track of earlier constraints. Mitigated by compaction, fresh starts, spec-first planning.
[^int4]: **INT4 quantization** — compressing neural network weights to 4 bits instead of 16 or 32. Cuts VRAM 4–8x with minimal quality loss. Enables 70B+ models on a single consumer GPU.

---

*Sandra Schipal — Alsergrund, Vienna — June 2026*
