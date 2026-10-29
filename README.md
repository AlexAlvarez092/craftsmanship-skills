# software-quality

A plugin of skills plus an always-on rule that make AI coding agents (GitHub Copilot CLI, Claude Code, etc.) apply proven software design principles when writing and reviewing code.

## Contents

| Skill | Covers |
|---|---|
| `solid-principles` | SRP, OCP, LSP, ISP, DIP |
| `simple-design` | DRY, KISS, YAGNI |
| `grasp-and-lod` | GRASP patterns, Law of Demeter |
| `clean-architecture` | Layers, Dependency Rule, ports & adapters |
| `component-cohesion` | REP, CCP, CRP: grouping classes into packages/modules |
| `component-coupling` | ADP, SDP, SAP: dependencies between packages/modules |

`rules/software-quality.instructions.md` is a short always-on rule that tells the agent when to consult each skill. Skills alone are loaded on demand and may not trigger reliably; the rule makes them part of every development task.

## Install

```bash
copilot plugin install AlexAlvarez092/software-quality
```
This installs the skills. To make agents apply them on every task, also copy the always-on rule (plugins may not carry instruction files):
```bash
curl -fsSL https://raw.githubusercontent.com/AlexAlvarez092/software-quality/main/rules/software-quality.instructions.md \
  -o ~/.copilot/instructions/software-quality.instructions.md
```
Or commit it to a project's `.github/instructions/` so the whole team gets it.

Restart the CLI afterwards.

## Sources

Content is synthesized and rewritten, with examples in TypeScript, Python and Java. Topics and structure were inspired by the guide at <https://www.caress.dev/guia/buenas-practicas/>. Primary references: Robert C. Martin (SOLID, Clean Architecture, component cohesion and coupling principles), Craig Larman (GRASP), Hunt & Thomas (DRY, Law of Demeter), Kent Beck (YAGNI).

## Roadmap

Clean Code, design patterns, language/framework-specific practices, databases/ORMs and system design.

## License

MIT
