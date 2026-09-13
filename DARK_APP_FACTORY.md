# Dark App Factory: Neglected but Interesting

Repo: [dark-app-factory](https://github.com/sandraschi/dark-app-factory) (dashboard :10738). Status v0.2.2-beta, proof of concept, honestly so. Neglected, not dead - the ideas are load-bearing even where the code is young.

---

## The concept

Describe an app in plain text ("a webshop for a climbing club with member registration and Stripe checkout"). A Foreman LLM turns the vibe into specs and test scenarios. Then 19 specialist agents - Plumber (routes), Sculptor (React), Morpheus (auth), Picasso, Houdini, Tesla, Amodei, Hawks and friends - generate in dependency-resolved parallel tiers, so routes exist before components import them. A Judge then installs deps, boots the app, runs the scenarios, and fails hard on a bad boot (no false PASS from probing the wrong port). A Digital Twin Universe mocks Stripe, Auth, Email, SMS, and Storage so the boot test runs against fakes, not real APIs.

## Why it matters anyway

- **The loop shape is right**: foreman -> parallel specialists -> empirical judge. Coherent multi-file projects, not isolated stubs.
- **Building blocks beat tokens**: keyword-triggered blocks (MCP client, Stripe, webshop, membership) give ~1500 lines of tested implementation under ~50 lines of LLM glue. The roadmap (email, storage, admin, booking, CMS, AI chat, notifications) reads like every generated app ever requested.
- **Local by design**: runs on Ollama (dual-LLM on one 4090: 24B foreman + 12B workers), no cloud required.

## Honest limits (from its own README)

Output quality tracks model size (8B models write thin code), no auto-repair for missing deps or tsc failures, 5-30 minute pipelines, in-memory state, Windows-tested only. A generated scaffold almost always needs manual fixing. Convergence loop (judge FAIL -> feed errors back -> regenerate) is roadmap, not reality.

## Next

- Sibling neglected gem: [RoboFang](ROBOFANG.md) - Parent: [Dev Stack](DEV_STACK.md)
- The brain it will use when grown: [Local LLM Stack](LOCAL_LLM_STACK.md)
