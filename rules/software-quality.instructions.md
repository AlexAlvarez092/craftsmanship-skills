---
applyTo: "**"
---

# Software Design Quality

When designing, writing, refactoring or reviewing code, apply these principles with judgment (simplicity first):

- **Design/new class, module, service:** consult skill `solid-principles`.
- **Duplication, new abstraction, config or "future" features:** consult skill `simple-design` (DRY, KISS, YAGNI).
- **Deciding where logic belongs, or long call chains:** consult skill `grasp-and-lod`.
- **New feature/service structure, persistence, integrations, layering:** consult skill `clean-architecture`.

Non-negotiables:
1. Business logic does not depend on frameworks, ORMs, HTTP or UI; dependencies point inward and are injected.
2. No type-switch that grows with each variant; prefer polymorphism or strategy.
3. Subtypes must be substitutable; don't throw "not supported" from overrides.
4. Build only what the task requires; no speculative code.
5. One source of truth for each rule/constant; extract on the third repetition.
6. In reviews, cite the principle, the evidence and the smallest fix.

Scale effort to the task: trivial scripts and tiny changes don't need extra layers or interfaces.
