# 🔥 Fleet Highlights: Superhuman Narrow in Practice

The `sandraschi` fleet demonstrates **Superhuman Narrow (SHN)**: non-experts directing AI agents with tight feedback loops to build production-grade, domain-specific tooling.

---

### mixx-dj-mcp: bridging Mixxx for the mobile DJ workflow

[mixx-dj-mcp](https://github.com/sandraschi/mixx-dj-mcp) is an MCP server and webapp companion for [Mixxx](https://mixxx.org) -- providing OSC bridging, deck control, BPM sync, and remote inspection.

Mixxx is a mature, rock-solid, 300,000-line C++ open-source DJ suite built and maintained by a dedicated community over two decades. Like many large community projects, their maintainers have to balance stability, audio engine integrity, and limited volunteer bandwidth. As a result, certain specialized features -- particularly video playback, synced visuals, and local stem separation -- remained out of scope for the upstream core.

For a 2026 mobile DJ playing weddings, birthdays, or local events, video and visual accompaniment are increasingly standard expectations. Compact, lightweight LED/laser projectors have become inexpensive and easily fit in a gig bag, letting a solo DJ project music videos or audio-reactive backdrops against any hall wall without carting around heavy trussing or LED walls. Rather than waiting or expecting the upstream core team to shoulder that maintenance burden, we used an agentic workflow (DeepSeek V4 via OpenCode) to explore those additions in an experimental fork: [mixxxx fork](https://github.com/sandraschi/mixxxxx):

- **Video & VFX**: Headless integration with battle-tested FFmpeg libraries for music video playback.
- **Synced Visuals**: Audio-reactive WebGL visualizations via [ButterChurn](https://github.com/jberg/butterchurn) (MilkDrop format) sent to the projector output.
- **Stem Separation**: Local GPU inference with ONNX HTDemucs v4 without cloud round-trips.

The goal is not to compete with high-end club installations, but to solve real, everyday workflows for working mobile DJs. By pairing a clear functional spec with compiler feedback loops, agentic engineering allowed a solo non-expert to prototype ~5,000 lines of clean C++ extensions that bolt onto a massive codebase without compromising the audio pipeline.

Beyond standalone playback, `mixx-dj-mcp` connects seamlessly to the broader fleet:
- **Projection Mapping with [`resolume-mcp`](https://github.com/sandraschi/resolume-mcp)**: Route per-deck video mixes and visual layers over local NDI streams straight into Resolume Avenue/Arena for multi-surface projection.
- **Virtual Metaverse Stage with [`resonite-mcp`](https://github.com/sandraschi/resonite-mcp)**: Stream live master audio and OSC BPM clocks into a 3D Resonite world, driving animated dance rigs (such as a 3D Nekomimi avatar dancing in sync with the beat) to beam onto the venue projector or Twitch stream.

<!-- -->

### leanforge-mcp: formal proofs, no math degree

[Lean 4](https://lean-lang.org) is a proof assistant -- a programming language where
the compiler verifies that your code is mathematically correct. Using it traditionally
requires a PhD in logic or months of study. [leanforge-mcp](https://github.com/sandraschi/leanforge-mcp) automates the hard part:
an LLM proposes a proof, the Lean compiler checks it, the LLM reads the error and
tries again. Loop until verified.

**I am not a math wiz.** I can't write a Lean proof by hand. But I can frame the
conjecture, and the AI + compiler feedback loop handles the rest. This is the same
pattern as AlphaProof but running on a consumer GPU with open-weight models.

Two repos, same pattern: complex domain-specific tasks made approachable by pairing human taste and clear framing with compiler and test feedback loops.


→ **[Superhuman Narrow →](docs/SUPERHUMAN_NARROW.md)** -- the full argument

→ **[Full catalog →](MCP_CATALOG.md)** • **[Workshop & Hardware](WORKSHOP.md)** • **[Shenzhen Robotics →](docs/SHENZHEN_ROBOTICS.md)** • **[Bloopers →](docs/BLOOPERS.md)**

---
