# The Agentic Shift: Post-Keyboard FOSS

## What changed

In early 2026, agentic coding quality crossed a threshold. The repositories in this fleet
are **human-architected, AI-implemented** — architecture, integration patterns, and aesthetic
choices are mine. The code is generated and iterated by AI agents under my direction.

The human job shifted from typing to thinking. Architecture, taste, judgment, knowing when
the output is wrong. The agent handles syntax, plumbing, tests, formatting, and the grind
work that used to be 80% of the job.

## Current Tool Stack (May 2026)

**[opencode](https://github.com/anomalyco/opencode)** — Free, open-source CLI agentic
coding tool. Terminal-native, MCP-aware, handles context management aggressively.
Covers ~90% of what Windsurf/Cursor/Claude Code do, but costs nothing. Reads codebases
via tools, not via context-window abuse. Runs local and remote models transparently.

**[DeepSeek v4](https://openrouter.ai/deepseek/deepseek-v4)** — The model. Near-free
via OpenRouter (fractions of a cent per million tokens). Code quality at parity with
Claude Opus 4 on architecture/refactoring tasks, better at bulk generation. Used
exclusively for this fleet since Q1 2026.

**The RTX 4090 angle** — DeepSeek v4 at INT4 quantization fits comfortably in 24 GB
VRAM. The v4 distilled models are expected to hit Ollama within a few months, at which
point the entire fleet toolchain (planning + implementation + review) runs fully local
on a single GPU, zero cloud cost. Currently, the fleet uses OpenRouter for model access
(DeepSeek v4-pro, ~$0.14/M input tokens) and opencode as the execution substrate.

## What we left behind

| Tool | Reason |
|------|--------|
| **Windsurf** | $15/month for what opencode does free. Good UI, wrong price point. |
| **Cursor** | $20/month. Better than Windsurf for large codebases, but same story — opencode covers the use case. |
| **Claude Code** | Anthropic's pricing at scale is brutal. Excellent output, unaffordable for fleet-scale work. |
| **Antigravity IDE** | Google's premium Gemini wrapper. Costs more than all others combined, and the Gemini 3 Flash model inside doesn't justify the IDE tax. |

The common thread: they're all paid IDEs wrapping cloud models. Once you decouple
the editor (opencode) from the model (DeepSeek v4 via OpenRouter), you're paying
$0 instead of $20–$40/month, and the output quality is the same or better for the
breadth-heavy, multi-language, multi-repo fleet use case.

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

135+ repos. One person. Working software, not prototypes.

That ratio wasn't possible before. The bottleneck used to be implementation bandwidth —
the gap between what you could design and what you could type. That gap is now closed.
The binding constraint is correctly: having something worth building, understanding it
well enough to direct the build, and knowing when the result is good.

The fleet is real infrastructure I use daily. The calibre RAG, the transit monitor, the
robotics bridges, the memory system — these run. They are not demos.

## The mesh: what 135 MCP servers can do when they talk to each other

The fleet isn't a collection of isolated tools. Each server exposes its domain via FastMCP
3.2, and the MCP bridge layer lets them call each other. The result is a **composable
maker pipeline** that didn't exist before — and wouldn't exist without agentic coding.

### Maker input → CAD → Simulation → Viz → Export

```
blender-mcp ──┐
gimp-mcp ────┤
inkscape ────┤  ┌─────────────┐   ┌──────────┐   ┌─────────────┐
osc-apps ────┼──│ freecad-mcp  │──▶│ FluidX3D │──▶│  godot-mcp  │
worldlabs ───┘  │  qcad-mcp   │   │ (GPU CFD)│   │  (import +  │
                └─────────────┘   └──────────┘   │   viz)      │
                                                  └──────┬──────┘
                                                         │
                    ┌────────────┬────────────┬──────────┼──────────┐
                    ▼            ▼            ▼          ▼          ▼
               Resonite XR   HTML5 games   Tauri     Arch viz    CFD/FEM
                            (export web)   native    (BIM)      scientific
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

### Why this matters

No single company ships this pipeline. It crosses CAD vendors (Autodesk, Dassault),
game engines (Unity, Unreal, Godot), creative suites (Adobe, Blender, GIMP), and
scientific computing (Ansys, OpenFOAM). Each is a walled garden.

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

*Sandra Schipal — Alsergrund, Vienna — May 2026*
