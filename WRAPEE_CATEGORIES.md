# Wrapee Categories

"Wrapee" is fleet slang for whatever a repo wraps. It is not always an app with an installer. Five kinds, easiest first. Linked from [Why so many repos?](WHY_FLEET.md). Full index: [MCP Catalog](MCP_CATALOG.md).

---

## 1. Single tool (easiest)

One program you already know. Install it, point the repo at it, done.

Examples: [blender-mcp](https://github.com/sandraschi/blender-mcp) (Blender 3D), [qcad-mcp](https://github.com/sandraschi/qcad-mcp) (QCAD drafting), [plex-mcp](https://github.com/sandraschi/plex-mcp) (Plex media), [obs-mcp](https://github.com/sandraschi/obs-mcp) (OBS Studio), [reaper-mcp](https://github.com/sandraschi/reaper-mcp) (REAPER DAW).

- **You need:** the program itself, installed separately. Never bundled.
- **The agent gets:** tool calls driving it (render, export, search library, switch scene).
- **You get:** the dashboard and winapp showing status, logs, thumbnails.

If every wrapee were like this, no explainer would be needed. They are not.

## 2. Infrastructure and services

No installer. An account, an API, or a public feed.

Examples: [arxiv-mcp](https://github.com/sandraschi/arxiv-mcp) (arXiv papers), [email-mcp](https://github.com/sandraschi/email-mcp), [discord-mcp](https://github.com/sandraschi/discord-mcp), [mywienerlinien](https://github.com/sandraschi/mywienerlinien) (Vienna transit departures), [gitee-mcp](https://github.com/sandraschi/gitee-mcp) (Gitee, the PRC equiv of GitHub: 12M+ users, humming radar, momentum tracking, zh->en translation via local Ollama).

- **You need:** credentials or nothing at all (arXiv and transit are public; Gitee works anonymously, free token unlocks search).
- **The agent gets:** search, fetch, send, listen.
- **You get:** onboarding docs for the account setup (money, API keys, pitfalls) plus the same dashboard pattern.

Same concept extends to any country's sites: the wrapper pattern does not care what language the forge speaks. Order from Taobao, why not - one friction point in the daily life of a dev and robot tinkerer gone (parts from Shenzhen without the browser-tab dance). Hungarian sites very much included (haha, but also serious: small-language ecosystems are as invisible to Western tooling as Gitee was - same wrapper, new wrapee).

Onboarding matters most here: [docs/ONBOARDING.md](docs/ONBOARDING.md) per repo.

## 3. Worlds and environments

You do not operate on files. You go inside.

Examples: [resonite-mcp](https://github.com/sandraschi/resonite-mcp) (Resonite VR), [vrchat-mcp](https://github.com/sandraschi/vrchat-mcp), [overte-mcp](https://github.com/sandraschi/overte-mcp), [godot-mcp](https://github.com/sandraschi/godot-mcp), [unity3d-mcp](https://github.com/sandraschi/unity3d-mcp).

- **You need:** the world client (often a headset or desktop client) plus an account.
- **The agent gets:** spawn objects, move avatars, mirror telemetry, drive a digital twin.
- **You get:** the world itself as the UI, with the dashboard as mission control beside it.

Typical chain: a Blender model becomes a Resonite avatar that mirrors a physical robot. See [Make / Move / Meet](FLEET_MAKE_MOVE_MEET.md).

## 4. Robot plus its underlying stack

Hardware never stands alone. A robot wrapee is a bundle: the machine, its middleware, its simulator, its remote control.

Example: the Yahboom car ("Boomy") is [yahboom-mcp](https://github.com/sandraschi/yahboom-mcp) for the hardware, [ros-mcp](https://github.com/sandraschi/ros-mcp) for ROS 2 topics and services, [mujoco-mcp](https://github.com/sandraschi/mujoco-mcp) or [gazebo-mcp](https://github.com/sandraschi/gazebo-mcp) for crashing safely in simulation first, [teleoperator-mcp](https://github.com/sandraschi/teleoperator-mcp) for driving it from a VR headset.

- **You need:** the kit (or just the simulator - sim-only is a valid start).
- **The agent gets:** drive, sense, map, plan, plus "validate in sim before touching hardware".
- **You get:** telemetry dashboards and one big red emergency stop.

Same pattern for [dreame-mcp](https://github.com/sandraschi/dreame-mcp) (vacuum as lidar platform), [norirobotics-mcp](https://github.com/sandraschi/norirobotics-mcp), [unitree-mcp](https://github.com/sandraschi/unitree-mcp), [limx-robotics-mcp](https://github.com/sandraschi/limx-robotics-mcp).

## 5. Abstract concepts

No vendor, no installer, no device. The repo implements an interface to an idea.

Examples: [leanforge-mcp](https://github.com/sandraschi/leanforge-mcp) (the Lean 4 language as a proof loop: LLM proposes, compiler verifies), [osc-mcp](https://github.com/sandraschi/osc-mcp) (the OSC protocol as shared bus for music, VR, and robots), [avatar-mcp](https://github.com/sandraschi/avatar-mcp) (VRM identity: one rig across Resonite, VRChat, and Godot), [vla-mcp](https://github.com/sandraschi/vla-mcp) (vision-language-action models as "pick up the red bracket" tool calls).

- **You need:** understanding, not hardware. Read the repo's concept page first.
- **The agent gets:** the concept as callable tools.
- **You get:** the dashboard making the abstract visible (proof states, message buses, model pipelines).

These are the hardest to grasp and the most powerful in chains: OSC carries BPM clocks and robot telemetry on the same bus.

---

## Next

- Why the fleet looks like this: [Why so many repos?](WHY_FLEET.md)
- Concrete chains: [Make / Move / Meet](FLEET_MAKE_MOVE_MEET.md) - [Play / Know / Home](FLEET_PLAY_KNOW_HOME.md)
- Every server in one registry: [MCP Catalog](MCP_CATALOG.md)
