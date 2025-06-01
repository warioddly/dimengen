
/// Meta information for the Dimengen generator.
class Dimengen {

  /// Creates an instance of [Dimengen].
  const Dimengen({
    this.insetsName = 'Insets',
    this.bordersName = 'Borders',
    this.spacesName = 'Spaces',
    this.generateInsets = true,
    this.generateBorders = true,
    this.generateSpaces = true,
  });

  /// Whether to generate insets.
  final bool generateInsets;

  /// Whether to generate border radius.
  final bool generateBorders;

  /// Whether to generate spaces.
  final bool generateSpaces;

  /// Name for the generated insets class.
  final String? insetsName;

  /// Name for the generated border radius class.
  final String? bordersName;

  /// Name for the generated spaces class.
  final String? spacesName;

}

/// Meta information for the Insets generator.
class Insetgen {

  /// Creates an instance of [Insetgen].
  const Insetgen({
    this.name = 'Insets',
    this.generate = true,
  });

  /// Name for the generated insets class.
  final String name;

  /// Whether to generate insets.
  final bool generate;

}

/// Meta information for the Borders generator.
class Bordergen {

  /// Creates an instance of [Bordergen].
  const Bordergen({
    this.name = 'Borders',
    this.generate = true,
  });

  /// Name for the generated border radius class.
  final String? name;

  /// Whether to generate border radius.
  final bool generate;

}

/// Meta information for the Spaces generator.
class Spacegen {

  /// Creates an instance of [Spacegen].
  const Spacegen({
    this.name = 'Spaces',
    this.generate = true,
  });

  /// Name for the generated spaces class.
  final String? name;

  /// Whether to generate spaces.
  final bool generate;

}

/// Metadata for the `@Take` annotation used in the generated class.
class _Take {

  /// Creates an instance of [Take].
  const _Take();
}

/// Metadata for the `@take` annotation used in the generated class.
const Object take = _Take();
