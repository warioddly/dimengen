
/// Base class for all templates.
abstract class Template {

  /// Generates the code for the template based on the provided values.
  String generateFor(Map<String, String> fields);

}