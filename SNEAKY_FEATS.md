# Sneaky Feats

The rogues' gallery: four things the fleet does that have no business working as well as they do. Every sneak ships with a guardrail - that is the house rule for this page.

---

## 1. Talking to Alexa through the air

No Alexa API, no skill certification, no developer account. [alexa-mcp](https://github.com/sandraschi/alexa-mcp) synthesizes speech through the PC speakers, the Echo hears it like a human, faster-whisper transcribes the answer from the mic. "Gimme alexa weather report" in Claude becomes a loud "Alexa, weather report" in the room, and the transcript comes back. Full story: [Speech Hub](SPEECH_HUB.md).

## 2. Talking to cloud voice ingesters

Same trick, generalized: sound is the universal API. Anything with a microphone is callable - Siri, cloud voice assistants, any pipeline with speech input like Whisper-fronted tools. Our TTS talks to their STT; no integration meeting required. The flip side is why the shopping guard and the prompt-injection mitigations exist: never pipe unreviewed model output into a speaker that something powerful can hear.

## 3. Listening first, then building what they begged for

[fleet-public-relations-mcp](https://github.com/sandraschi/fleet-public-relations-mcp) monitors forum and Reddit threads (Cloudflare-resistant scraper, hourly) and triages every comment with a local model for competency and need. Approval-gated drafts, hype-word tone lint, escalation to admiral-mcp on high-competency hits.

The sneaky part is the competitive loop: the same surveillance watches competitor repos' threads for what users beg for - missing features, ignored issues, unanswered how-tos. Then the fleet builds exactly that. No scraping war, no ToS grey zone, just public threads read carefully: feature filch by listening. The listening postures as humble discovery ("genuinely helpful pointers"), and it is - the help is real, the roadmap intel is the bonus.

## 4. Demo videos where the agent really does it

[demo-vid-mcp](https://github.com/sandraschi/demo-vid-mcp) does not screencast staged demos. In desktop-capture mode, `mcp_call` steps invoke the target app's own MCP server mid-recording while OBS rolls: the video shows the agent doing the work because the agent is doing the work. A demo that cannot fail differently than the product fails. Full page: [Demo Vid](DEMO_VID.md).

---

## The house rule

Sneaks are allowed. Unsupervised sneaks are not: shopping guard on the speaker, approval gates on outreach, tone lint on drafts, real pipelines behind every demo. Mischief with guardrails.

---

## Next

- Voice sneaks: [Speech Hub](SPEECH_HUB.md) - Video sneak: [Demo Vid](DEMO_VID.md)
- Outreach loop: [Crossconnect Tour](CROSSCONNECT_TOUR.md) (chain 4) - Main: [README](README.md)
