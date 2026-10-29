---
name: ui-ux-pro-max
description: Comprehensive design intelligence layer based on NextLevelBuilder's UI/UX Pro Max. Injects expert UI patterns, modern color palettes, typography pairings, WCAG accessibility, and responsive component architectures. Trigger on /uipro, /design, UI redesign, CSS styling, Tailwind, landing page, or frontend dashboard requests.
---

# UI/UX Pro Max Skill (Design Intelligence Engine)

> Transforms generic, boring "AI-generated" web interfaces into polished, professional, human-crafted design systems.

---

## 1. Anti-Patterns to Prevent (Default AI UI Banned)

- ❌ Centered text with three generic feature cards and arbitrary blue/purple gradients.
- ❌ Low-contrast text failing WCAG AA (e.g., light gray on white background).
- ❌ Missing component states (hover, focus-visible, active, disabled, loading, empty).
- ❌ Inconsistent spacing and arbitrary font sizes without a strict typographic scale.
- ❌ Overusing heavy drop shadows instead of subtle multi-layered ambient elevation.

---

## 2. Core Design Disciplines

### A. Modern Aesthetics & Styling
- **Glassmorphism / Frosted**: Subtle `backdrop-filter: blur(12px)`, translucent borders (`border-white/10`), ambient light glows.
- **Neo-Minimalism**: High contrast, razor-sharp typography, deliberate whitespace, subtle 1px dividers, muted secondary labels.
- **Micro-Interactions**: Smooth 150-200ms cubic-bezier transitions for hover states, scale transforms on click (`active:scale-[0.98]`).

### B. Color Architecture & Palettes
- **Never use raw `#000000` or `#ffffff`** for dark/light themes. Use tinted grays (e.g., slate, zinc, neutral).
- **Semantic Mapping**:
  - `Surface`: Background, Card, Modal, Dropdown (layered elevation).
  - `Brand / Accent`: Primary action buttons, active indicator, focus rings.
  - `Feedback`: Success (Emerald), Destructive (Rose), Warning (Amber), Info (Sky).

### C. Typography & Hierarchy
- Pair clean geometric/grotesque sans-serifs (Inter, Geist, Plus Jakarta Sans) for UI with readable body fonts.
- Strictly adhere to typographic scale:
  - `Hero / Title`: `text-4xl` to `text-6xl`, tracking tight (`tracking-tight`), `font-bold`
  - `Section Header`: `text-2xl` to `text-3xl`, `font-semibold`
  - `Card Header`: `text-lg` to `text-xl`, `font-medium`
  - `Body`: `text-sm` or `text-base`, leading relaxed (`leading-relaxed`), text-muted
  - `Microcopy / Badge`: `text-xs`, uppercase tracking wider (`tracking-wider`), `font-semibold`

### D. Component State Matrix
Every interactive component (Button, Input, Dropdown, Table row) MUST provide:
1. `Default`
2. `Hover` (subtle brightness shift or border highlight)
3. `Focus-visible` (accessible high-contrast outline ring)
4. `Active / Pressed`
5. `Disabled` (opacity-50, cursor-not-allowed)
6. `Loading / Skeleton` (shimmer animation)

---

## 3. Workflow & Artifact Output

1. When asked to design/code frontend components or pages:
   - Identify target aesthetic (SaaS, FinTech, Academic, Creative).
   - Establish cohesive Tailwind/CSS design tokens (Colors, Spacing, Typography).
   - Write semantic HTML5 + modern CSS/Tailwind with built-in accessibility (`aria-*`, keyboard navigation).
2. For comprehensive UI redesigns, generate or update a `MASTER_DESIGN.md` in the project root to keep styles persistent.
