import 'package:build/build.dart';
import 'package:dimengen/src/builder/snippet_builder.dart';
import 'package:dimengen/src/generators/borders_generator.dart';
import 'package:dimengen/src/generators/spaces_generator.dart';
import 'package:dimengen/src/generators/dimensions_generator.dart';
import 'package:dimengen/src/generators/insets_generator.dart';
import 'package:source_gen/source_gen.dart';


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

Builder snippetBuilder(BuilderOptions options) => DimengenSnippetBuilder();
