# Why So Many Repos?

Nontechnical explainer for the sandraschi fleet. 3 minutes.

---

## 1. What each repo actually is

Pick a tool you already use: Blender for 3D, QCAD for 2D drafting, Plex for movies, a Dreame vacuum, Vienna transit.

Each fleet repo wraps **one** such tool and adds three faces:

- **A robot-handle** (called MCP). Lets an AI agent drive the tool from Claude Desktop, Cursor, or any agentic IDE, with a local or cloud model: "render this scene", "find this ebook", "dock the vacuum".
- **A human dashboard** (dark webapp). Buttons, sliders, live status, logs. For you, not the agent.
- **A Windows desktop app** (Tauri + NSIS .exe). Same UI as the webapp, installed with a double-click, no browser needed.

One wrapped thing, one repo, same triple pattern everywhere. That is the whole fleet.

## 2. Why not one giant repo?

- **Install only what you own.** Got no robot vacuum? Skip dreame-mcp. Got Blender? Take blender-mcp. A monorepo forces everyone to download everything.
- **Separate versions, separate store entries.** Each repo ships its own 1-click installer (.mcpb) on Glama.ai. Break one, the rest keep working.
- **Same skeleton, cheap to add.** New wrappee = clone the template, fill in the tool calls, done. The count grows because wrapping is cheap, not because it is complicated.

The cost of many repos is discovery ("which of 190 do I need?"). That is what the two category pages solve: start with [Make / Move / Meet](FLEET_MAKE_MOVE_MEET.md) or [Play / Know / Home](FLEET_PLAY_KNOW_HOME.md), not with the full list.

## 3. Why a webapp AND a desktop app for each?

Agents are fast and blind. Humans are slow and responsible. The two human faces are the meeting point:

- **Watch** what the agent did (telemetry, logs, thumbnails) - in the browser or on the desktop, same UI.
- **Stop** what you do not like (emergency stop for robots, cancel for renders).
- **Approve** what matters (community posts, emails, destructive file ops sit in an inbox until you click yes).
- **Pick your shell.** Browser tab people use the webapp. Desktop people double-click the NSIS-installed Tauri app. Nothing to configure twice.

No light mode, by policy. Night-owl fleet.

## 4. What does "crossconnect" mean?

Every repo works **alone**. Crossconnect is an optional bonus link between neighbours:

- **1 hop only.** Each repo documents only its direct peers, never the whole chain.
- **Soft fail.** Peer missing? You get a friendly install link, not a crash.
- **Concrete example.** Draw a bracket in QCAD, extrude it in Blender, export STEP from FreeCAD, print it, bolt a sensor onto the Yahboom car, watch its twin move inside Resonite VR, hear speech-mcp say "mount check done". Five repos, one afternoon, zero meetings. Each step also works solo.

Technical map: [Fleet Crossconnects](FLEET_CROSSCONNECTS.md). Category walkthrough: [Make / Move / Meet](FLEET_MAKE_MOVE_MEET.md).

Three taste-tests of the full power (short versions - the leporello lives in the sub-pages):

- **docker-mcp.** You see containers, images, volumes, networks in the dashboard. The agent lists stale images for pruning or trawls crash logs to explain why a container keeps restarting. Full flow: [Play / Know / Home, advanced flows](FLEET_PLAY_KNOW_HOME.md#advanced-flows-three-repos-at-full-power).
- **git-github-mcp.** Morning sweep: open PRs, stale flags, CI failures with log tails and rerun plus AI diagnose, all in the dashboard. Full flow: [Play / Know / Home, advanced flows](FLEET_PLAY_KNOW_HOME.md#advanced-flows-three-repos-at-full-power).
- **aiwatcher-mcp.** Trawls 10+ news sources, scores with your persona, writes the HTML digest, delivers via email and archives to Calibre - and can post the summary to your Discord guild (opt-in via discord-mcp). Full flow: [Play / Know / Home, advanced flows](FLEET_PLAY_KNOW_HOME.md#advanced-flows-three-repos-at-full-power).

## 5. Honest note on stars: 40 vs 10,000

The most popular Blender MCP server on GitHub has 10,000+ stars. Ours has about 40. That is expected, and here is the tradeoff stated plainly:

- **If you only want the best single Blender driver**, use the 10k-star repo. It has more users, more edge cases covered, faster fixes for Blender-only work.
- **It has no human faces at all.** No web dashboard, no desktop app. Agent-only. If you want to watch the render queue, approve steps, or hand a Windows .exe to someone who never touches an IDE, it is not there.
- **Use ours when you want the pipeline.** Ours exists so Blender can hand GLTF/VRM to Resonite, take DXF/SVG from QCAD, take STEP mounts from FreeCAD, announce "render done" over voice, and show the same dark dashboard and Tauri winapp as the other 189 repos. No standalone Blender repo optimizes for that.

Same logic everywhere: we do not try to beat each wrappee's flagship integration. We try to make 190 wrappees behave like one workshop. Judge us on the chain, not the link.

## 6. The value proposition in one paragraph

You own apps, devices, files, and robots. AI agents can drive them but need handles. Humans need oversight but not 190 manuals. The fleet gives each thing the same handle plus the same dashboard, then lets neighbours snap together when useful and stay silent when not. A retired engineer in Vienna runs it on one RTX 4090 box for 0 EUR per token, fully local, no cloud lock-in. That is sovereignty at hobby scale: your media, your books, your CAD, your robots, your agent.

---

## Next

- Concrete chains: [Make / Move / Meet](FLEET_MAKE_MOVE_MEET.md) (Blender to QCAD to Resonite VR to Nori / Unitree / Yahboom / Dreame)
- Sound, knowledge, home life: [Play / Know / Home](FLEET_PLAY_KNOW_HOME.md)
- Deep dives (separate pages): [Highlights](HIGHLIGHTS.md) - [Coming Next](COMING_NEXT.md)
- Full index: [MCP Catalog](MCP_CATALOG.md) - Machine: [Workshop](WORKSHOP.md)
