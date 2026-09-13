# Demo Vid: Explanation Videos per Repo

Repo: [demo-vid-mcp](https://github.com/sandraschi/demo-vid-mcp) (backend :11134, frontend :11135). Cool concept, not perfect yet - read the constraints at the bottom before promising anything.

---

## The concept

Every repo gets a narrated walkthrough video, generated - not recorded. Point demo-vid at a repo and the pipeline: drafts a narration script from the README, auto-starts the target webapp, records it page by page with Playwright (click ripples included), stretches each page's dwell to the true spoken length so lines never cut off mid-sentence, synthesizes voiceover (speech-mcp), mixes real background music (songgeneration-mcp) and timed sound effects (sfx-mcp), joins pages with real transitions (vfx-mcp), composes with FFmpeg. Out comes MP4 plus subtitles plus poster, filed in a categorized depot with player, rebuild, delete, and insert-into-README.

## The killer feature: live driving

Desktop-capture mode does not screencast a staged demo. OBS records a real app window (Blender, Resonite) while `mcp_call` steps actually invoke that app's own MCP server mid-recording. The video shows the agent doing the work, because the agent is doing the work. See `data/scripts/*.yaml` for working examples.

## Why video, not screenshots

The webapps deliberately share one design language, so screenshots all look alike: same dark chrome, different labels. A screenshot proves a page exists. A narrated video explains what the repo *does*. The full explanation vid for the fleet will be done by demo-vid-mcp for exactly this reason.

## Honest constraints

- Not perfect yet: v0.x, queue and depot solid, desktop-capture young.
- One hard limit: no Resonite camera control, so in-world shots are fixed-angle until that API exists.
- Requires speech-mcp + Playwright + FFmpeg; music/sfx/vfx/blender titles are optional peers that degrade to plain cuts when missing.
- Roadmap and architecture: [DEMO_VID_MCP_PLAN.md](https://github.com/sandraschi/demo-vid-mcp/blob/main/DEMO_VID_MCP_PLAN.md).

---

## Next

- Parent: [Dev Stack](DEV_STACK.md) (packaging/screenshots section) - Voiceover engine: [Speech Hub](SPEECH_HUB.md)
- The tour it will one day narrate: [Crossconnect Tour](CROSSCONNECT_TOUR.md)
