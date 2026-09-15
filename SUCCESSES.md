# Our (Nontrivial) Successes

A running log of wins worth remembering — not routine commits, not vanity metrics. Each entry here cleared a real bar: external validation from someone with no reason to be nice, a genuinely hard problem actually solved, or an objective public threshold breached. Dated, so bragging doesn't quietly become stale bragging.

**Why this exists, separately from CHANGELOG.md or COMING_NEXT.md:** those track what shipped and what's next. This tracks what actually *worked* in a way that surprised us — the moments worth pointing to later when someone asks "does any of this actually work." Mirrored as a chain of memops notes (folder `successes/`) so it's queryable from the memory side too, not just readable as a file.

## The bar for an entry

- **External validation**, not self-assessment — a maintainer, reviewer, or user with no stake in flattering us said so.
- **A genuinely hard, objectively checkable problem solved** — a compiler/proof checker said yes, not "looks right."
- **A real public threshold crossed** — not "we're proud of this," an actual number that meant something before we hit it.

Vanity metrics, self-congratulatory milestones, and "we shipped a thing" don't qualify — those live in CHANGELOG.md, where they belong.

---

## Log

### 2026-09-15 — Fritz's first externally well-received agentic PR

[Fritz](FRITZ.md)'s `fritz_contribute` workflow (clone → lint → issue → branch → fix → PR) had, until now, only been verified end-to-end against our own test repos. On 2026-09-15 it produced a PR to an external repo (obscura) that got a genuinely positive comment back from the maintainer — the first time an agent-authored PR from this fleet landed well with someone who had zero reason to be polite about it. Workflow lineage traces back to ideas from a "sakura bot" repo.

---

### 2026-09-15 — Automated NSIS/Tauri build + CUA smoke test proving a winapp works end to end

The `just build-native` → `just cua-nsis-test` pipeline (PyInstaller → Rust → NSIS build, then a pywinauto-driven CUA test that installs the real installer, launches the app, verifies it, and uninstalls it) now reliably proves a packaged Tauri desktop app actually works — not "compiles," works. This catches the specific failure classes that unit tests and Playwright E2E structurally can't: backend unreachable after install, WebView2 racing ahead of a not-yet-ready backend, CSP/CORS misconfiguration blocking API calls, silent install failures, and registry left behind after uninstall. Full install-through-teardown, automated, no manual click-through required to trust a release. This is the CUA-smoke-test layer from [vibecoding-notes' testing note](https://github.com/sandraschi/vibecoding-notes/blob/main/testing-coverage-e2e-cua-smoke.md) actually running in production against real fleet installers, not just described as a good idea.

---

## Watching for (not yet achieved — listed so we notice when they land)

- **An Eötvös competition problem formally solved via [leanforge-mcp](https://github.com/sandraschi/leanforge-mcp)** — the proof-loop pattern (LLM proposes, Lean compiler checks, LLM reads the error and retries) actually closing out a real, recognized competition-difficulty problem, not a toy lemma.
- **Any fleet repo crossing 1,000 GitHub stars** — an actual adoption signal, not a controlled metric we can game with a PR post.

Move an item from here to the log above only when it actually happens — this section is a watchlist, not a promise.
