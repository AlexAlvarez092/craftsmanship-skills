---
name: clean-architecture
description: Structure applications with Clean Architecture - layered code with the Dependency Rule, ports and adapters, use cases isolated from frameworks, ORMs and UI. Use when creating a new service/module/feature, deciding where code belongs, adding persistence or external integrations, making business logic testable, or reviewing layering and imports.
---

# Clean Architecture

Organize code in concentric layers so business logic is isolated from frameworks, databases and UI.

## Layers (inside → out)
1. **Entities** — core business rules and objects; no external dependencies.
2. **Use Cases** — application-specific rules; orchestrate entities; define the **ports** (interfaces) they need.
3. **Interface Adapters** — controllers, presenters, gateways, repository implementations; translate between use cases and the outside world.
4. **Frameworks & Drivers** — web framework, ORM, DB driver, UI, SDKs; the composition root lives here.

## Dependency Rule
Source-code dependencies point **inward only**. An inner layer never imports from an outer one. When a use case needs persistence or an external service, it declares an interface in its own layer; the outer layer implements it (Dependency Inversion).

## Example (TypeScript)
```ts
// entities/User.ts — pure rules
export class User {
  constructor(readonly email: string) {
    if (!email.includes("@")) throw new Error("invalid email");
  }
}
// usecases/RegisterUser.ts — owns the port
export interface UserRepository { save(u: User): Promise<void> }
export class RegisterUser {
  constructor(private readonly repo: UserRepository) {}
  async execute(email: string) { const u = new User(email); await this.repo.save(u); return u; }
}
// adapters/SequelizeUserRepository.ts — implements the port
// adapters/RegisterUserController.ts — HTTP <-> use case, maps errors to status codes
// main.ts (composition root) — only place that knows Express + Sequelize
```
Python/Java equivalent: `domain/`, `application/` (use cases + ports as `Protocol`/`interface`), `infrastructure/` or `adapters/` (ORM repos, HTTP controllers), and a composition root wiring concrete classes.

## Smells (violations)
- Use case or entity imports an ORM model, HTTP request/response, or framework annotation.
- Business rules inside controllers, ORM models or UI components.
- Folders named `entities/usecases/adapters` while inner code still imports outer details ("layers as folders").
- A `UserService` that still depends directly on Express or the ORM.
- Use case cannot be unit-tested without a DB or web server.

## Agent workflow
1. Identify the use case and place rules in entities / use cases first.
2. Define ports in the use-case layer; implement them in adapters; wire in the composition root.
3. Controllers: parse/validate transport input, call the use case, map result/errors to the response — nothing more.
4. Use DTOs at boundaries; don't leak ORM models or HTTP objects inward.
5. Test use cases with in-memory fakes of the ports.
6. Follow the project's existing structure when it has one; introduce layers incrementally.

## Don't over-engineer
For scripts, prototypes or trivial CRUD, the cost of layers can exceed the benefit. Apply the depth of layering to the business-logic complexity and expected lifetime of the project (KISS/YAGNI — see `simple-design`).

Related: `solid-principles` (DIP), `grasp-and-lod`.
