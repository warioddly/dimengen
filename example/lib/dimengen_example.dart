/// Пример использования опциональной генерации сниппетов
/// Просто добавьте @DimengenSnippets к нужному классу
library;

class DimengenSnippets {
  const DimengenSnippets();
}

@DimengenSnippets()
class Dimensions {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 32.0;
}

// Класс без аннотации — сниппеты не будут сгенерированы
class Insets {
  static const double tiny = 2.0;
  static const double huge = 64.0;
}
