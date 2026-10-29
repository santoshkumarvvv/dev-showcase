# Architecture

This project follows **Clean Architecture** (Uncle Bob).

## Layers

```
lib/
├── core/          # Shared: theme, constants, utils, error handling
├── domain/        # Business logic: entities, use cases, repository contracts
├── data/          # Implementation: models, data sources, repository impls
└── presentation/  # UI: screens, widgets, state (Riverpod providers)
```

## Dependency Rule

> Source code dependencies must point only inward, toward higher-level policies.

- `presentation` → `domain`
- `data` → `domain`
- `domain` → nothing
- `core` → nothing (except Flutter SDK)

## Data Flow

1. UI triggers an event
2. Provider calls a Use Case
3. Use Case calls a Repository (contract)
4. Repository impl fetches from Data Source (API/DB)
5. Model maps to Entity
6. Entity flows back up to UI

## Why?

- **Testable** — business logic has zero Flutter/UI dependencies
- **Swappable** — swap API for local DB without touching UI
- **Scalable** — teams can own layers independently
