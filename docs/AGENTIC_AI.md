# The Agentic Revolution: Post-Keyboard FOSS

## What changed

In early 2026, agentic coding quality crossed a threshold. The repositories in this fleet
are **human-architected, AI-implemented** — architecture, integration patterns, and aesthetic
choices are mine. The code is generated and iterated by AI agents under my direction.

The human job shifted from typing to thinking. Architecture, taste, judgment, knowing when
the output is wrong. The agent handles syntax, plumbing, tests, formatting, and the grind
work that used to be 80% of the job.

## Current Tool Stack (June 2026)

**[Cursor Ultra](https://cursor.com)** — 50% price reduction (temporary deal). The IDE
itself is excellent — the agentic diff view, inline edit preview, MCP server integration,
and context-aware codebase indexing are genuinely better than the alternatives. At the
discounted price it's a no-brainer. Would not pay full Ultra price; would revert to
opencode.

**[opencode](https://github.com/anomalyco/opencode)** — Free, open-source CLI agentic
coding tool. Terminal-native, MCP-aware, handles context management aggressively.
Covers ~90% of what Cursor/Claude Code do, but costs nothing. Reads codebases
via tools, not via context-window abuse. Runs local and remote models transparently.
Fallback when subscription deals lapse.

**[DeepSeek v4](https://openrouter.ai/deepseek/deepseek-v4)** — Daily driver model.
Near-free via OpenRouter (fractions of a cent per million tokens). Code quality at parity
with Claude Opus 4 on architecture/refactoring tasks, better at bulk generation. Used
exclusively for this fleet since Q1 2026. Not multimodal yet — text-only.

**[Anthropic Fable 5](https://anthropic.com)** — Temporary freebie deal (free until June
22, 2026). Absolutely incredible quality — like driving a Rolls. Hyper-expensive cloud
APIs are fine when you catch these deals. Used for planning and complex architectural
reasoning sessions where its superior nuance matters. After the freebie ends, it gets
drop-kicked back to the expensive tier unless another deal appears.

**The RTX 4090 angle** — DeepSeek v4 at INT4 quantization fits comfortably in 24 GB
VRAM. The v4 distilled models are expected to hit Ollama within a few months, at which
point the entire fleet toolchain (planning + implementation + review) runs fully local
on a single GPU, zero cloud cost.

## Strategy: ride the deals

The pattern: subscribe to the best deals, use the best model available at the time,
and never get locked in. Cursor Ultra at 50% off? Yes. Fable 5 free until June 22?
Yes, and use it for everything while it lasts. When these lapse, opencode + DeepSeek v4
via OpenRouter at fractional-cent pricing is the permanent fallback.

The expensive cloud APIs are worth it *when the deal is right*. The key is not getting
dependent on any single provider's full price.

## What we left behind

| Tool | Reason |
|------|--------|
| **Windsurf** | $15/month for what opencode does free. Good UI, wrong price point. |
| **Claude Code** | Anthropic models included in subscription — excellent output, but the cap is too low for fleet-scale work. Days to blow through it. |
| **Antigravity IDE** | Google v2 update made it light and shadow — some genuinely useful Gemini integration, but plagued by regressions, inconsistent quality, and zero community velocity. At its best it's good. At its worst it's unusable. Not worth the context switch from Cursor/opencode. |

The common thread: the best setup is decoupling the editor from the model.
opencode + DeepSeek v4 via OpenRouter is the permanent baseline at ~$0/month.
Cursor Ultra + Fable 5 is the upgrade when deals align.

## AI slop: the objection that aged poorly

The 2023–2024 critique was accurate for single-shot generation: hallucinated APIs,
confident wrongness, code that looked plausible and didn't work. By mid-2026, agentic
stacks — where the model reads its own output, runs tests, fixes failures, and iterates —
produce qualitatively different results. The failure modes are different and much less
frequent.

The actual remaining challenge is **volume asymmetry**: generating a PR takes seconds,
reviewing it takes an hour. The answer is better automated test gates, not a moratorium
on AI.

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

If you want the empirical literature on agentic coding, **[arxiv-mcp](https://github.com/sandraschi/arxiv-mcp)**
gives a clean pipe into arXiv: search, full-text, citation tracing, local corpus.

Simon Willison's **[Agentic Engineering Patterns](https://simonwillison.net/2026/Feb/23/agentic-engineering-patterns/)**
series is the best ongoing writing on working in this mode. His *vibe coding* vs.
*agentic engineering* distinction maps directly to how this fleet is built.

---

*Sandra Schipal — Alsergrund, Vienna — June 2026*
