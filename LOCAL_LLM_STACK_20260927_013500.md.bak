# Local LLM Stack

The fleet thinks on one consumer GPU for EUR 0 per token. This page explains the hardware, the engines, and the open-weight models - US and PRC champions included. Snapshot September 2026; the six-month rule applies (see [About](ABOUT.md)): re-check before buying hardware. Live tracking via aiwatcher-mcp and arxiv-mcp.

Repo: [local-llm-mcp](https://github.com/sandraschi/local-llm-mcp) (dashboard :10832, API + gateway :10833).

---

## Hardware: what you actually need

- **Cheapo minimum: NVIDIA with 16 GB VRAM.** That fits a 30B model in Q4 plus context, or a 9B fast tier with room to spare. Used 3090-class cards are the budget entry.
- **Comfortable: RTX 4090 with 24 GB.** The reference box (Goliath). Muse Glimmer 30B holds ~21 GB, does ~40 tok/s, leaves headroom for whisper STT and ComfyUI image gen (time-shared, shut down when idle).
- **VRAM math (Q4 quant):** roughly 0.5 GB per billion params for weights, plus context overhead. 9B ~= 6 GB, 30B ~= 18-21 GB, 70B needs 40 GB+ (two cards or offload - not recommended).
- **MacBook alternative: RAM-maxed, super expensive, still slow.** Unified memory means a 30B model fits in 64-128 GB RAM, but inference runs on CPU/GPU-split without CUDA and lands far below NVIDIA tok/s for agentic loops. It works for chat; it drags for tool-calling agents. Buy VRAM, not RAM.

## Engines: Ollama, LM Studio, llama.cpp native, vLLM

| Engine | Port | Role |
|---|---|---|
| Ollama | 11434 | Classic stack (Qwen, Gemma, DeepSeek). Model pull/load/unload via tools |
| llama-server (llama.cpp, compiled from source) | 11439 | Muse Glimmer 30B - Ollama's kquant GGUF is too old for it, so the fleet runs it natively |
| Truncating proxy | 11435 | Front door for everything: trims oversized requests, pins the user message, whitelists tools |
| LM Studio | 1234 | Alternative engine + LM Link (Tailscale mesh for remote LLM access) |
| vLLM | managed | Docker lifecycle for serving setups |

Health checks every 60 s with circuit breakers (3 failures -> 60 s cooldown). One OpenAI-compatible gateway fronts 28 cloud providers as fallback only - budget under $20/month, alerted, never default.

## Open-weight champions: US vs PRC (Sept 2026 snapshot)

Both superpowers ship genuinely open weights. The fleet runs either; pull whatever leads this month.

**US champions:**

- **Meta: Llama 3.x + Muse Glimmer 30B.** Llama is the default open foundation (119M+ Ollama pulls for 3.1). Glimmer is Meta Superintelligence Labs' agentic distil of Muse Spark: tool use, long tasks, failure recovery, Apache 2.0. The fleet brain.
- **Google: Gemma 2 / 3 / 4.** Small-to-mid sizes (270M to 31B), vision + tools + thinking variants. Gemma 4 updated days ago as of writing. Best perf-per-GB in the mid range.
- **Microsoft: Phi-3 / Phi-4.** Lightweight 3.8B-14B models. Good fast-tier material.
- **OpenAI: gpt-oss (20B / 120B).** Open weights for reasoning and agentic tasks. The 20B fits a 16 GB card.

**PRC champions:**

- **Alibaba: Qwen 2.5 / 3 / 3.5 / 3.6 (+ Coder, + VL).** The volume play: sizes from 0.5B to 235B+, dense and MoE, tools + thinking + vision. Qwen 3.5/3.6 updated days ago as of writing. The fleet's fast tier is a 9B Qwen distil.
- **DeepSeek: R1 family (1.5B to 671B).** Open reasoning models near frontier quality (92M+ Ollama pulls). Distils run locally; the big one stays in the cloud.
- **Zhipu: GLM (incl. GLM-OCR).** Multimodal document understanding, encroaching on the vision niche.
- **BAAI: bge-m3.** The embedding workhorse for local RAG (also: nomic-embed).

**Also running:** Mistral 7B (France - neither camp, still excellent), LLaVA vision, LoRA adapters for specialization.

Practical rule: brain = biggest agentic model that fits your VRAM in Q4 (today: 30B class on 24 GB). Fast tier = 9B class for triage and routine steps. Embeddings = bge-m3 or nomic-embed, always local - your RAG index should never leave the box.

## What runs where on Goliath today

Chat, tool-calling, and vision verified on Muse Glimmer 30B, zero cloud cost. Kokoro TTS + faster-whisper STT on GPU for the voice loop. ComfyUI sidecar for image gen, started on demand. Agent runners (cline-mcp, local-llm-mcp) default to Ollama/Glimmer with env overrides.

---

## Next

- The agent it powers: [Fritz](FRITZ.md)
- The product around both: [Coming Next](COMING_NEXT.md)
- Full protocol posture and cost model: [sandrafleetbot spec](https://github.com/sandraschi/documentation-mcp/blob/main/docs/projects/sandrafleetbot/README.md)
