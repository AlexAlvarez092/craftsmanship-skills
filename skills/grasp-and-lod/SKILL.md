---
name: grasp-and-lod
description: Assign responsibilities to classes using GRASP (Information Expert, Creator, Controller, Low Coupling, High Cohesion, Polymorphism, Indirection, Pure Fabrication, Protected Variations) and the Law of Demeter. Use when deciding where a method or logic belongs, when seeing long call chains like a.getB().getC().do(), feature envy, or anemic domain objects.
---

# GRASP and Law of Demeter

Guides *where* behavior should live in an object-oriented or modular design.

## GRASP patterns

| Pattern | Guidance |
|---|---|
| **Information Expert** | Put behavior in the class that owns the data needed for it |
| **Creator** | Class B creates A if B contains, aggregates or records A (or has the data to build it) |
| **Controller** | A non-UI object (use case / application service) coordinates a system operation; UI and HTTP layers only delegate |
| **Low Coupling** | Minimize dependencies between classes |
| **High Cohesion** | Keep a class's responsibilities closely related |
| **Polymorphism** | Handle behavior variations with polymorphic types instead of conditionals |
| **Indirection** | Add an intermediary (adapter, facade) to decouple components |
| **Pure Fabrication** | Invent a non-domain class (e.g. repository) when it keeps cohesion/coupling healthy |
| **Protected Variations** | Wrap likely change points behind a stable interface |

### Information Expert example
```python
# Smell: service pokes into Order internals (feature envy)
def total(order): return sum(i.price * i.qty for i in order.items)

# Better: Order owns its data and its calculations
class Order:
    def total(self): return sum(i.price * i.qty for i in self.items)
    def discount(self): return self.total() * 0.1 if self.total() > 100 else 0
    def final_price(self): return self.total() - self.discount()
```

## Law of Demeter (least knowledge)
A method should only call methods on: `this`, its parameters, objects it creates, and its direct fields.
```ts
// Smell: caller knows three objects' structure
order.getCustomer().getAddress().getCity().getName();
// Better: delegate
order.customerCityName();   // Order → Customer → Address each delegate one step
```
Caveats: fluent builders and plain data structures (DTOs, records) don't violate the spirit; don't add pointless pass-through methods everywhere — wrap only chains that cross module/ownership boundaries or are likely to change.

## Agent workflow
1. Before writing a method, ask "who owns the data?" and place it there.
2. If code reads several fields of another object to compute something, move the logic to that object.
3. Replace chains of 3+ navigations with a delegating method on the nearest collaborator.
4. Keep controllers/handlers thin; orchestration lives in use cases, rules in domain objects.
5. Replace growing type conditionals with polymorphism (see `solid-principles` OCP).

Related: `solid-principles`, `clean-architecture`.
