import 'dart:convert';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';

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
    final json = <String, dynamic>{};
    final xml = StringBuffer('<templateSet group="Dimensions">\n');

    void add(String key, String body, String value) {
      json[key] = {
        'prefix': key,
        'body': body,
        'description': '$body ($value)'
      };
      xml.writeln(
          '  <template name="$key" value="$body" description="$body ($value)">'+
          '<context><option name="DART_EXPRESSION" value="true"/></context>'+
          '</template>');
    }

    await for (final input in step.findAssets(Glob('lib/**.dart'))) {
      final content = await step.readAsString(input);
      if (!content.contains('@Dimengen')) continue;

      final unit = parseString(content: content).unit;

      for (var c in unit.declarations.whereType<ClassDeclaration>()) {
        if (!c.metadata.any((m) => m.name.name == 'Dimengen')) continue;

        for (var f in c.members.whereType<FieldDeclaration>()) {
          if (!f.isStatic || !f.fields.isConst) continue;
          for (var v in f.fields.variables) {
            final name = v.name.lexeme;
            final value = v.initializer?.toString() ?? '';
            final num = value.split('.').first;

            // Dimensions
            add('d$num', 'Dimensions.$name', value);
            // Insets
            add('in$num', 'Insets.$name', value);
            add('iv$num', 'Insets.${name}Vertical', value);
            add('ih$num', 'Insets.${name}Horizontal', value);
            // Spaces
            add('sp$num', 'Spaces.$name', value);
            add('sv$num', 'Spaces.${name}Vertical', value);
            add('sh$num', 'Spaces.${name}Horizontal', value);
          }
        }
      }
    }

    xml.writeln('</templateSet>');

    if (json.isEmpty) return;

    await step.writeAsString(
        AssetId(step.inputId.package, '.vscode/dimengen.code-snippets'),
        const JsonEncoder.withIndent('  ').convert(json));
    await step.writeAsString(
        AssetId(step.inputId.package,
            '.idea/liveTemplates/DimensionsTemplates.xml'),
        xml.toString());
  }
}