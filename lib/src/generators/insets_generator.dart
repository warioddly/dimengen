import 'package:dimengen/dimengen.dart';
import 'package:dimengen/src/generators/_generator.dart';
import 'package:dimengen/src/templates/_template.dart';
import 'package:dimengen/src/templates/insets_template.dart';

/// Generates a class with static constants for various insets configurations.
class InsetsGenerator extends Generator<Insetgen> {
  @override
  Template get template => InsetsTemplate();

  @override
  String get metaName => 'Insetgen';
}
