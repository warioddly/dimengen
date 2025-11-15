import 'package:dimengen/dimengen.dart';
import 'package:dimengen/src/generators/_generator.dart';
import 'package:dimengen/src/templates/_template.dart';
import 'package:dimengen/src/templates/spaces_template.dart';

/// Generates a class with static constants for various spacing configurations.
class SpacesGenerator extends Generator<Spacegen> {
  @override
  Template get template => SpacesTemplate();

  @override
  String get metaName => 'Spacegen';
}
