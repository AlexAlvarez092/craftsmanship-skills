---
name: component-coupling
description: Manage dependencies between packages, modules and libraries using the component coupling principles (ADP, SDP, SAP). Use when you see circular dependencies between modules, decide which way a dependency should point, decide whether a module should be abstract or concrete, or when a change in one package ripples through many others.
---

# Component Coupling: ADP, SDP, SAP

These principles govern the dependency graph between components (package, module, library, service). They complement `component-cohesion`, which decides what goes inside each component.

## ADP — Acyclic Dependencies
- The component dependency graph must have no cycles.
- A cycle forces its members to be built, tested and released together, so they behave as one big component.
- Break a cycle by (1) applying DIP: extract an interface owned by the consumer, implemented by the other side (see `solid-principles`), or (2) extracting the shared code into a new component both depend on.
```ts
// Cycle: orders -> billing -> orders
// Fix: orders defines `interface PaymentPort`; billing implements it.
// Now billing -> orders only.
```

## SDP — Stable Dependencies
- Depend in the direction of stability: a component that changes often should depend on components that change rarely, never the reverse.
- Stable = hard to change because many components depend on it (and it depends on few).
- Instability I = Ce / (Ca + Ce), where Ce = outgoing dependencies, Ca = incoming. I=0 is maximally stable, I=1 is maximally unstable. Dependencies should point toward lower I.
- Smell: a volatile module imported by many others; a stable core importing a UI or framework package.

## SAP — Stable Abstractions
- A component should be as abstract as it is stable. Stable components must be abstract (interfaces, abstract classes) so they can be extended without modification (OCP).
- Abstractness A = abstract elements / total elements.
- Avoid the zone of pain (stable and concrete: rigid, hard to change) and the zone of uselessness (abstract but nobody depends on it). Aim near the line A + I = 1.
- Volatile components should be concrete; concrete details depend on abstractions, which together with SDP yields the Dependency Rule of `clean-architecture`.

## Agent workflow
1. Before adding an import between components, check the direction: does it point toward the more stable one? If not, introduce an interface (DIP).
2. Never introduce a cycle. If one already exists, fix it with an interface or a new shared component rather than adding more coupling.
3. Put stable policy (domain rules) in abstract, rarely changing components; keep volatile details (UI, frameworks, I/O) concrete and depending inward.
4. Don't add abstractions to components nobody depends on (YAGNI, see `simple-design`).
5. When reviewing, cite the principle, the offending dependency edge and the smallest fix.

Related: `component-cohesion`, `clean-architecture`, `solid-principles`.
