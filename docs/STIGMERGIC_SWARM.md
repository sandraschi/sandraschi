# Stigmergic Swarm & Space-Efficient WSL2 Sandboxing

> How Sandra's 190+ repo fleet coordinates autonomous AI agents locally without central bottlenecks or massive VM bloat.

---

## 1. What is Stigmergy?

In nature, termites and ants construct monumental architectural structures without blueprints, managers, or central dispatchers. They coordinate via **stigmergy** — indirect communication mediated by modifications to their shared physical environment. An action by one individual leaves a physical trace (a scent trail, a mud pellet), which serves as the environmental trigger for the next action by any individual.

In software and distributed AI agents:
* **Traditional Orchestration (Fragile)**: A monolithic coordinator maintains an in-memory execution DAG (`flowforge`), polls child processes, manages synchronous RPC, and holds a single database lock. If one step hangs or runs out of context, the whole queue freezes.
* **Stigmergic Coordination (Resilient)**: Agents do not talk to each other directly or await commands from a master daemon. They observe the **state of the environment** (Git repos, test exit codes, `.r11n/` markers, port health), act locally when a condition matches their capability, alter the environment, and terminate.

---

## 2. What We Use Stigmergic Agents For

Across 190+ fleet repos on Goliath, autonomous workers operate across three primary reconciliation domains:

```
                  ┌────────────────────────────────────────┐
                  │       Shared Environment (Substrate)   │
                  │  - 190+ Git Repositories               │
                  │  - Pheromone Traces (.r11n/claim.json) │
                  │  - Webapp & MCP Ports (10996, 11027...)│
                  └───────────────────┬────────────────────┘
                                      │
            ┌─────────────────────────┼─────────────────────────┐
            ▼                         ▼                         ▼
  [Contribution Reconciler]  [Doc Drift Reconciler]     [Service Watchdog]
   Senses failing tests &     Senses missing AGENTS.md   Senses dead ports &
   uncommitted bugs; fixes,   or port drift; patches     restarts NSSM daemons
   verifies, and stages PRs   docs and updates links     cleanly without hangs
```

1. **Autonomous Code Repair & Contribution**:
   * *Trigger*: A worker senses a failing `pytest` or unhandled exception (demonstrated in `fritz-test` Pilot 3).
   * *Action*: Atomically acquires `.r11n/claim.json`, applies localized code remedies, verifies tests turn green, records git diff, and releases the claim.
2. **Doc Drift & Standard Enforcement**:
   * *Trigger*: Repos exceeding 15+ files lacking an `AGENTS.md`, or webapps with port assignments conflicting with `operations/WEBAPP_PORTS.md`.
   * *Action*: Ephemeral doc worker synthesizes standard headers and updates cross-references.
3. **Fleet Health Supervision**:
   * *Trigger*: Unhealthy `/api/health` probes or abandoned orphan processes.
   * *Action*: Restarts the associated NSSM service according to strict fleet rules (`sc.exe stop/start`, never killing child processes).

---

## 3. The WSL2 Space-Efficient Sandbox Architecture (The "Anti-VM" Solution)

### The Problem with Traditional Big VMs
Running full-blown virtual machines (VMware, VirtualBox, or standard KVM) for each agent worker is completely unviable on a developer workstation:
* **Storage Bloat**: 15–30 GB per guest OS disk image. Spawning 5–10 concurrent workers consumes 150+ GB of SSD space.
* **Static RAM Locking**: Each VM locks 2–8 GB of host RAM, starving the host GPU and local LLM runners.
* **Startup Latency**: Booting a full VM takes 20–45 seconds.

### The WSL2 Lightweight Micro-Sandbox Solution

Instead of heavy single-agent VMs, the fleet executes ephemeral workers inside **WSL2 using a lightweight copy-on-write micro-sandbox stack**:

```
 ┌────────────────────────────────────────────────────────────────────────┐
 │                      Windows Host (NTFS / RTX 4090)                    │
 └───────────────────────────────────┬────────────────────────────────────┘
                                     │ Hyper-V Utility VM (<1s boot)
 ┌───────────────────────────────────▼────────────────────────────────────┐
 │                     WSL2 Shared Linux Micro-Kernel                     │
 │  - Dynamic Memory Reclaim (page reporting: autoMemoryReclaim=gradual)  │
 │  - Sparse VHDX (auto-trims freed space back to NTFS)                   │
 ├────────────────────────────────────────────────────────────────────────┤
 │              Shared Read-Only Base Image (Debian + uv + rust)          │
 ├────────────────────────────────────────────────────────────────────────┤
 │  Worker A (OverlayFS)        Worker B (OverlayFS)        Worker C...   │
 │  - Ephemeral tmpfs upperdir  - Ephemeral tmpfs upperdir                │
 │  - Git Worktree (<5MB)       - Git Worktree (<5MB)                     │
 └────────────────────────────────────────────────────────────────────────┘
```

#### 1. Shared Micro-Kernel & Dynamic Memory Reclaim
* **Zero Per-Agent Kernel Overhead**: All agents share WSL2's single, highly optimized Linux kernel booting in <1 second via Hyper-V.
* **Page-Reporting Memory Reclaim**: Configured with `autoMemoryReclaim=gradual` in `%USERPROFILE%\.wslconfig`. As soon as a worker finishes its test suite and exits, its memory is returned to Windows immediately.

#### 2. Sparse VHDX Auto-Compaction
* By running `wsl --manage <distro> --set-sparse true`, the virtual disk expands only when active bytes are written and automatically trims unused sectors back to the host NTFS file system, preventing disk ballooning.

#### 3. OverlayFS (Shared Base + Ephemeral CoW Layers)
* **Single Shared Base**: System binaries, standard libraries, Python runtimes (`uv`), and Rust toolchains reside in a single read-only base root (`lowerdir`).
* **Ephemeral Upperdir**: Each worker mounts a temporary scratch space (`upperdir`) in RAM (`tmpfs`) or a lightweight directory. When the worker finishes, unmounting the overlay deletes the upperdir in milliseconds with **zero residual disk usage**.

#### 4. Git Worktree Zero-Clone Isolation
* Instead of running `git clone` (which duplicates the entire multi-gigabyte `.git` history per worker), workers execute:
  ```bash
  git worktree add /tmp/r11n-sandbox/worker-01/repo -b r11n-fix-branch
  ```
* This creates a clean, isolated working directory linked to the primary repo's object database in under 50ms, consuming only a few kilobytes of disk.
* Cleanup is instantaneous: `git worktree remove --force /tmp/r11n-sandbox/worker-01/repo`.

#### 5. Ephemeral Rootless Namespaces
* For commands requiring process and network containment, workers run inside rootless Linux namespaces or lightweight Podman/Docker containers within WSL2, eliminating the heavy overhead of Docker Desktop.

---

## 4. Key Primitives in Fritz (`fleet-agent-mcp`)

* **`.r11n/claim.json`**: Atomic file lease specifying task ID, worker ID, and TTL.
* **`.r11n/blocked.json`**: Pheromone circuit breaker preventing infinite loops and escalating to the human dashboard.
* **`r11n_check` / `r11n_claim` / `r11n_release`**: FastMCP tools exposing stigmergic state to local LLMs and tools.
