---
name: ponytail
description: Enforces the Ponytail 7-step Parsimony Ladder (Ladder of Laziness) and Anti-Code-Golf guardrails to eliminate over-engineering. Trigger on /ponytail, /ponytail-review, /ponytail-audit, or when asked to diet, simplify, or audit code for bloat.
---

# Ponytail Skill (Senior Dev Parsimony & Anti-Bloat Engine)

> *"The best code is the code you never wrote."*
> Makes the agent think like the most pragmatic senior engineer in the room: ruthless against speculative abstractions and bloat, uncompromising on security, error handling, and readability.

---

## 1. Core Mechanism: The 7-Step Parsimony Ladder (Gate 1)

Before writing or adding any new function, class, wrapper, or dependency, evaluate top-to-bottom and **STOP at the first step that holds**:

1. **Does this need to exist? (YAGNI)**: If it wasn't requested or solves a hypothetical future problem, do not write it.
2. **Already in this codebase? (CodeGraph Reuse)**: Check `.codegraph/GRAPH_REPORT.md` and `codegraph_explore` first. If a function/utility already exists in the project, reuse it.
3. **Standard Library (`stdlib`) does it?**: Prefer Python `sqlite3`, `pathlib`, `collections`, `urllib`, `concurrent.futures` or native C++/JS stdlib over custom helpers or new packages.
4. **Native Platform / Runtime feature?**: Prefer browser/OS native features (e.g., `<input type="date">`, native `fetch`, Win32 APIs, SQLite built-in FTS5) over third-party abstractions.
5. **Existing installed dependency?**: Solve it with packages already present in `pyproject.toml` / `package.json` before adding anything new.
6. **Direct inline expression?**: If a helper is only called once and fits cleanly in 1–3 readable lines, inline it instead of creating a wrapper function.
7. **Minimum Viable Implementation**: Write only the exact code required to satisfy the requirement and pass verification.

---

## 2. Hard Guardrails: Anti-Code-Golf & Safety Rules (Non-Negotiable)

Reducing lines of code (LOC) **MUST NEVER** degrade safety or cognitive readability. Any compression that violates the rules below is an immediate **HARD FAIL**:

- **Never Cut Security or Path Safety**:
  - Path canonicalization (`os.path.realpath`, `Resolve-Path -LiteralPath`) and trust-boundary input validation must never be removed.
- **Never Swallow Errors**:
  - Do not remove `try / except` blocks around I/O, network, subprocess, or DB operations.
  - Never replace explicit error handling with `except Exception: pass` or silent failures.
- **No Code Golfing (Syntactic Complexity Cap)**:
  - **No multi-statement semicolons**: Never pack multiple statements onto one line (`a = 1; b = 2; return a + b`).
  - **No nested ternaries**: Never nest conditional expressions (`x if a else y if b else z`).
  - **No deep comprehension nesting**: Maximum 1 level of `for` inside list/dict comprehensions.
  - **Line length cap**: Do not compress readable 4-line blocks into a single >120-character line.
  - **Meaningful identifiers**: Do not rename clear variables to single letters (`x`, `y`, `t`) just to save characters.

---

## 3. Intensity Modes

- **`lite`**: Blocks new dependencies and unused abstractions; leaves existing structure untouched.
- **`full` (Default)**: Enforces the 7-Step Ladder on all edits and strips single-use wrappers in modified regions.
- **`ultra`**: Aggressive repository-wide bloat removal (merges redundant layers, deletes 0 in-degree dead symbols, flattens unnecessary class hierarchies while preserving all safety guardrails).

---

## 4. Workflows & Commands (Gate 2)

### A. `/ponytail-review` (Diff / Pre-Finish Review)
When reviewing recent edits (`rtk git diff`):
1. Identify any newly introduced helper function/class called only once.
2. Check if any new logic duplicates an existing symbol in `.codegraph/GRAPH_REPORT.md`.
3. Verify all **Anti-Code-Golf & Safety Rules** (Section 2) pass.
4. Present a concise before/after LOC reduction table and apply surgical simplification.

### B. `/ponytail-audit` (Repository-Wide Diet Audit)
When asked to audit a file or repository for maximum code reduction:

1. **Step 1 — Macro Topology & Dead Symbol Scan (0.03s Local)**:
   Run the CodeGraph Topology analyzer to extract `0 In-Degree Public Symbols` (Dead Candidates) and `Core God Nodes`:
   ```powershell
   # 표준 git 변경 사항 및 파일 심볼 탐색
   git diff --stat
   ```
2. **Step 2 — Multi-File Exploration vs Adversarial Diet Critic**:
   - **For multi-file structural audits**: Invoke the built-in `research` or `self` subagent (`Model: "flash"`) via `invoke_subagent` to verify whether dead symbol candidates are dynamically referenced and rank files by **Maximum Safe LOC Reduction**.
   - **심층 압축 심의**: 내장된 고성능 서브에이전트(`Model: inherit`)를 호출하여 다이어트 검증:
     ```text
     [Adversarial Ponytail Audit]
     Target File: <file_path>
     Identify all over-engineered wrappers, redundant state, dead branches, and stdlib re-inventions ranked by LOC saved.
     HARD CONSTRAINTS:
     1. NEVER remove error handling (try/except), path canonicalization (realpath), or security checks.
     2. NEVER use code-golf tricks (semicolon chaining, nested ternaries, unreadable 1-liners).
     3. Preserve 100% of external behavior and public signatures of God Nodes: <list_of_god_nodes>.
     ```
3. **Step 3 — Surgical Execution & Verification**:
   - Apply approved simplifications via `replace_file_content`.
   - Run existing tests or CLI verification to prove 0 behavioral regression.
