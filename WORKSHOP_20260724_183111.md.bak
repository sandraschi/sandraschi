# 🛠️ Workshop & Hardware

The Alsergrund node runs on a single beefy Windows machine nicknamed **Goliath**.

## Main Node: Goliath

| Component | Specification |
| :--- | :--- |
| **CPU** | AMD Ryzen 9 5900X (24 cores) |
| **GPU** | RTX 4090 24GB VRAM |
| **Memory** | 64GB DDR4 |
| **Storage** | 30TB HDD Array |
| **OS** | Windows 11 Pro |
| **IDEs** | Cursor · Windsurf · Google Antigravity |
| **Inference** | Ollama · LM Studio · Claude Desktop Pro |

## Local LLM Stack

RTX 4090 sweet spot: **Qwen3.5 27B @ Q4 quant** (~40 tok/s). For MoE efficiency: **Qwen3.5 35B-A3B** (112 tok/s, only 3B active params). Hard ceiling ~32B at Q4. Hybrid pattern: local model handles 60–70% of the coding session, Claude Sonnet for hard problems.

## Robotics Hardware

- **Yahboom Raspbot V2** ("Boomy") — Raspberry Pi 5, ROS 2, camera, ultrasonic, running Gemma 4 locally
- **[Noetix Bumi](BUMI.md)** (incoming) — 94cm, 12kg, 16-DOF humanoid, FOSS-friendly, JD.com

## Fleet Architecture

Every MCP server in the fleet follows the same pattern:
- **FastMCP 3.2** server core with portmanteau tools (no tool explosion)
- **Webapp sidecar** — React + Vite + Tailwind dark glass dashboard for human oversight
- **`uv`** for Python environment management
- **mcpb** packaging for Glama.ai publication

→ **[Published servers on Glama.ai](https://glama.ai/mcp/servers?query=sandraschi)**

---

*Alsergrund Node · Vienna · 2026*
