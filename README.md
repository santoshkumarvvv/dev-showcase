<div align="center">

```
██████╗ ███████╗██╗   ██╗    ███████╗██╗  ██╗ ██████╗ ██╗    ██╗ ██████╗ █████╗ ███████╗███████╗
██╔══██╗██╔════╝██║   ██║    ██╔════╝██║  ██║██╔═══██╗██║    ██║██╔════╝██╔══██╗██╔════╝██╔════╝
██║  ██║█████╗  ██║   ██║    ███████╗███████║██║   ██║██║ █╗ ██║██║     ███████║███████╗█████╗  
██║  ██║██╔══╝  ╚██╗ ██╔╝    ╚════██║██╔══██║██║   ██║██║███╗██║██║     ██╔══██║╚════██║██╔══╝  
██████╔╝███████╗ ╚████╔╝     ███████║██║  ██║╚██████╔╝╚███╔███╔╝╚██████╗██║  ██║███████║███████╗
╚═════╝ ╚══════╝  ╚═══╝      ╚══════╝╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝
```

### Production-ready Flutter starter  
Clean Architecture · Riverpod · CI/CD · Zero fluff

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3-0175C2?style=flat-square&logo=dart&logoColor=white)](https://dart.dev)
[![CI](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-2088FF?style=flat-square&logo=github-actions&logoColor=white)](https://github.com/features/actions)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)](LICENSE)

</div>

---

## Why this exists

Most Flutter starters are either toy projects or over-engineered messes.  
**dev-showcase** is the middle path: a battle-ready foundation that serious developers actually start from.

Everything is intentional.

## Architecture

```text
lib/
├── core/           # constants · theme · utils · failures
├── data/           # data sources · models · repository implementations
├── domain/         # entities · use cases · repository contracts
├── presentation/   # screens · widgets · providers
└── main.dart
```

Strict separation. No leaking. Testable by design.

## What’s included

- **Clean Architecture** layers fully enforced
- **Riverpod** for scalable, testable state
- **Material 3** + light/dark theme system
- **Unit + Widget test scaffolding**
- **GitHub Actions** — analyze · test · build on every PR
- **Issue & PR templates**
- **Architecture docs + roadmap**
- **Code of Conduct · Contributing · Security Policy**

## Quick Start

```bash
git clone https://github.com/santoshkumarvvv/dev-showcase.git
cd dev-showcase
flutter pub get
flutter run
```

## Quality Gates

```bash
flutter analyze
flutter test
```

## Roadmap

- [ ] Offline-first with Hive / Isar
- [ ] GoRouter + deep linking
- [ ] Auth module (Firebase / Supabase)
- [ ] Fastlane + store deployment pipelines
- [ ] Live CI status badges

## License

MIT — use it, ship with it, improve it.

---

<div align="center">

**Built for developers who refuse to compromise.**  
[github.com/santoshkumarvvv](https://github.com/santoshkumarvvv)

</div>
