import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dimengen/dimengen.dart';
import 'package:dimengen/src/generators/_generator.dart';
import 'package:dimengen/src/templates/_template.dart';
import 'package:dimengen/src/templates/borders_template.dart';
import 'package:dimengen/src/templates/insets_template.dart';
import 'package:dimengen/src/templates/spaces_template.dart';
import 'package:dimengen/src/utils/extractor.dart';
import 'package:dimengen/src/utils/header.dart' show defaultHeader;
import 'package:dimengen/src/utils/resolver.dart';
import 'package:source_gen/source_gen.dart' hide Generator;

/// Configuration for a template type that can be generated.
class _TemplateConfig {
  const _TemplateConfig({
    required this.template,
    required this.nameKey,
    required this.generateKey,
  });

  final Template template;
  final String nameKey;
  final String generateKey;
}

/// Generates classes with static constants for various dimension configurations.
class DimensionsGenerator extends GeneratorForAnnotation<Dimengen> {
  /// Configuration for all available template types.
  static final _templateConfigs = [
    _TemplateConfig(
      template: InsetsTemplate(),
      nameKey: 'insetsName',
      generateKey: 'generateInsets',
    ),
    _TemplateConfig(
      template: SpacesTemplate(),
      nameKey: 'spacesName',
      generateKey: 'generateSpaces',
    ),
    _TemplateConfig(
      template: BordersTemplate(),
      nameKey: 'bordersName',
      generateKey: 'generateBorders',
    ),
  ];

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    throwInvalidSourceError(element, 'Dimengen');

    final fields = {
      ...await extractFinalValues(buildStep),
      ...extractElementValues(element as ClassElement),
    };

    final generatedClasses = _templateConfigs
        .map((config) => _generateClass(config, annotation, fields))
        .where((code) => code.isNotEmpty)
        .toList();

    if (generatedClasses.isEmpty) {
      return '';
    }

    final buffer = StringBuffer()
      ..writeln(defaultHeader)
      ..writeln(generatedClasses.join('\n\n'));

    return buffer.toString();
  }

  /// Generates a single class for the given template configuration.
  String _generateClass(
    _TemplateConfig config,
    ConstantReader annotation,
    Map<String, String> fields,
  ) {
    final shouldGenerate = annotation.read(config.generateKey);

    if (!shouldGenerate.boolValue) {
      return '';
    }

    final className = resolveClassName(config.nameKey, annotation);
    final classContent = config.template.generateFor(fields);

    final buffer = StringBuffer()
      ..writeln('abstract class $className {')
      ..writeln('  const $className._();')
      ..writeln()
      ..writeln(classContent)
      ..writeln('}');

    return buffer.toString();
  }
}
