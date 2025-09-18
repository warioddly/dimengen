
/// Meta information for the Dimengen generator.
final class Dimengen {

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
final class Insetgen {

  /// Creates an instance of [Insetgen].
  const Insetgen({this.name = 'Insets'});

  /// Name for the generated insets class.
  final String name;

}

/// Meta information for the Borders generator.
final class Bordergen {

  /// Creates an instance of [Bordergen].
  const Bordergen({this.name = 'Borders'});

  /// Name for the generated border radius class.
  final String? name;

}

/// Meta information for the Spaces generator.
final class Spacegen {

  /// Creates an instance of [Spacegen].
  const Spacegen({this.name = 'Spaces'});

  /// Name for the generated spaces class.
  final String? name;

}