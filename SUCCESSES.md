# Our (Nontrivial) Successes

A running log of wins worth remembering — not routine commits, not vanity metrics. Each entry here cleared a real bar: external validation from someone with no reason to be nice, a genuinely hard problem actually solved, or an objective public threshold breached. Dated, so bragging doesn't quietly become stale bragging.

**Why this exists, separately from CHANGELOG.md or COMING_NEXT.md:** those track what shipped and what's next. This tracks what actually *worked* in a way that surprised us — the moments worth pointing to later when someone asks "does any of this actually work." Mirrored as a chain of memops notes (folder `successes/`) so it's queryable from the memory side too, not just readable as a file.

## The bar for an entry

- **External validation**, not self-assessment — a maintainer, reviewer, or user with no stake in flattering us said so.
- **A genuinely hard, objectively checkable problem solved** — a compiler/proof checker said yes, not "looks right."
- **A real public threshold crossed** — not "we're proud of this," an actual number that meant something before we hit it.

Vanity metrics, self-congratulatory milestones, and "we shipped a thing" don't qualify — those live in CHANGELOG.md, where they belong. Something that's a genuinely ambitious, well-built concept but hasn't yet cleared the bar goes in **Success candidates** below the log, not into the log itself.

---

## Log

### 2026-09-15 — Fritz's first externally well-received agentic PR

[Fritz](FRITZ.md)'s `fritz_contribute` workflow (clone → lint → issue → branch → fix → PR) had, until now, only been verified end-to-end against our own test repos. On 2026-09-15 it produced a PR to an external repo (obscura) that got a genuinely positive comment back from the maintainer — the first time an agent-authored PR from this fleet landed well with someone who had zero reason to be polite about it. Workflow lineage traces back to ideas from a "sakura bot" repo.

---

### 2026-09-15 — Automated NSIS/Tauri build + CUA smoke test proving a winapp works end to end

The `just build-native` → `just cua-nsis-test` pipeline (PyInstaller → Rust → NSIS build, then a pywinauto-driven CUA test that installs the real installer, launches the app, verifies it, and uninstalls it) now reliably proves a packaged Tauri desktop app actually works — not "compiles," works. This catches the specific failure classes that unit tests and Playwright E2E structurally can't: backend unreachable after install, WebView2 racing ahead of a not-yet-ready backend, CSP/CORS misconfiguration blocking API calls, silent install failures, and registry left behind after uninstall. Full install-through-teardown, automated, no manual click-through required to trust a release. This is the CUA-smoke-test layer from [vibecoding-notes' testing note](https://github.com/sandraschi/vibecoding-notes/blob/main/testing-coverage-e2e-cua-smoke.md) actually running in production against real fleet installers, not just described as a good idea.

---

### 2026-09-15 — The macro/SOP chain (assfix, fakefind, ghaudit) turned out to be tool-portable, not opencode-only

`assfix`, `fakefind`, and `ghaudit` were built as named macros for opencode — a short utterance expanding into a written multi-phase SOP (see [named-macros-as-ops-for-agents.md](https://github.com/sandraschi/vibecoding-notes/blob/main/named-macros-as-ops-for-agents.md) for the pattern writeup). The genuinely hard problem this quietly solved: **the SOPs themselves are plain markdown, not opencode-specific plugin code**, so any other IDE or agent that can read a file and follow instructions can execute the same procedure when pointed at the SOP directly and prompted suitably — no opencode-specific integration required. The named-macro trigger is a opencode-native convenience; the actual capability lives in the SOP text, which is tool-agnostic by construction. That's the difference between "we built a feature for one IDE" and "we wrote a procedure any agent can run," and it wasn't originally the explicit design goal — it fell out of keeping the SOPs as plain files instead of baking them into tool-specific code.

---

## Success candidates (self-assessed, not yet externally validated)

Things that feel like real wins — ambitious, well-executed, worth being proud of — but honestly haven't cleared the log's actual bar above: no outside validation, no objectively-checkable pass/fail, no public threshold. Listed here instead of the log so pride doesn't quietly become the self-congratulation the log exists to exclude. A candidate graduates to the log above only when something external or objectively checkable actually happens to it — not when it's been sitting here long enough to feel earned.

- **[arxiv-mcp](https://github.com/sandraschi/arxiv-mcp)** — the whole concept: a high-density research pipe (hybrid RAG depot, citation graphs, DOI resolution across 50,000+ publishers, code-hunt tracking) that's genuinely comprehensive. No external user or reviewer on record yet. Graduates when one shows up, or when a specific capability inside it (e.g. the epistemics/codehunt pipeline) catches something real and checkable.
- **[aiwatcher-mcp](https://github.com/sandraschi/aiwatcher-mcp)** — same story: multi-source ingestion, Claude-scored urgency triage, cross-fleet alerting, all genuinely well-built. Graduates the day its urgency scoring demonstrably catches a real breaking event before you'd have known otherwise, in a way you can point to afterward — not on general vibes of "this is a good system."

---

## Watching for (not yet achieved — listed so we notice when they land)

- **An Eötvös competition problem formally solved via [leanforge-mcp](https://github.com/sandraschi/leanforge-mcp)** — the proof-loop pattern (LLM proposes, Lean compiler checks, LLM reads the error and retries) actually closing out a real, recognized competition-difficulty problem, not a toy lemma.
- **Any fleet repo crossing 1,000 GitHub stars** — an actual adoption signal, not a controlled metric we can game with a PR post.

Move an item from here to the log above only when it actually happens — this section is a watchlist, not a promise.
