# So You Want to Be a ~~Vibecoder~~ "Agentic Architect"

> Practical, dated notes on getting more out of AI coding tools. Longer-form, more vendored, snarkier version lives at **[vibecoding-notes](https://github.com/sandraschi/vibecoding-notes)** - this page is the fleet-house-style duplicate.

**Dated:** 2026-09-15 - re-verify pricing/benchmarks before trusting this after a few months, this space moves fast.

---

## Round-robin your AI subscriptions instead of paying for one premium plan

Frontier AI coding tools price in tiers: a $20/mo plan gets a rolling usage window (typically ~5 hours) plus a weekly quota. A $200/mo plan gets a much bigger version of the same thing. Most solo devs don't need 10x throughput - they need to not get walled off mid-task.

Instead of picking one tool and paying for headroom used a few hours a day, **run several $20/mo accounts across different tools and hand off between them** as each one's window tightens.

My setup: Claude Code + opencode + agy + Cursor, each on its base $20/mo tier (~$80/mo total). Work in one until its usage window is close to resetting or its weekly quota % gets tight, switch to the next. By the time the rotation comes back around, the first has usually reset - near-continuous availability without paying for one big plan.

What makes this workable now: current tool UIs show the three numbers you need to time the handover:

1. Time left in the current usage window (e.g. "resets in 47 min")
2. Weekly quota consumed (%)
3. Context window remaining in the active session

Watch those three, switch when any one gets tight. Do the math for your own situation: N accounts at $20/mo is $20N/mo, not $20/mo - you're arbitraging against a single $200/mo plan, not against doing nothing.

## Adding a cheap/open model to the rotation (e.g. DeepSeek)

Open-weight API models can slot in as one more rotation member, but two pricing quirks trip people up:

**1. Peak/off-peak windows are keyed to the provider's region, not yours.** DeepSeek prices peak hours as 01:00-04:00 and 06:00-10:00 UTC, Mon-Fri, at roughly 2x the off-peak rate. Whether that's easy to dodge depends entirely on your local time overlap with that UTC window - do the conversion for your own timezone and sleep schedule before deciding.

Example: I'm in Vienna (UTC+2) and sleep 3am-10am local, so the entire peak window is already covered by sleep except a ~2-hour tail (10:00-12:00 local) on weekdays. Someone in the same timezone who's up at 7am eats peak rates most mornings. Also - if your workflow avoids unsupervised overnight agent jobs (mine does), you're not farming the off-peak window automatically. Real off-peak-eligible usage is bounded by your actual manual working hours.

**2. "Contributor" / discount tiers often trade data for price.** Meta's Muse Spark "Contributor" tier offers a ~3x discount in exchange for training on your prompts and completions. That's a privacy trade, not a pure discount - weigh it explicitly.

## Checklist before adding any model/tool to the rotation

1. Realistic price per M tokens on **non-cached, non-batch** usage (vendors lead with best-case cache-hit/off-peak numbers - don't budget on those)
2. Does the peak/off-peak or regional pricing window overlap your real working hours?
3. Does the cheap tier require a data/training trade-off you're fine with?
4. Do the benchmarks for your actual workload justify the switch - independently verified score, or just vendor-reported?

Fleet cross-reference: [mcp-central-docs/patterns/AI_SUBSCRIPTION_ROTATION_OPTIMIZER.md](https://github.com/sandraschi/mcp-central-docs/blob/main/patterns/AI_SUBSCRIPTION_ROTATION_OPTIMIZER.md) has the same pattern in fleet-standard doc format.
