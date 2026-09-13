# E2E Testing a Fleet Webapp

Sub-sub readme of [Dev Stack](DEV_STACK.md): how a webapp proves it works without a human clicking through it. Technical. Standards underneath: `playwright_e2e_sota.md`, `cua_webapp_testing.md`, `cua_nsis_smoke_testing.md` (mcp-central-docs `standards/rules/`).

---

## The three layers

No single harness covers everything, so every webapp gets three, each catching what the others cannot:

| Layer | Tool | What it proves | When |
|---|---|---|---|
| DOM assertions | Playwright (`webapp/e2e/*.spec.ts`) | Pages render, routes mount, backend integrates, zero console errors | Dev loop, CI on push |
| Real-browser click-through | cua-webapp-test (pywinauto UIA over Chrome/Edge) | The real stack boots, connects, and every sidebar page opens in a real browser | Dev loop, no-Tauri repos |
| Installed-app smoke | cua-nsis-test | NSIS installer, frozen backend, Tauri WebView2, registry cleanup | Pre-release cert |

Playwright for the dev loop, CUA-webapp for "does the stack actually boot and connect", CUA-NSIS for the shipped artifact. Reference impls: email-mcp (17 Playwright tests), learnbot-mcp (first 9/9 CUA pass), docker-mcp smoke spec.

## Layer 1: Playwright finds the click targets from source

The tester bot does not guess. It derives targets from the app itself:

1. **Routes from the router.** React Router definitions plus the sidebar component give the page list. Tests assert each route mounts (`#root` attached), no 404s, no hydration failures.
2. **Anchors from `data-testid`.** Interactive elements carry stable test ids (onboarding cue, chat input, settings fields). Selectors bind to ids, never to CSS classes or pixel positions, so Tailwind refactors do not break the suite.
3. **Two describe blocks.** Frontend (`{ page }`: load, navigate, interact) and REST API (`{ request }`: health 200, invalid input -> 422, diagnostics tool count).
4. **Minimum suite (Fleet Audit).** Backend health, frontend loads, zero console errors (enforced by `scripts/playwright-audit.ps1`), no 404s, no hydration failures. `just e2e` must pass before SOTA certification.
5. **Screenshots for humans too.** `screenshots.spec.ts` renders stable 1280x720 captures into `docs/screenshots/` (`just screenshots`) - the same run that tests also feeds the README Preview section.
6. **Visual regression.** Baseline PNGs per route committed under `webapp/e2e/visual-baseline/`; audit re-captures and pixel-diffs (2.0% threshold, red-tinted diff output). Animations are disabled at capture so pulsing health dots do not false-positive. Catches CSS/Tailwind layout breaks that pass every DOM assertion.

Config per repo is small (`playwright.config.ts`: baseURL on the frontend port, webServer spawning the backend on its port, 60 s timeout, 1 retry, headless, screenshots only on failure). CI runs `npx playwright test` on push.

## Layer 2: CUA webapp test, the connected-badge wrinkle

`just cua-webapp-test`. Kills stale port holders, starts `start.ps1 -Headless`, polls backend health, opens the real browser - then the part scripted tests get wrong:

- Fleet webapps show "Connecting..." for seconds while the backend boots. The bot **OCRs the window in a loop** (2 s interval, 60 s timeout) accepting connected / system online / ready, and treats "connecting..." as *not an error*. Instant-fail on first OCR would make every run flaky.
- **Nav walk from the real sidebar.** `nav_routes` in `cua-nsis-config.json` lists `[Sidebar Label, Expected]` pairs taken from the actual sidebar, not filenames. Clicks go through `descendants(title=label)`, one screenshot per page into `cua-reports/webapp-{label}.png`.
- Closes with a diagnostics pull (tool count) and port cleanup.

This is the "tester bot analyzes source and routing" step made explicit: config is derived from the sidebar component and route table, so a renamed page breaks the config loudly instead of silently untested.

## Layer 3: CUA NSIS test, the shipped artifact

Same idea against the installed app: NSIS install (silent), frozen PyInstaller backend, Tauri WebView2 frontend, UIA nav walk, backend-unreachable and CSP/CORS failures surface here and nowhere else, registry cleanup verified, uninstall leaves no orphans. Slow (~10 min build) - that is why it is pre-release cert, not dev loop.

## Gates

- New repo: Playwright tests required before the webapp merges.
- `just e2e` green before SOTA certification. `just cua-webapp-test` green before Tauri work. `just cua-nsis-test` green before release.
- CI runs the Playwright suite on push. CUA runs need Windows with a real browser / WebView2, so they run on the dev box and the virtualization-mcp sandbox, not in cloud CI.

---

## Next

- Parent: [Dev Stack](DEV_STACK.md) - Sibling: bug and pitfall depots (same page, § Bug and pitfall depots)
- Standards: mcp-central-docs `standards/rules/playwright_e2e_sota.md`, `cua_webapp_testing.md`, `cua_nsis_smoke_testing.md`, `README_WEBAPP_SCREENSHOTS.md`
