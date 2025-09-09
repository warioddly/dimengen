import 'dart:convert';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';

/// Вынесенная логика генерации сниппетов
class SnippetGenerator {
  final Map<String, dynamic> json = {};
  final StringBuffer xml = StringBuffer('<templateSet group="Dimensions">\n');

  void add(String key, String body, String value) {
    json[key] = {'prefix': key, 'body': body, 'description': '$body ($value)'};
    xml.writeln('  <template name="$key" value="$body" description="$body ($value)"'
        '<context><option name="DART_EXPRESSION" value="true"/></context>'
        '</template>');
  }

  void processUnit(CompilationUnit unit) {
    for (var c in unit.declarations.whereType<ClassDeclaration>()) {
      // Генерируем сниппеты только для классов с аннотацией @DimengenSnippets
      if (!c.metadata.any((m) => m.name.name == 'DimengenSnippets')) continue;
      for (var f in c.members.whereType<FieldDeclaration>()) {
        if (!f.isStatic || !f.fields.isConst) continue;
        for (var v in f.fields.variables) {
          final name = v.name.lexeme;
          final value = v.initializer?.toString() ?? '';
          final num = value.split('.').first;
          add('d$num', 'Dimensions.$name', value);
          add('in$num', 'Insets.$name', value);
          add('iv$num', 'Insets.${name}Vertical', value);
          add('ih$num', 'Insets.${name}Horizontal', value);
          add('sp$num', 'Spaces.$name', value);
          add('sv$num', 'Spaces.${name}Vertical', value);
          add('sh$num', 'Spaces.${name}Horizontal', value);
        }
      }
    }
  }

  void finalize() {
    xml.writeln('</templateSet>');
  }
}

class DimengenSnippetBuilder implements Builder {
  @override
  final buildExtensions = const {
    r'$package$': [
      '.vscode/dimengen.code-snippets',
      '.idea/liveTemplates/DimensionsTemplates.xml',
    ],
  };

  @override
  Future<void> build(BuildStep step) async {
    final generator = SnippetGenerator();
    // Обрабатываем файлы из lib и example/lib
    final globs = [Glob('lib/**.dart'), Glob('example/lib/**.dart')];
    for (final glob in globs) {
      await for (final input in step.findAssets(glob)) {
        final content = await step.readAsString(input);
        if (!content.contains('@Dimengen')) continue;
        final unit = parseString(content: content).unit;
        generator.processUnit(unit);
      }
    }
    generator.finalize();
    if (generator.json.isEmpty) return;
    await step.writeAsString(AssetId(step.inputId.package, '.vscode/dimengen.code-snippets'),
        const JsonEncoder.withIndent('  ').convert(generator.json));
    await step.writeAsString(
        AssetId(step.inputId.package, '.idea/liveTemplates/DimensionsTemplates.xml'),
        generator.xml.toString());
  }
}
