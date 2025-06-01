import 'package:build/build.dart';
import 'package:dimengen/src/generators/borders_generator.dart';
import 'package:dimengen/src/generators/spaces_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'src/generators/dimensions_generator.dart';
import 'src/generators/insets_generator.dart';


/// Creates a [PartBuilder] for generating dimension-related code.
Builder dimengenBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [
      DimensionsGenerator(),
      InsetsGenerator(),
      BordersGenerator(),
      SpacesGenerator(),
    ],
    'dimengen',
  );
}