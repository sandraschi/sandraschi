# Rustification (r11n)

**r11n** is the numeronym (r + 11 + n). The fleet's Python/FastMCP + React/Vite repos are
being ported, one repo at a time, onto the Pure-Rust ArtCraft pattern: one Cargo
workspace, a native desktop app, and an MCP server that speaks the same JSON-RPC the
Python one did.

It is not a rewrite for its own sake. Each port keeps the wrapee, the tool names, the
credential file and the ports. What changes is the runtime under them.

First converts: `rust-devices-mcp` (golden blueprint), `rust-plex-mcp`,
`rust-calibre-mcp`, `rust-arr-mcp`, `rust-yahboom-mcp`, `rust-sdr-mcp`.

---

## What a converted repo looks like

Four crates, and only the first one is domain code written from scratch:

```
rust-<domain>-mcp/
  Cargo.toml                  workspace + clippy deny(unwrap_used, expect_used, panic, todo, unimplemented)
  justfile                    check / test / fmt-check / run-mcp / run-cli / build-release
  installer/installer.nsi     current-user NSIS, Start Menu entry, uninstaller, no UAC
  crates/
    <domain>-core/            L1: the 2-6 protocol driver files, Command enum, dispatch()
                              plus bridge.rs, llm.rs, error.rs, creds.rs, import.rs, vault helpers
    <domain>-store/           L1 optional: bundled rusqlite historian (only when the domain has history)
    <domain>-mcp/             L2: clap CLI (--json) + stdio MCP server, dual-aliased tool names
    <domain>-app/             L3: eframe/egui desktop app, page-for-page with the legacy webapp
```

The CLI, the MCP server and the desktop app all dispatch through the same `Command` enum,
so three front ends cannot drift apart. That is the structural win, and it is the reason
the port is worth the effort even when the Python repo worked.

---

## Why we do it

1. **Crash classes become compile errors.** `unwrap_used`, `expect_used`, `panic`, `todo`
   and `unimplemented` are denied workspace-wide. A handler that would have thrown a
   Python traceback at 2am fails `cargo clippy` instead. The standard operating
   procedure (SOP) adds the runtime half:
   no byte-index string slicing (German umlauts, degree signs), no `v[i]` indexing,
   read-only SQLite handles with a busy timeout for databases another program also owns.
2. **No environment drift.** No `.venv`, no uv sync, no Python minor-version surprises,
   no `node_modules`. Two binaries and a Cargo.lock. "Works on my machine" stops being a
   category of bug.
3. **Measured resource profile.** A GPU-rendered egui app instead of a browser tab plus a
   Node dev server. Boot time and binary size are recorded in each repo's README rather
   than asserted.
