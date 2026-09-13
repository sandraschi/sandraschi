# Sneaky Feats

The rogues' gallery: four things the fleet does that have no business working as well as they do. Every sneak ships with a guardrail - that is the house rule for this page.

---

## 1. Talking to Alexa through the air

No Alexa API, no skill certification, no developer account. [alexa-mcp](https://github.com/sandraschi/alexa-mcp) synthesizes speech through the PC speakers, the Echo hears it like a human, faster-whisper transcribes the answer from the mic. "Gimme alexa weather report" in Claude becomes a loud "Alexa, weather report" in the room, and the transcript comes back. Full story: [Speech Hub](SPEECH_HUB.md).

## 2. Talking to cloud voice ingesters

Same trick, generalized: sound is the universal API. Anything with a microphone is callable - Siri, cloud voice assistants, any pipeline with speech input like Whisper-fronted tools. Our TTS talks to their STT; no integration meeting required. The flip side is why the shopping guard and the prompt-injection mitigations exist: never pipe unreviewed model output into a speaker that something powerful can hear.

## 3. Listening first, then building what they begged for

[fleet-public-relations-mcp](https://github.com/sandraschi/fleet-public-relations-mcp) monitors forum and Reddit threads (Cloudflare-resistant scraper, hourly) and triages every comment with a local model for competency and need. Approval-gated drafts, hype-word tone lint, escalation to admiral-mcp on high-competency hits.

The sneaky part is the competitive loop, and honestly it is mostly chat-driven, not a tool: "claude, what does the most popular qcad mcp have that we don't?" Git discovery (search, clone, read), the quality-check skill's competition pass, and landscape docs like robofang's [4-way matrix](https://github.com/sandraschi/robofang/blob/main/docs/COMPETITIVE_LANDSCAPE.md) (vs OpenClaw, OpenFang, OpenManus - stale since Mar 2026, see the six-month rule). Same for threads: watch competitor repos for what users beg for - missing features, ignored issues - then build exactly that. No scraping war, no ToS grey zone, just public threads read carefully.

And "filch" sounds greyer than it is: MIT-licensed repos are fair game. License permitting, reading the best implementation and writing a better one is how open source works - attribution included, obviously.

## 4. Demo videos where the agent really does it

[demo-vid-mcp](https://github.com/sandraschi/demo-vid-mcp) does not screencast staged demos. In desktop-capture mode, `mcp_call` steps invoke the target app's own MCP server mid-recording while OBS rolls: the video shows the agent doing the work because the agent is doing the work. A demo that cannot fail differently than the product fails. Full page: [Demo Vid](DEMO_VID.md).

---

## The house rule

Sneaks are allowed. Unsupervised sneaks are not: shopping guard on the speaker, approval gates on outreach, tone lint on drafts, real pipelines behind every demo. Mischief with guardrails.

---

## Next

- Voice sneaks: [Speech Hub](SPEECH_HUB.md) - Video sneak: [Demo Vid](DEMO_VID.md)
- Outreach loop: [Crossconnect Tour](CROSSCONNECT_TOUR.md) (chain 4) - Main: [README](README.md)
