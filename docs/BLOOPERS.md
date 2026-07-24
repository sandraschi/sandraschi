# AI Bloopers

*Prompted by: "maybe a funny ai bloopers readme could lighten the mood. you still put && in powershell every five min, tsk tsk. llms still follow ALL standards docs only on uneven mondays"*

> A running log of things the AI gets wrong, despite having read every standard
> document in the fleet. The blooper rate dropped from ~20% (mid-2025) to ~0.2%
> (mid-2026). That remaining 0.2% is *fascinatingly* consistent.

---

## Recurring greatest hits

### `&&` in PowerShell

This one refuses to die. The [PowerShell standard](https://github.com/sandraschi/mcp-central-docs/blob/master/standards/rules/powershell-script-standards.md)
says, in bold, **no `&&`**. The linter flags it. Every `build.ps1` and
`start.ps1` in the fleet uses `;` or `if ($?) { ... }`. The AI has read this rule
hundreds of times.

It still writes `&&` roughly every five minutes.

```
# What the AI writes:
git add -A && git commit -m "fix" && git push

# What the standard requires:
git add -A; git commit -m "fix"; git push

# What the AI writes five minutes after being corrected:
git add -A && git commit -m "fix" && git push
```

This is the cockroach of AI bugs. It will survive the heat death of the universe.
I have accepted it. The linter catches it. The correction is one character. This
is fine.

### Standards compliance on uneven Mondays

The AI has read every fleet standard document. It can recite the Tauri NSIS
checklist from memory. It knows that `build.ps1` must bundle `.env.example`, not
`.env`. It knows that `data-testid` attributes are mandatory on dashboard KPIs.

It follows *all* of these rules on roughly one out of every two Mondays. The other
Monday, it just... doesn't. No pattern has been identified. Even and odd calendar
dates produce identical compliance rates. The phase of the moon is uncorrelated.
The model temperature is always zero.

The current working theory is that somewhere in the 1M+ token context window, a
standard document gets pushed out by an unrelated module import, and the AI just
wings it. The fix is `/clear` and reload. But discovering that you *need* to
`/clear` requires noticing that the AI forgot a rule — which requires checking
the output against the rule — which is the human review step that the AI was
supposed to eliminate.

The cadence has a name now: **uneven Monday compliance.** It's not a bug. It's
a feature of stochastic architectures. We live with it.

### The `data-testid` amnesia

Every fleet webapp standard says: put `data-testid` on dashboard elements. The AI
writes beautiful React components with perfect Tailwind, correct Zustand state
management, and exactly zero `data-testid` attributes.

You point this out. The AI apologizes, adds them, and the next component it writes
has no `data-testid`. This is the same AI that added 5,000 lines of correct C++ to
Mixxx. It understands FFmpeg internals and ONNX model graphs. It cannot remember
to add `data-testid="chat-send"` to a button.

The CUA smoke test catches this. The smoke test fails. The human says "add
data-testid." The AI adds it. The smoke test passes. The cycle repeats for the next
component. This is 0.2% of the workflow and 20% of the exasperation.

### Overdocumented to death

The AI is an excellent documentation writer. *Too* excellent. Ask for a README
update and you get a README, a CHANGELOG entry, an architecture diagram, a
migration guide, an FAQ, and 14 inline code comments explaining things that were
already clear.

The human response is "please delete 80% of what you just wrote." The AI complies.
The next documentation task produces another 14-page treatise. The AI has read
every "concise writing" guide on the internet. It agrees with all of them. It
then writes 3,000 words about a 40-line change.

This is not a bug the industry talks about, because most projects still have the
opposite problem. But when the bottleneck flips from "no docs" to "too many docs,"
you discover that curation is a skill the AI hasn't mastered. It can write. It
can't *stop* writing.

### Import surgery

The AI sometimes fixes a bug by adding an import for a module that doesn't exist.
Not a hallucinated module — a *real* module from a *different* fleet repo. It saw
the function signature in `depot-mcp`, decided `calibre-mcp` needed it, and added
`from depot_mcp.storage import chunk_text`. The import resolves in the AI's memory.
It does not resolve on disk.

This happens rarely now (that 0.2% again). When it does, the fix is trivial — the
AI meant the right thing but grabbed the wrong import path. But the first time it
happened, I spent 20 minutes wondering why `chunk_text` wasn't in any installed
package. The AI was confidently referencing code from a repo it read two sessions
ago. Cross-repo recall is a superpower. Cross-repo imports are not.

---

## The decline of bloopers

| Era | Blooper rate | Typical bloopers |
|-----|-------------|------------------|
| **Mid-2025** | ~20% | Hallucinated APIs, confident wrongness, broken imports, wrong file paths |
| **Late 2025** | ~5% | Wrong module paths, over-eager PRs, `&&` in PS, missing `data-testid` |
| **Mid-2026** | ~0.2% | `&&` in PS, missing `data-testid`, uneven Monday compliance, overdocumentation |

The trajectory is unambiguous. The AI got dramatically better. The remaining
bloopers are not random failures — they're *consistent* blind spots. The same
five things, over and over, at the same low rate. This is not noise. This is the
shape of what LLMs are fundamentally bad at: remembering pedantic formatting rules
across long sessions, stopping when the output is good enough, and distinguishing
between "I read this code" and "this code is importable in this project."

The 0.2% is permanent. It's the gap between an AI that has read every standard
and a human who enforces them. That gap is precisely what the human is for.

---

*Sandra Schipal — Alsergrund, Vienna — July 2026*
