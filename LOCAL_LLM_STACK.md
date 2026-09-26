# Local LLM Stack

The fleet thinks on one consumer GPU for EUR 0 per token. This page explains the hardware, the engines, and the open-weight models - US and PRC champions included. Snapshot late September 2026; the landscape for 24 GB cards is shifting fast for the better (3-bit quants, dual-resident setups), so the six-month rule applies (see [About](ABOUT.md)): re-check before buying hardware. Live tracking via aiwatcher-mcp and arxiv-mcp.

Repo: [local-llm-mcp](https://github.com/sandraschi/local-llm-mcp) (dashboard :10832, API + gateway :10833).

---

## Hardware: what you actually need

- **Cheapo minimum: NVIDIA with 16 GB VRAM.** That fits a 27B model in 3-bit plus context, or a 9B fast tier with room to spare. Used 3090-class cards are the budget entry.
- **Comfortable: RTX 4090 with 24 GB.** The reference box (Goliath). Bonsai 2 27B PQ2_0 holds ~12 GB, does ~50-60 tok/s, leaves real headroom for a second specialist + whisper STT + Kokoro resident. ComfyUI image gen stays on-demand.
- **VRAM math (Q4 vs 3-bit):** roughly 0.5 GB per billion params for Q4 weights, ~0.35-0.40 GB per billion for 3-bit (PQ2_0 / ternary-style) plus context overhead. 9B Q4 ~= 6 GB, 27B Q4 ~= 16-18 GB, 27B PQ2_0 ~= 11-13 GB, 70B needs 40 GB+ (two cards or offload - not recommended).
- **Why 3-bit wins on 4090:** 27B Q4 + 32k ctx = ~19-21 GB, whole card, KV starved, no second model. 27B PQ2_0 + 32k ctx = ~12-14 GB, leaving ~10 GB for larger KV, 65k/131k ctx, embeddings, STT, or a second 9B Q4 (~6 GB) resident in parallel.
- **MacBook alternative: RAM-maxed, super expensive, still slow.** Unified memory means a 27B model fits in 64-128 GB RAM, but inference runs on CPU/GPU-split without CUDA and lands far below NVIDIA tok/s for agentic loops. It works for chat; it drags for tool-calling agents. Buy VRAM, not RAM.

## Engines: Ollama, LM Studio, llama.cpp native, vLLM

| Engine | Port | Role |
|---|---|---|
| Ollama | 11434 | Classic stack (Qwen, Gemma, DeepSeek). Model pull/load/unload via tools |
| llama-server Bonsai sidecar (llama.cpp, compiled from source) | 11436 | Bonsai 2 27B PQ2_0 - primary brain, OpenAI-compatible, tools + vision |
| llama-server Glimmer (llama.cpp, compiled from source) | 11439 | Muse Glimmer 27B Q4 - escalation fallback, kept warm, no longer default. Ollama kquant GGUF too old, so native |
| Truncating proxy | 11435 | Front door for everything: trims oversized requests, pins the user message, whitelists tools |
| LM Studio | 1234 | Alternative engine + LM Link (Tailscale mesh for remote LLM access) |
| vLLM | managed | Docker lifecycle for serving setups |

Health checks every 60 s with circuit breakers (3 failures -> 60 s cooldown). One OpenAI-compatible gateway fronts 28+ cloud providers as fallback - budget under $20/month, alerted, never default for privacy, but far more capable than a year ago (see below).

## Open-weight champions: US vs PRC (late Sept 2026 snapshot)

Both superpowers ship genuinely open weights. The fleet runs either; pull whatever leads this month.

**Current default:**

- **Bonsai 2 27B PQ2_0.** 27B-class ternary / product-quant build, tools + vision, ~12 GB resident. Daily driver on Goliath via :11436. Same param count as Glimmer, ~8 GB cheaper in VRAM, room for 65k+ ctx and a second model. Configured in opencode as `bonsai/bonsai-2-27b` + lean agent `bonsai-lean` (32k, temp 0.2, 25 steps, no fleet MCPs, short replies). Caveat: 3-bit tool-discipline needs ongoing eval vs Q4 - keep Glimmer as escalation until Atlas / SWE-style local scores confirm parity.

**US champions:**

- **Meta: Llama 3.x + Muse Glimmer 27B + Muse Spark family.** Llama is the default open foundation. Glimmer (Meta Superintelligence Labs agentic distil of Muse Spark: tool use, long tasks, failure recovery, Apache 2.0) moves to fallback role. Muse Spark 1.3 contributor matters on the cloud side - cheap midlevel inference, trains on data, so local-first for anything private.
- **Google: Gemma 2 / 3 / 4.** Small-to-mid sizes (270M to 31B), vision + tools + thinking variants. Best perf-per-GB in the mid range, strong second-specialist candidate.
- **Microsoft: Phi-3 / Phi-4.** Lightweight 3.8B-14B models. Good fast-tier material.
- **OpenAI: gpt-oss (20B / 120B) + GPT-6 Luna (cloud).** gpt-oss 20B fits a 16 GB card. GPT-6 Luna is the new cheap cloud midlevel - relevant as fallback, not as brain.

**PRC champions:**

- **Alibaba: Qwen 2.5 / 3 / 3.5 / 3.6 (+ Coder, + VL).** Sizes from 0.5B to 235B+, dense and MoE, tools + thinking + vision. Still the best fast-tier / specialist pool (9B distil, 27B coder).
- **DeepSeek: R1 family (1.5B to 671B).** Open reasoning near frontier quality. Distils run locally; the big one stays in the cloud.
- **Zhipu: GLM (incl. GLM-OCR).** Multimodal document understanding, vision niche.
- **BAAI: bge-m3.** The embedding workhorse for local RAG (also: nomic-embed).

**Also running:** Mistral 7B (France - neither camp, still excellent), LLaVA vision, LoRA adapters for specialization.

Practical rule: brain = biggest agentic model that fits your VRAM in 3-bit with KV headroom (today: 27B PQ2_0 class on 24 GB). Fast tier / second slot = 9B Q4 or small specialist (coder, VL, OCR) resident in parallel. Embeddings = bge-m3 or nomic-embed, always local - your RAG index should never leave the box.

## Cloud fallback got cheap - policy unchanged

Midlevel cloud tokens collapsed in price: Muse Spark 1.3 contributor (cheap, trains-on-data tier) and GPT-6 Luna-class models buy 10-50x more tokens per EUR than 2025 midlevels. The $20/month gateway budget now covers real escalation volume.

Policy stays local-first:

- **Default:** Bonsai 2 27B via :11436, EUR 0, private.
- **Escalate to Glimmer :11439** for hard local reasoning / failure recovery where 3-bit wobbles.
- **Escalate to cloud midlevel** (Spark 1.3 contributor, Luna, etc.) only for 1M-ctx tasks, long-horizon coding marathons, or when both local brains fail. Never for RAG content, files, mail, or credentials. Document the exception; spend-watch still alerts.

In other words: cheap cloud changes the fallback math, not the privacy posture.

## What runs where on Goliath today

Chat, tool-calling, and vision on Bonsai 2 27B PQ2_0 via :11436, zero cloud cost. Glimmer 27B Q4 kept warm on :11439 for escalation. Kokoro TTS + faster-whisper STT resident on GPU (no more unload-to-think). ComfyUI sidecar for image gen, started on demand. Agent runners (cline-mcp, local-llm-mcp, opencode `bonsai-lean`) default to Bonsai with env overrides.

---

## Next

- The agent it powers: [Fritz](FRITZ.md)
- The product around both: [Coming Next](COMING_NEXT.md)
- Full protocol posture and cost model: [sandrafleetbot spec](https://github.com/sandraschi/documentation-mcp/blob/main/docs/projects/sandrafleetbot/README.md)
