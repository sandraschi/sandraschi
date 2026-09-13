# The -phile Fleet: AI Travel and Learning Guides per Culture

The concept: one repo per culture you love (or want to). Language learning framed as your longrunner game, a culture/econ/history knowledge box, travel planning, and a diary of your own journey through it. Linked from [Wrapee Categories](WRAPEE_CATEGORIES.md) as the emerging sixth kind. Status: concept + first repo scaffolded ([japanophile-mcp](https://github.com/sandraschi/japanophile-mcp), Stage 1).

---

## The shape (same four faces everywhere)

- **Learn.** Language tools, spaced repetition, exam-style tracks (JLPT prep as a daily game - chess-two-hours-a-day energy, not duolingo guilt).
- **Know.** Culture, econ, history knowledge box: guides, knowledge trees, manga-equivalents, trivia with sources.
- **Plan.** Travel planning: transit, bookings, itineraries (the vienna-life-assistant pattern, pointed abroad).
- **Remember.** Diary + history log of your own progress through the culture.

Two faces per repo as always: MCP handle for agents, dashboard + winapp for humans, chat page ingesting the culture's skill files.

## Launch order: Europe first, not too tiny

Start where corpora and contributors exist: **France, Italy, Spain, Germany** - big languages, big travel flows, endless public-domain material. Plus **Japan first in practice**, because the corpus already exists (see below) - japanophile-mcp jumps the queue on merit. And **Austria is not far behind**: [vienna-life-assistant](https://github.com/sandraschi/vienna-life-assistant) is the starter seed for austrophile-mcp.

Skip microstates initially: a Liechtenstein-phile has no corpus and no contributors. The long tail - **Botswana and friends** - comes later, with human contributors solicited per culture once the template is proven. Weird countries are the point of the long tail, not the launch.

## First mover: japanophile-mcp (scaffolded)

Repo: [japanophile-mcp](https://github.com/sandraschi/japanophile-mcp) (Stage 1: MCP tools). It inherits the Japanese cluster formerly living only inside ai-games-collection: the Japanese Language games category, kanji/JLPT data (13k-kanji DB), README_JAPANESE, kanji-learning-suite docs, Knowledge Tree, Manga Guide. Games repo keeps playable hanafuda/cho-han via crossconnect. Travel planning (JR-pattern transit, bookings) and the diary are new builds. Working title weeaboo-mcp, polite alias japanophile-mcp for listings.

## Why no travel site does this

There are fucktons of Japan travel sites. None that we can find ships the 2026 SOTA concept: content that is **agent-operable and local-first**, not just readable.

- **MCP handle.** Agents don't browse the guide, they call it: quiz me, plan the leg, check my streak, read the history page and summarize. Claude Desktop, Cursor, opencode, Fritz - same tools.
- **Chat with skills, not a search box.** The chat page ingests japanophile-expert: method, JLPT routing, culture answers with page citations. "Am I ready for N4?" gets an answer from your progress store, not generic advice.
- **Memory.** Quiz scores, streaks, diary: the companion knows where you are in the journey. A travel site forgets you at the tab close.
- **Voice.** "Speechy japan, quiz me on N4 food words while I cook" - speech-mcp bus, local STT, spoken answers. No travel site does dishes with you.
- **Local and EUR 0.** Seeds + local model. No account, no subscription, no per-query meter.
- **Crossconnected.** Manga via komga/kavita, video via bilibili-mcp, goods via prc-shopping-mcp, transit via the mywienerlinien pattern pointed at JR. The guide is a node, not a silo.

That stack - MCP + skills chat + progress memory + voice + local LLM + fleet links - is the moat. Content can be copied; an operable companion cannot be screenshotted.

## Japan now: September 2026 snapshot (re-check quarterly)

Dated context the knowledge box carries. Facts from Wikipedia's 2026-in-Japan record; analysis is ours. Six-month rule applies.

**Travel to and in Japan.** Rural lines keep dying (JR Hokkaido's Rumoi Main Line closed April 2026 after 115 years - rent the car, check buses). Residential speed limit dropped to 30 km/h nationwide Sept 1, 2026. Coming up: Asian Games in Aichi Sept 19-Oct 4 (book around it, not through it), Shuri Castle restoration completes this autumn, Asuka-Fujiwara just made UNESCO (July 2026). Panda diplomacy ended: Japan's last giant pandas left Ueno Zoo January 2026.

**Info sources.** The Japan Times for English dailies, NHK World for broadcast, Asahi/Yomiuri via machine translation for depth, aiwatcher-mcp with a Japan surge profile for the ongoing feed. The knowledge box links sources per page; unsourced trivia gets cut.

**The cheap-yen miracle.** Yen near historic lows: tourists get a discount Japan, exporters report record quarters, Nikkei printed all-time highs twice this year (54k January, 60k April). Nihonjin pay for it in import prices - energy, food, the weekly shop. Both halves belong in the econ pages; a guide that only cheers the cheap sushi is lying.

**The rightward drift.** LDP under Sanae Takaichi (first female PM) took a postwar-record two-thirds majority in the February snap election; Article 9 revision is openly debated with large counter-protests; arms-export ban lifted April 2026; first postwar intelligence bureau approved; flag-desecration law in force. Real drift, still recognizably within democratic rails - and far less bad than the European and American variants. State it plainly, source every claim, revisit each snapshot: this paragraph rots fastest.

## Editorial line: no extremism, any direction

Love of a culture is not endorsement of its worst corners. All -phile repos keep every kind of extremism out: no propaganda, no revisionism, no glorification, from any side. History pages document with sources; travel and diary faces stay clear of political agitation entirely. Contributors agree to this with their first commit; violations get reverted, repeat violations lose commit access. Document, don't amplify.

## Proof it is a pattern: sinophile-mcp

Second instance, same four faces: hanzi suite, history box, travel planner, diary. If two cultures work, N work - new cultures clone the template and swap the corpus. vienna-life-assistant already rhymes with it (functionally viennaphile-mcp); the kanji DB is a -phile data layer waiting for extraction.

## Contributor model (later)

Template proven -> per-culture human contributors solicited for the long tail: native speakers for the Learn face, locals for Plan, historians for Know. Agents do the scaffolding and the transcribing; humans supply taste and truth. Same approval-gated pattern as the PR outreach loop.

---

## Next

- Pattern home: [Wrapee Categories](WRAPEE_CATEGORIES.md) - First repo: [japanophile-mcp](https://github.com/sandraschi/japanophile-mcp)
- Siblings: [vienna-life-assistant](https://github.com/sandraschi/vienna-life-assistant) (the accidental prototype), [gitee-mcp](https://github.com/sandraschi/gitee-mcp) (small-language-ecosystem precedent)
