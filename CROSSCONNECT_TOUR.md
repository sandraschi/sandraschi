# Crossconnect Tour: Five Chains That Earn the Fleet

Prose companion to the technical map ([Fleet Crossconnects](FLEET_CROSSCONNECTS.md), clickable graph + 1-hop contract). The graph says what links exist. This page walks five chains end to end so you feel why they matter. Fritz ([FRITZ.md](FRITZ.md)) is the reasoning spine in all of them: sense -> reason -> act -> remember.

---

## 1. Morning briefing, spoken

Sleepy Sandra, 7 AM: "speechy fritz gimme overnight arxiv humdingers."

speech-mcp hears the wake word offline (openWakeWord, no cloud), FunASR transcribes locally, the voice bus posts to fleet-agent `/api/voice/intent`. Fritz pulls the overnight aiwatcher surge items and arxiv codehunt hits, composes the briefing with Muse Glimmer, speaks it back via local TTS, and drops the report on the hub board. Zero cloud calls. The mic is the only remaining physical leg - everything else is verified live.

## 2. House check, spoken

"Speechy home all devices working check."

Same bus, different route: intent goes to devices-mcp and home-assistant-mcp, which poll plugs, lights, lock, and doorbell. Anything dark gets flagged; the spoken reply lists only the exceptions ("all working except the balcony plug"). Dashboard shows the full grid for the details. One sentence in, whole house verified.

## 3. Bracket to buddy (Make -> Move -> Meet)

Draft a sensor bracket in QCAD (DXF), extrude and render in Blender, fit the KiCad PCB against the FreeCAD enclosure (STEP), print it, bolt it onto the Yahboom car. Validate collisions in MuJoCo first, then drive the real car while its Resonite twin mirrors telemetry over OSC, and hear speech-mcp narrate "mount check done". Five repos, one afternoon. Each step works solo; together they are the argument for the fleet. Full category walkthrough: [Make / Move / Meet](FLEET_MAKE_MOVE_MEET.md).

## 4. News in, digest out (Know -> Home)

aiwatcher spots a paper, arxiv-mcp fetches full text, calibre-mcp finds the cited book chapter, advanced-memory links both into the knowledge graph. The daily digest goes out via email-mcp, archives into Calibre, and (opt-in) posts its summary to the Discord guild. Nobody hired a librarian. Full flows: [Play / Know / Home](FLEET_PLAY_KNOW_HOME.md).

## 5. Morning sweep (dev ops)

git-github-mcp breakfast digest: open PRs, stale flags, CI failures with log tails and rerun plus AI diagnose. docker-mcp alongside: stale-image list for pruning, crash-log trawl on restarting containers, Compose health after deploy. Human approves the prune and the rerun in the dashboards. The sweep is the product - raw `git log` never gave you that.

---

## The contract behind the chains

Every link above is 1-hop and optional: each repo documents only direct peers, works alone, and degrades to a friendly install link when the peer is missing. No chain may require the whole fleet. That is what keeps 190 repos composable instead of tangled. Rules: [Fleet Crossconnects](FLEET_CROSSCONNECTS.md).

---

## Next

- Voice layer: [Speech Hub](SPEECH_HUB.md) - Categories: [Make / Move / Meet](FLEET_MAKE_MOVE_MEET.md), [Play / Know / Home](FLEET_PLAY_KNOW_HOME.md)
- Agent: [Fritz](FRITZ.md) - Product: [Coming Next](COMING_NEXT.md)
