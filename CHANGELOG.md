# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2026-07-24

### Fixed
- Repo count standardized to **126+** everywhere (README, MCP_CATALOG, AGENTIC_AI, SUPERHUMAN_NARROW, assets) — was previously inconsistent across files (130+, 135+, 180+, ~185)
- `FastMCP` version aligned to 3.4 across README and WORKSHOP.md (was 3.2 in one place)
- `docs/BLOOPERS.md` linked from README's Current Highlight link row — was previously unlinked from anywhere
- Merged two overlapping entries that had been filed under a single `[1.1.0]` header below

### Changed
- Moved the weapons/geopolitics tangents out of `docs/SHENZHEN_ROBOTICS.md` and `docs/SUPERHUMAN_NARROW.md` into a new standalone `docs/DARK_AI_THOUGHTS.md`, linked from each doc's Further Reading section instead of sitting inline

## [1.1.0] - 2026-07-24

### Added
- Full fleet registry table in `MCP_CATALOG.md` — all repos by category (collapsible)
- Card SVGs for godot, freecad, qcad, dreame, aiwatcher (5 missing from catalog)
- Card SVGs for new showcase repos: mixxdj, kicad, steam, fleetwatcher, stems, vla, leanforge, codecad
- `plex-mcp` entry and Media & Streaming section in catalog
- `docs/SUPERHUMAN_NARROW.md` — domain-specific superhuman AI, intrinsic LLM dev advantages (tests, docs, infra), VC vs. FOSS three-phase story, maintainer spectrum

### Changed
- `README.md`: expanded "Current highlight" with full mixx-dj-mcp + leanforge-mcp narratives — 300K-line C++ fork, domain-specific superhuman case studies
- `docs/SUPERHUMAN_NARROW.md`: added Mixxx 5K-line C++ case study with all three structural advantages (tests, docs, infra)

## [1.0.0] - 2026-07-24

### Added
- `PELICAN.md`: Documentation on the repo mascot and the "Simon Willison pelican benchmark"
- `WORKSHOP.md`: High-fidelity hardware details for the Alsergrund node (**Goliath**)
- `BUMI.md`: Technical profile for the **Noetix Bumi** humanoid platform
- `CHANGELOG.md`: Initialized project history tracking

### Changed
- `README.md`: Industrial cleanup and visual modernization. Integrated card-based project navigation
- `MCP_CATALOG.md`: Refined visual cards for the MCP fleet
- Removed legacy layout credits and transitioned to the new Alsergrund Industrial standard
