---
name: solid-principles
description: Apply and review the SOLID principles (SRP, OCP, LSP, ISP, DIP) when designing classes, modules, services or interfaces. Use when writing or refactoring object-oriented or modular code, adding a type/variant branch, creating a subclass or interface, instantiating dependencies inside a class, or reviewing code for design quality.
---

# SOLID Principles

Use as a design lens while writing and reviewing code. Apply with judgment: for tiny scripts or trivial CRUD, KISS and YAGNI win (see `simple-design`).

## Quick checklist

| Principle | Ask yourself | Smell |
|---|---|---|
| **SRP** | Does this unit have exactly one reason to change? | Class mixes business rules with formatting, persistence, HTTP or logging |
| **OCP** | Can I add a new variant without editing working code? | `if/switch` on a type field that grows with every new case |
| **LSP** | Can every subtype replace its base without surprising callers? | Subclass throws "not supported", ignores or weakens the parent's contract |
| **ISP** | Does each client depend only on methods it uses? | Interface with many methods; implementers stub or throw on some |
| **DIP** | Do high-level modules depend on abstractions, not concrete details? | `new ConcreteDb()` or direct SDK/ORM calls inside business logic |

## Principles in practice

### SRP — one reason to change
Split by *reason to change* (business rule, presentation, persistence), not by size.
```ts
// Before: three reasons to change
class Invoice { total() {...}  print() {...}  save() {...} }
// After
class Invoice { total() {...} }
class InvoicePrinter { print(inv: Invoice) {...} }
class InvoiceRepository { save(inv: Invoice) {...} }
```

### OCP — extend, don't edit
Replace type-switches with polymorphism (strategy, registry of handlers).
```python
class Discount(Protocol):
    def apply(self, total: float) -> float: ...
class Vip:
    def apply(self, total): return total * 0.85
def checkout(total: float, discount: Discount) -> float:
    return discount.apply(total)   # new discounts need no edits here
```

### LSP — honor the contract
Inheritance models "is-a" with identical behavior, not code reuse. If a subtype cannot fulfil a method, the hierarchy is wrong: split it (`Bird` → `FlyingBird`) or use composition.
```java
abstract class Bird { String describe() {...} }
abstract class FlyingBird extends Bird { abstract String fly(); }
class Penguin extends Bird { String swim() {...} }   // no fly() to break
```
Rules of thumb: do not strengthen preconditions, do not weaken postconditions, do not throw new unexpected exceptions.

### ISP — small, role-based interfaces
Prefer several focused interfaces (`Printable`, `Scannable`) over one fat one. Clients and test doubles stay small.

### DIP — depend on abstractions
Inject dependencies via constructor; wire concrete classes at the composition root.
```ts
interface UserStore { save(u: User): Promise<void> }
class UserService { constructor(private readonly store: UserStore) {} }
new UserService(new PostgresUserStore());
```

## Agent workflow
1. Before adding a branch on a type/kind field, consider OCP.
2. Before adding a method to a class, confirm it matches the class's single responsibility.
3. Before creating a subclass, verify LSP; prefer composition if unsure.
4. Before using `new` on a collaborator or importing an infrastructure client in business code, apply DIP.
5. When reviewing, report each violation with the principle, the evidence (file/line) and the smallest fix.
6. Do not introduce abstractions with only one implementation and no foreseeable need (YAGNI) — except at architectural boundaries (I/O, time, network) where DIP pays off for testing.

Related: `clean-architecture` (DIP at scale), `grasp-and-lod`, `simple-design`.
