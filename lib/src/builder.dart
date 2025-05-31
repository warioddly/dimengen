import 'package:build/build.dart';
import 'package:dimengen/src/generators/borders_generator.dart';
import 'package:dimengen/src/generators/spaces_generator.dart';
import 'package:dimengen/src/utils/header.dart';
import 'package:source_gen/source_gen.dart';

import 'generators/dimensions_generator.dart';
import 'generators/insets_generator.dart';


/// Creates a [PartBuilder] for generating dimension-related code.
Builder dimengenBuilder(BuilderOptions options) {
  return PartBuilder(
    [
      DimensionsGenerator(),
      InsetsGenerator(),
      BordersGenerator(),
      SpacesGenerator(),
    ],
    '.g.dart',
    writeDescriptions: true,
    options: options,
    header: fileHeader,
  );
}
