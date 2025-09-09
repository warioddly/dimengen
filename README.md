# Dimengen — Flutter Dimensions Generator

[![pub version](https://img.shields.io/pub/v/dimengen.svg)](https://pub.dev/packages/dimengen)
[![license: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

**Dimengen** is a powerful code generator for Flutter that automatically creates EdgeInsets, BorderRadius, and SizedBox constants based on your predefined dimension values.

> It helps you centralize spacing and size values, improve UI consistency, and boost code readability and maintainability.

---

## Getting Started

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

This generates constants like:

- `Insets.m` → `EdgeInsets.all(16)`
- `Borders.sTopLeft` → `BorderRadius.only(topLeft: Radius.circular(8))`
- `Spaces.mVertical` → `SizedBox(height: 16)`

Example usage:

```
Container(
  padding: Insets.m,
  margin: Insets.m,
  decoration: BoxDecoration(
    borderRadius: Borders.sTopLeft,
    color: Colors.blue.shade100,
  ),
  child: Column(
    children: [
      Text('Design Dimensions'),
      Spaces.mVertical,
      Text('M: ${Dimensions.m}'),
      Spaces.h(Dimensions.m),
    ],
  ),
)
```

---

## Modular Generation

Need only specific dimensions? Use separate annotations:

| Annotation      | Generates                          |
|----------------|-------------------------------------|
| `@Dimengen()`  | `EdgeInsets`, `BorderRadius`, `SizedBox` (all) |
| `@Insetgen()`  | Only `EdgeInsets` constants         |
| `@Bordergen()` | Only `BorderRadius` constants       |
| `@Spacegen()`  | Only `SizedBox` values (spaces)     |

Example with `@Spacegen`:

```
import 'package:dimengen/dimengen.dart';

part 'spaces.g.dart';

@Spacegen()
abstract class _Spaces {
  _Spaces._();

  static const double m = 24.0;
}
```

Generates:

```
abstract class Spaces {
  const Spaces._();

  static const SizedBox m = SizedBox.square(dimension: 24.0);
  static const SizedBox mVertical = SizedBox(height: 24.0);
  static const SizedBox mHorizontal = SizedBox(width: 24.0);

  static SizedBox h(double value) => SizedBox(height: value);
  static SizedBox w(double value) => SizedBox(width: value);
}
```

---

## Customization

Customize the generated class names and control what is generated:

```
@Dimengen(
  spacesName: 'DesignSpaces',
  generateInsets: false,
)

// or

@Spacegen(name: 'Gaps')
```

---

## Installation

Add to your pubspec.yaml:

```
dart pub add dimengen
```

and `build_runner` as dev dependencies

```
dart pub add --dev build_runner
```

⸻

## Code Generation

Build once:

```
flutter pub run build_runner build
```

Watch for changes:

```
flutter pub run build_runner watch
```

---

## Build configuration

To control what is generated, configure your `build.yaml`:

Generate only main dimension files (no snippets):
```yaml
targets:
  $default:
    builders:
      dimengen|dimengen:
        enabled: true
      dimengen|snippet_builder:
        enabled: false
```

Generate both dimension files and snippets:
```yaml
targets:
  $default:
    builders:
      dimengen|dimengen:
        enabled: true
      dimengen|snippet_builder:
        enabled: true
```

You can also remove the `snippet_builder` section entirely if you do not need snippets.

---

Why Use Dimengen?
- 📐 Centralized dimension values
- ♻️ Reusable and consistent UI spacing
- ⚡ Auto-generates dozens of variants
- 👀 Enhances code clarity and maintainability

---


## Snippet generation
After every `build_runner` run, two files are produced automatically:

* `.vscode/dimengen.code-snippets`
* `.idea/liveTemplates/DimensionsTemplates.xml`

### How to enable snippet generation
Snippets are generated only for classes marked with the annotation `@DimengenSnippets()`:

```dart

@DimengenSnippets()
class Dimensions {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 32.0;
}
```

Classes without this annotation will be ignored by the snippet builder.

Import the generated files into your IDE (VS Code or Android Studio) and use
`d16`, `in16`, `sp16` … abbreviations instead of magic numbers.

> ⚠️ Snippet import for Android Studio is not tested yet. Please report your experience!

---

## Contributing

Have suggestions, ideas, or found a bug? Contributions are welcome!
Open an issue or submit a pull request — we’d love to hear from you.
