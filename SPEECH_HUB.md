# Speech Hub: the Voice Crossconnect

Repo: [speech-mcp](https://github.com/sandraschi/speech-mcp) (backend :10909, frontend :10908). Special mention because it crossconnects with basically everything: every repo with a status can be asked aloud, every agent run can be narrated, every robot can take orders.

---

## The bus

Wake word detected fully offline (openWakeWord, no cloud). Utterance transcribed locally (Alibaba FunASR default: VAD + ASR + punctuation + diarization in one call, up to ~170x realtime on GPU, no per-minute STT tax). Intent posted to fleet-agent `/api/voice/intent` over the Voice Command Bus. Reply spoken back via local TTS (Kokoro/SAPI5) or cloud voices (Gemini, ElevenLabs cloning) when quality matters. Streaming STT with barge-in for real conversation; offline duplex via kyutai-mcp alongside.

Extras that grew over 2026: voice memory (episodic diary), voice macros (spoken phrase -> action), translation bridge, sound-event detection, named voice bank, speech analytics with real latency/cost telemetry, and a humanoid-voice thesis doc worth reading ([HUMANOID_VOICE.md](https://github.com/sandraschi/speech-mcp/blob/main/docs/HUMANOID_VOICE.md)).

## Two mornings that show it

- **"Speechy fritz gimme overnight arxiv humdingers."** Wake -> local STT -> intent to Fritz -> overnight aiwatcher surge + arxiv codehunt pulled -> Glimmer composes the briefing -> spoken back + report on the hub board. The morning briefing demo, fully local.
- **"Speechy home all devices working check."** Intent to devices-mcp and home-assistant: plugs, lights, lock, doorbell polled, exceptions spoken ("all working except the balcony plug"), full grid on the dashboard.

Same pattern drives robots ("boomy go on patrol", Yahboom voice integration doc in-repo), narrates renders ("render done"), and reads alerts. Any fleet repo becomes voice-operated the moment its status is queryable - which is all of them.

## Why FunASR (the PRC connection)

Chinese open-weight industrial speech (FunASR, SenseVoice, CosyVoice) ships as deployable tooling with published benchmarks and ONNX edge builds - ahead of "just run Whisper" for agent pipelines (segments + speakers + punctuation in one pass). Same story as the LLM champions ([Local LLM Stack](LOCAL_LLM_STACK.md)): track both camps, run whatever leads.

---

## Next

- The tour it narrates: [Crossconnect Tour](CROSSCONNECT_TOUR.md) - The agent it talks to: [Fritz](FRITZ.md)
- Video voiceovers: [Demo Vid](DEMO_VID.md) - Bus spec: Voice Command Bus standard (mcp-central-docs)