4. **Smaller supply chain.** Cargo lockfile committed, no wheel tree, no npm tree. The
   installer is under 25 MB by target (the SOP's number, not a claim about every repo).
5. **One dispatch path.** Adding a verb means one enum variant, not one Python function
   plus one REST route plus one React call plus one Tauri wrapper.
6. **The port is affordable because 70% is not written.** Nearly 70% of a fleet repo is
   domain-agnostic: `bridge.rs` (aiwatcher/speech/webhook), `llm.rs` (Ollama, LM Studio,
   OpenAI, Anthropic), `error.rs` + `creds.rs`, `vault.rs` + `registry.rs`, the egui shell
   (theme, zoom, chat, settings, help, raw JSON pages), the MCP stdio loop, `justfile`,
   `installer.nsi`. That kernel is copied with a crate-name substitution. Only the domain
   driver, the command enum and the domain pages are new.

---

## Is it automated? Yes, with two hard stops

`r11n` is a **macro with phases, not a one-click converter**. `repconv <repo>` is the
trigger; the work is split by who can do which part cheapest and most reliably.

| Work | Done by | LLM tokens |
|---|---|---|
| Workspace stamp, kernel copy, dossier/log skeleton | `scripts/New-RustArtcraftRepo.ps1` | 0 |
| Phase 0 dossier, tool-to-command mapping table | cheap or local model, structured markdown | 0-10k (non-frontier) |
| Phase 2: domain protocol + `import.rs` | frontier model, compiler-bounded | ~10-15k |
| Phase 3: CLI flags + MCP match arms | mid-tier model (exhaustive match catches omissions) | 0 (non-frontier) |
| Phase 4: egui page functions | mid-tier model, chrome already exists | ~5k |
| Phase 5: gates, live probe, NSIS, release | terminal + cheap summarizer | 0 |
| Phase 0 sign-off, UI oracle capture, live probe call, cutover, archive | human | - |

Hard stop 1: **no `.rs` file may be written before `docs/CONVERSION_DOSSIER.md` exists**
(a 7-point forensic recon: bucket classification, port and database contention, legacy
git SHA, the 1:1 tool and portmanteau-operation mapping, credentials inventory, write-safety
fence, UI oracle screenshots).

Hard stop 2: **no release before all six gates pass**, and no "done" before the seven
cutover criteria are met.

Everything in between is resumable: every phase appends to `docs/CONVERSION_LOG.md`,
updates `HANDOVER.md` and makes a checkpoint commit, so a context limit or a crash costs
minutes, not a session.

---

## The phases

| Phase | Output | Gate to leave it |
|---|---|---|
| 0 | `docs/CONVERSION_DOSSIER.md` + `CONVERSION_LOG.md` + screenshots of every legacy page and primary gesture | committed dossier |
| 1 | workspace, lint denies, kernel, `justfile`, NSIS skeleton | `cargo clippy` clean on an empty domain |
| 2 | L1 driver + `Command::dispatch` + `import.rs` reading the sibling Python `.env`/`config.yaml` | unit tests on golden JSON fixtures |
| 3 | L2 `clap` CLI `--json` + stdio MCP server, legacy portmanteau aliases preserved | `initialize` + `tools/list` probe |
| 4 | L3 egui app: every legacy page a `Page` variant, same groups, same order, same gestures | `egui_kittest` golden PNGs + `glyph_source_scan` |
| 5 | certification, live read-only probe, NSIS installer, `SHA256SUMS.txt`, GitHub release | six gates + release assets |

The six gates: `cargo clippy --workspace --all-targets -- -D warnings`,
`cargo test --workspace`, `cargo fmt --all --check`, MCP stdio JSON-RPC probe,
app `--smoke` plus `egui_kittest` snapshots, and the glyph/tofu scan.

---

## What "done" means (and what a failed port looks like)

A converted repo replaces its Python predecessor only when the cutover checklist passes:
tool-surface parity, zero-config credential import, all six gates green, one real
read-only call against the live service or device recorded in the README, a clean
`--smoke` plus a working installer, the MCP host repointed to the Rust binary, and the
legacy repo archived with its port released in `operations/WEBAPP_PORTS.md`.

A failed port is easy to recognise: a 2-4 page shell instead of the full nav, invented
pages, a reordered sidebar, a gesture that does something else, or advertised tool
operations that are stubs. The SOP calls that out explicitly because it is the default
failure mode of an under-specified conversion.

---

## The first converts

| Repo | Wraps | Surface | State |
|---|---|---|---|
| `rust-devices-mcp` | smart plugs, cameras, Hue, Ring, weather | reference implementation | golden blueprint, the kernel every other repo copies |
| `rust-plex-mcp` | Plex Media Server | 36 MCP tools | shadow repo, 0.4.0 |
| `rust-calibre-mcp` | Calibre library (read-only SQLite on a live database) | 23 MCP tools | shadow repo, 0.4.0 |
| `rust-arr-mcp` | Sonarr / Radarr / the *arr stack | 82 MCP tools | shadow repo, 0.1.1 |
| `rust-yahboom-mcp` | Yahboom robot gateway on :10892 | MCP + desktop | shadow repo |
| `rust-sdr-mcp` | RTL-SDR hardware | MCP + 12-page app | phase 4, 0.1.0 |

"Shadow repo" means the Rust version lives beside the running Python one
(`D:\Dev\repos\rust-<domain>-mcp`) and the Python repo is untouched until cutover. Do not
read a working Rust build as "the Python repo is retired" - the per-repo `HANDOVER.md`
records where the cutover actually stands.

---

## What does not convert

- **Host-plugin repos** (Blender, FreeCAD, KiCad): the host owns the process and the
  Python bindings are the API. Those stay Python, or stay Python plus a thin Rust CLI.
- **CUDA / PyTorch repos**: local LLM and vision work stays where the kernels are.
  Python remains the oracle; the Rust side calls it if it must.
- **Anything whose only interface is a vendor SDK without a native equivalent.**

Deciding this up front is Phase 0.1 of the SOP; converting a Bucket C/D repo wastes
weeks and ends with a wrapper around the same Python process.

---

## Why the two hard stops exist

The measured failure mode, from the SOP's own incident notes: an agent handed "convert
this repo" without a dossier produces a plausible shell with invented pages and a
handful of stubs, and there is nothing to fail it on because no gate compares it to the
original. The dossier is the contract; the six gates are the proof. Both are cheap
compared with a port that has to be thrown away.

---

## Where the rules live

- Conversion standard: [FLEET_CONVERSION_STANDARD.md](https://github.com/sandraschi/mcp-central-docs/blob/main/standards/rust-artcraft/FLEET_CONVERSION_STANDARD.md)
- The macro and phases: [REPCONV_SOP.md](https://github.com/sandraschi/mcp-central-docs/blob/main/patterns/REPCONV_SOP.md)
- Triage and the 4-bucket matrix: [RUST_ARTCRAFT_STANDARD.md](https://github.com/sandraschi/mcp-central-docs/blob/main/standards/RUST_ARTCRAFT_STANDARD.md)
- Containment harness and the 6-gate definition of done: [CONTAINMENT_AND_CRATES.md](https://github.com/sandraschi/mcp-central-docs/blob/main/standards/rust-artcraft/CONTAINMENT_AND_CRATES.md)
- Golden blueprint: [rust-devices-mcp](https://github.com/sandraschi/rust-devices-mcp)

## Run it

```
pwsh -NoProfile -File D:\Dev\repos\mcp-central-docs\scripts\New-RustArtcraftRepo.ps1 -Domain <domain>
just check
just test
just build-release
```

Prerequisites: Rust toolchain plus VS Build Tools (MSVC), NSIS for the installer, and a
local Ollama if you want the spec-distiller pass. The stamp is deterministic and costs no
model tokens; the gates are the same commands CI runs on Windows.
