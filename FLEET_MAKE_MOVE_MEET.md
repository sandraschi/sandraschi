# Make / Move / Meet

The interlock chain: **design it, drive it, meet it in VR.** Three categories that behave like one pipeline.

Start with [Why so many repos?](WHY_FLEET.md) if you have not read it. Full index: [MCP Catalog](MCP_CATALOG.md). How linking works: [Fleet Crossconnects](FLEET_CROSSCONNECTS.md).

---

## Contents

- [Make: design and build](#make-design-and-build)
- [Move: robots and simulation](#move-robots-and-simulation)
- [Meet: virtual worlds and avatars](#meet-virtual-worlds-and-avatars)
- [The chain, end to end](#the-chain-end-to-end)

---

## Make: design and build

Draw, model, lay out boards, generate worlds.

| Repo | What it wraps | When you want it |
|---|---|---|
| [blender-mcp](https://github.com/sandraschi/blender-mcp) | Blender 3D | Meshes, scenes, product renders, GLTF/VRM export to VR |
| [qcad-mcp](https://github.com/sandraschi/qcad-mcp) | QCAD 2D drafting | DXF floorplans, laser-cut plates, AutoLISP transpiler |
| [freecad-mcp](https://github.com/sandraschi/freecad-mcp) | FreeCAD parametric CAD | STEP enclosures with real tolerances, CFD via FluidX3D |
| [kicad-mcp](https://github.com/sandraschi/kicad-mcp) | KiCad PCB | Board + enclosure fit check against FreeCAD |
| [codecad-mcp](https://github.com/sandraschi/codecad-mcp) | build123d code-CAD | Enclosures as code, printable the same day |
| [godot-mcp](https://github.com/sandraschi/godot-mcp) | Godot 4 engine | Viz endpoint: STL import, particles, PBR, HTML5 export |
| [worldlabs-mcp](https://github.com/sandraschi/worldlabs-mcp) | WorldLabs AI worlds | Photoreal interiors without three days of Blendering |
| [gimp-mcp](https://github.com/sandraschi/gimp-mcp) / [inkscape-mcp](https://github.com/sandraschi/inkscape-mcp) | GIMP / Inkscape | Textures and SVG assets feeding the 3D scene |

Honesty note: standalone Blender/QCAD drivers with 10k stars beat us on single-app depth. Pick ours when the file must travel (DXF to Blender to print to robot to VR).

## Move: robots and simulation

Physical kits, vacuums-as-platforms, wheeled household robots, humanoids, and the simulators that keep them safe.

A new category worth naming on its own: cheap **wheeled household robots** — not legged, not industrial, priced for a home rather than a lab. **[Nori Robotics A3](https://www.norirobotics.com/)** is the vanguard here: a $1,688, 19-DOF wheeled bimanual home robot (XLeRobot/Hugging Face LeRobot lineage), ships Fall 2026. That's the same democratization story as [Shenzhen actuators](docs/SHENZHEN_ROBOTICS.md) making legged humanoids DIY-grade, one category over: wheeled home robots going from lab-only to hobbyist-priced.

Where Unitree fits alongside that: genuinely great hardware, but the versions with the DOF and payload to actually be useful for real manipulation work are priced for a lab, not a household — G1 EDU runs **$43,900-$73,900**, versus $13,500 for the base G1 that lacks the same capability. R1 EDU is the more approachable middle ground at **$10,500**. Either way, Unitree is a "when you have a grant, not when you have a hobby budget" tier next to Nori's $1,688. And if $650,000 and 2.8 meters tall sounds appealing: Unitree also shipped the **GD01** — a rideable, human-piloted mecha the Chinese press immediately and correctly nicknamed a real-life Gundam. Great watch, not going in anyone's living room: [Real Life Gundam? The $650,000 Unitree GD01 Mass Production Begins! (YouTube)](https://www.youtube.com/watch?v=a2EfO_bND8U).

"Mass production" for a two-meter piloted mecha deserves real skepticism, even if the price eventually drops toward $80k — who is the buyer placing an order for a hundred of these? Not a household, not a warehouse. Industrial ops, rescue, and "cultural tourism" (Unitree's own stated markets) don't generate hundred-unit orders either. The order-size that actually makes "mass production" a coherent sentence is a military procurement budget, and for a made-in-China rideable mecha that's not a reassuring answer given the current state of the Taiwan Strait — which is exactly the kind of skepticism a "mass production begins" headline should get, not uncritical repetition.

| Repo | What it wraps | When you want it |
|---|---|---|
| [yahboom-mcp](https://github.com/sandraschi/yahboom-mcp) | Yahboom Raspbot V2 ("Boomy") | ROS 2 car on Pi 5, camera + ultrasonic, local Gemma brain |
| [dreame-mcp](https://github.com/sandraschi/dreame-mcp) | Dreame vacuum | Lidar mapping and navigation as a ready indoor platform |
| [norirobotics-mcp](https://github.com/sandraschi/norirobotics-mcp) | Nori Robotics A3 | $1,688 wheeled bimanual home robot, WebRTC control, mock session until ships Fall 2026 |
| [unitree-mcp](https://github.com/sandraschi/unitree-mcp) | Unitree quadrupeds/humanoids | MuJoCo + ROS 2 bridge for legged locomotion |
| [limx-robotics-mcp](https://github.com/sandraschi/limx-robotics-mcp) | LIMX robots | Sim lifecycle + VLA bridge |
| [teleoperator-mcp](https://github.com/sandraschi/teleoperator-mcp) | WebXR teleop client | Steer the physical robot from a Pico headset, two-way audio |
| [ros-mcp](https://github.com/sandraschi/ros-mcp) / [robotics-mcp](https://github.com/sandraschi/robotics-mcp) | Generic ROS 2 | Topics, services, bags, launch when no kit-specific repo fits |
| [mujoco-mcp](https://github.com/sandraschi/mujoco-mcp) / [gazebo-mcp](https://github.com/sandraschi/gazebo-mcp) / [isaac-mcp](https://github.com/sandraschi/isaac-mcp) | MuJoCo / Gazebo / Isaac | Crash in simulation first, then touch hardware |
| [vla-mcp](https://github.com/sandraschi/vla-mcp) | Vision-Language-Action models | "Pick up the red bracket" as a tool call |

Background: [Shenzhen robotics](docs/SHENZHEN_ROBOTICS.md) - why actuators dropped from 3000 to 200 dollars, and why humanoids are now DIY-grade.

## Meet: virtual worlds and avatars

Where the model and the robot show up as someone you can talk to.

| Repo | What it wraps | When you want it |
|---|---|---|
| [resonite-mcp](https://github.com/sandraschi/resonite-mcp) | Resonite VR | Collaborative XR endpoint, ProtoFlux/WebSocket link, digital twin mirror |
| [vrchat-mcp](https://github.com/sandraschi/vrchat-mcp) | VRChat | Same avatar, different crowd |
| [overte-mcp](https://github.com/sandraschi/overte-mcp) | Overte open metaverse | Open-source stack when you want self-hosted worlds |
| [unity3d-mcp](https://github.com/sandraschi/unity3d-mcp) | Unity | Physics lab for training before deploying to XR |
| [avatar-mcp](https://github.com/sandraschi/avatar-mcp) | VRM identity + animation | One rig driving Resonite, VRChat, and Godot |
| [vroidstudio-mcp](https://github.com/sandraschi/vroidstudio-mcp) | VRoid Studio | Character pipeline: bones, blend shapes, VRM out |
| [osc-mcp](https://github.com/sandraschi/osc-mcp) | OSC protocol | The shared bus: BPM clocks, telemetry, controller streams |

## The chain, end to end

**Bracket to buddy in one afternoon:**

1. Draft the sensor bracket in QCAD (DXF), extrude and render it in Blender.
2. Fit the PCB from KiCad against the FreeCAD enclosure (STEP), print it.
3. Bolt it onto Boomy (Yahboom) or a Nori chassis; validate collisions in MuJoCo first.
4. Mirror telemetry into Resonite over OSC: the in-world avatar leans when the car turns.
5. Drive it back from VR with teleoperator-mcp while speech-mcp narrates. Log the run to memory.

Each step runs alone. Together they are the argument for the fleet: files travel, robots mirror, humans watch from inside.

---

Next: [Play / Know / Home](FLEET_PLAY_KNOW_HOME.md) - [Why the fleet](WHY_FLEET.md) - [Catalog](MCP_CATALOG.md) - [Workshop](WORKSHOP.md)
