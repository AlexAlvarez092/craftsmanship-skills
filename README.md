# software-quality

A plugin of skills plus an always-on rule that make AI coding agents (GitHub Copilot CLI, Claude Code, etc.) apply proven software design principles when writing and reviewing code.

## Contents

| Skill | Covers |
|---|---|
| `solid-principles` | SRP, OCP, LSP, ISP, DIP |
| `simple-design` | DRY, KISS, YAGNI |
| `grasp-and-lod` | GRASP patterns, Law of Demeter |
| `clean-architecture` | Layers, Dependency Rule, ports & adapters |

`rules/software-quality.instructions.md` is a short always-on rule that tells the agent when to consult each skill. Skills alone are loaded on demand and may not trigger reliably; the rule makes them part of every development task.

## Install

```bash
# Skills
cp -R skills/* ~/.copilot/skills/
# Always-on rule
cp rules/software-quality.instructions.md ~/.copilot/instructions/
```

Or install as a plugin from this repository with your agent's plugin command (manifest: `.claude-plugin/plugin.json`).

## Sources

Content is synthesized and rewritten, with examples in TypeScript, Python and Java. Topics and structure were inspired by the guide at <https://www.caress.dev/guia/buenas-practicas/>. Primary references: Robert C. Martin (SOLID, Clean Architecture), Craig Larman (GRASP), Hunt & Thomas (DRY, Law of Demeter), Kent Beck (YAGNI).

## Roadmap

Clean Code, design patterns, language/framework-specific practices, databases/ORMs and system design.

## License

MIT
