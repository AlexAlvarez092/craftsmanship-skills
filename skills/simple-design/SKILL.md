---
name: simple-design
description: Keep code simple using DRY, KISS and YAGNI. Use when writing or reviewing code and deciding whether to extract duplication, add an abstraction, add configurability or speculative features, or simplify convoluted logic.
---

# Simple Design: DRY, KISS, YAGNI

These three principles balance each other and also balance SOLID: prefer the simplest thing that works, don't build what isn't needed, and don't duplicate knowledge.

## DRY — one representation of each piece of knowledge
- Applies to logic, but also to config, schemas, docs and constants (magic numbers/strings).
- Extract only duplicated *knowledge* (same reason to change). Code that merely looks alike but changes for different reasons should stay separate.
- Rule of three: tolerate duplication twice; abstract on the third occurrence, when the real shape is visible.
```ts
const VAT = { standard: 1.21, reduced: 1.10, superReduced: 1.04 } as const;
const price = (base: number, type: keyof typeof VAT = "standard") => base * VAT[type];
```

## KISS — simplest solution that works
- Remove redundant conditionals, temp variables and flags; use language/stdlib idioms.
- Avoid clever tricks, premature abstraction and deep indirection.
```python
# Instead of loops + if/else returning booleans
evens = [n for n in numbers if n % 2 == 0]
```
```java
// return the condition itself
boolean isAdult(int age) { return age >= 18; }
```

## YAGNI — build only what is required now
- Don't add fields, options, hooks, plugin points, flags or "future-proof" layers without a current requirement.
- Don't add unrequested features (export, sync, caching) to a task.
- Speculative code costs maintenance, tests and docs, and often guesses wrong.

## Agent workflow
1. Implement exactly what the task requires; list (don't build) extra ideas.
2. Search for existing helpers/constants before writing new ones (DRY).
3. After the code works, simplify: remove dead code, redundant branches, needless wrappers.
4. Before adding an abstraction, ask: is there a second real use? If not, keep it concrete.
5. When DRY and KISS conflict, choose the version a new reader understands fastest.

Related: `solid-principles`, `clean-architecture`.
