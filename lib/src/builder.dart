import 'package:build/build.dart';
import 'package:dimengen/src/utils/header.dart';
import 'package:source_gen/source_gen.dart';

import 'package:dimengen/src/generators/spaces_generator.dart';
import 'package:dimengen/src/generators/border_radius_generator.dart';
import 'package:dimengen/src/generators/insets_generator.dart';

Builder dimengenBuilder(BuilderOptions options) {
  return PartBuilder(
    [
      InsetsGenerator(),
      SpacesGenerator(),
      BorderRadiusGenerator(),
    ],
    '.g.dart',
    writeDescriptions: true,
    options: options,
    header: fileHeader,
  );
}
