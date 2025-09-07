import 'package:dimengen/dimengen.dart';
import 'package:dimengen/src/generators/_generator.dart';
import 'package:dimengen/src/templates/_template.dart';
import 'package:dimengen/src/templates/borders_template.dart';

/// Generates a class with static constants for various border radius configurations.
class BordersGenerator extends Generator<Bordergen> {

  @override
  Template get template => BordersTemplate();

  @override
  String get metaName => 'Bordergen';

}
