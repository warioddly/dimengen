# Dimengen — Flutter Dimensions Generator

[![pub version](https://img.shields.io/pub/v/dimengen.svg)](https://pub.dev/packages/dimengen)
[![build](https://github.com/warioddly/dimengen/actions/workflows/build.yml/badge.svg)](https://github.com/warioddly/dimengen/actions)
[![license: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

**Dimengen** is a SourceGen-based code generator for Flutter that automatically creates `EdgeInsets`, `BorderRadius`, `SizedBox` constants (e.g., `sVerticalMBottom`, `mAll`, `lOnlyLeft`, etc.) based on a custom dimensions class.

> 📦 Define your spacing values once — generate dozens of ready-to-use `EdgeInsets`.

---

## Example

Define your dimension constants inside an annotated class:

```
import 'package:dimengen/dimengen.dart';

@Dimengen()
abstract final class Dimensions {
  static const double s = 8.0;
  static const double m = 16.0;
  static const double l = 24.0;
}
```

Then you can simply use them like this:

```
Padding(
  padding: DimensionsInsets.sVertical,
  child: Text('Example'),
)
```

---

Installation

Add to your pubspec.yaml:

```yaml
dependencies:
  dimengen: ^0.1.0

dev_dependencies:
  build_runner: ^2.4.6
```

---

⚙Code Generation

Run:

```bash
flutter pub run build_runner build
```
Or watch for changes:

```bash
flutter pub run build_runner watch
```

---

Why Use Dimengen?

✅ Centralized dimension values
✅ Automatically generates dozens of EdgeInsets variants
✅ Promotes clean, reusable, and consistent UI spacing
✅ Improves code readability and maintainability

---

🤝 Contributing

Have suggestions or improvements? Feel free to submit a pull request or open an issue. Contributions are welcome!
