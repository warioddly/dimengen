import 'package:build/build.dart';
import 'package:dimengen/src/generators/spaces_generator.dart';
import 'package:dimengen/src/utils/header.dart';
import 'package:source_gen/source_gen.dart';

import 'generators/insets_generator.dart' show InsetsGenerator;

Builder dimengenBuilder(BuilderOptions options) {
  return PartBuilder(
    [
      InsetsGenerator(),
      SpacesGenerator(),
    ],
    '.g.dart',
    writeDescriptions: true,
    options: options,
    header: fileHeader,
  );
}
