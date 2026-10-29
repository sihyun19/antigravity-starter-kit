---
name: handoff
description: Structured context packaging and state bridge across agent sessions or models. Compresses ongoing decisions, file modifications, architecture states, and pending tasks into a clean HANDOFF.md checkpoint. Trigger on /handoff, "인수인계", "세션 정리", "핸드오프", or when preparing to start a new chat.
---

# Handoff Skill (Session Persistence & State Bridge)

> Captures the complete operational context of a working session into a zero-loss, structured handoff document so the next agent session or model can pick up immediately without redundant discovery.

---

## 1. When to Use

- When the conversation context is growing large and the user wants to start a fresh chat (`/compact` or new session).
- When transitioning from planning/research to execution.
- When explicitly requested with `/handoff`, "인수인계 문서 만들어줘", or "세션 정리해줘".

---

## 2. Execution Procedure

When triggered, perform the following steps:

1. **Inspect Workspace State**:
   - Check git status (`rtk git status` or equivalent) to identify modified/staged files.
   - List newly created files, scratch scripts, or artifacts.
2. **Synthesize Session Context**:
   - **Goal & Core Intent**: What problem was the user solving?
   - **Key Architecture Decisions**: What non-obvious choices, libraries, or algorithms were selected and why?
   - **Files Touched & Status**: Exact paths of files created or edited.
   - **Current Blockers / Bugs**: Any pending errors or unverified code.
   - **Next Concrete Actions**: Ordered checklist (1, 2, 3) for the next agent to immediately execute.
3. **Write Checkpoint File**:
   - If an active workspace or project directory exists, save to `<workspace-root>/HANDOFF.md`.
   - If no project workspace is active, output the structured report directly as an Artifact or markdown response.

---

## 3. Standard `HANDOFF.md` Format

```markdown
# 📋 Session Handoff Checkpoint

**Timestamp**: YYYY-MM-DD HH:mm:ss
**Previous Agent / Model**: <Model Name>

---

## 1. Objective & Current Status
- **Goal**: [Clear 1-2 sentence description of user task]
- **Current Status**: [Completed / In Progress / Blocked]

## 2. Key Decisions & Rationale
- [Decision 1: e.g., Selected Tailwind v4 with CSS variables]
- [Decision 2: e.g., Preserved existing auth middleware without refactoring]

## 3. Changed Files & Work In Progress
- `path/to/file1.ts`: [What changed / verified status]
- `path/to/file2.py`: [Pending test verification]

## 4. Immediate Next Steps (For Incoming Agent)
- [ ] 1. Run `rtk test` to verify current patch
- [ ] 2. Implement remaining edge-case handler in `file2.py`
- [ ] 3. Report completion to user
```
