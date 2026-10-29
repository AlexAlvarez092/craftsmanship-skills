---
name: component-cohesion
description: Group classes into packages, modules and libraries using the component cohesion principles (REP, CCP, CRP). Use when deciding what belongs in the same package/module/library, splitting or merging modules, releasing shared libraries, or when one change touches many packages or a dependency drags in unused code.
---

# Component Cohesion: REP, CCP, CRP

A component is a unit of deployment (package, module, library, service). These principles decide which classes belong together. They apply SRP/ISP at component level; see `solid-principles`.

## REP — Reuse/Release Equivalence
- The unit of reuse is the unit of release: what consumers reuse must be versioned, documented and released together.
- Group classes that are reusable together and share a theme; don't mix unrelated utilities in one artifact.
- Shared components need release numbers and changelogs so consumers can choose when to upgrade.

## CCP — Common Closure
- Group classes that change for the same reason and at the same time; separate those that change for different reasons.
- Goal: a typical change lands in one component, not scattered across many.
- Smell: shotgun surgery, where one feature requires edits and releases in several packages.

## CRP — Common Reuse
- Don't force consumers to depend on classes they don't use. Classes used together belong together; classes rarely used together belong apart.
- Depending on a component means depending on all of it: any change in it may force you to revalidate and redeploy.
- Smell: importing a big `utils`/`common` package for one function.

## The tension
- REP and CCP make components larger (inclusive); CRP makes them smaller (exclusive).
- Early in a project favor CCP (developability, few components). As consumers appear, shift toward REP and CRP (reusability, narrow dependencies).
- Don't aim for all three; choose consciously and revisit as the project matures.

```ts
// Low cohesion: unrelated changes and consumers share one package
// common/ { dateFormat.ts, pdfExport.ts, authToken.ts }
// Better: group by reason to change and reuse
// billing/ { invoice.ts, pdfExport.ts }   // change together (CCP)
// auth/    { authToken.ts }               // used together (CRP)
```
```python
# Cohesive: one package changes when the payment provider changes
# payments/{gateway.py, webhook.py, refund.py}
```
```java
// Split a fat module so a client needing only parsing doesn't pull in rendering
// acme-report-parser, acme-report-renderer
```

## Agent workflow
1. Before adding a class, find the component whose reason to change it shares (CCP); don't default to `utils`/`common`.
2. When a change spans several components, consider merging them or moving the misplaced class.
3. When a component has consumers using only part of it, consider splitting (CRP).
4. For shared libraries, check versioning and release notes exist (REP).
5. Keep it proportional: small projects need few components; don't split speculatively (YAGNI).

Related: `solid-principles`, `clean-architecture`, `component-coupling`, `grasp-and-lod`, `simple-design`.
