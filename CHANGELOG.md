## 1.0.0

- **Major Release**: Stable version with improved code generation
- **Breaking Changes**: 
  - Minimum SDK version updated to `>=3.10.0`
  - Updated dependencies: `source_gen ^4.0.2`, `build ^4.0.2`, `analyzer 8.2.0`, `flutter_lints ^6.0.0`
- **Improvements**:
  - Refactored `DimensionsGenerator` with template configuration system for better maintainability
  - Added comprehensive `ignore_for_file` directives to generated files to suppress linter warnings
  - Improved code formatting in generated classes
  - Enhanced code readability and extensibility

## 0.5.0

- **Breaking Changes**:
  - Removed `@take` annotation (deprecated feature)
- **Improvements**:
  - Code cleanup and refactoring
  - Improved generator performance
  - Enhanced error handling

## 0.4.0

- **Features**:
  - Added support for modular generation with separate annotations (`@Insetgen`, `@Bordergen`, `@Spacegen`)
  - Added customizable class names for generated classes
  - Added control flags to enable/disable generation of specific dimension types
- **Improvements**:
  - Better code organization
  - Improved template system
  - Enhanced documentation

## 0.3.0

- **Breaking Changes**:
  - Downgraded dependencies for better compatibility with older Flutter versions
- **Improvements**:
  - Improved compatibility with various Flutter SDK versions
  - Fixed dependency conflicts

## 0.2.1

- **Bug Fixes**:
  - Fixed dependency version constraints
  - Downgraded analyzer version to `^3.2.0` for compatibility
- **Improvements**:
  - Better error messages
  - Improved build stability

## 0.2.0

- **Features**:
  - Added `@take` annotation to generate a class with a specified number of properties
  - Enhanced generation capabilities
- **Improvements**:
  - Improved code generation templates
  - Better support for combined dimension values
  - Enhanced generated code quality

## 0.1.1

- **Bug Fixes**:
  - Fixed issues with field extraction
  - Fixed generation errors in edge cases
- **Improvements**:
  - Improved error handling
  - Better validation of input values
  - Code quality improvements

## 0.1.0

- **Initial Release**:
  - Basic code generation for `EdgeInsets`, `BorderRadius`, and `SizedBox`
  - Support for `@Dimengen` annotation
  - Generation of single and combined dimension variants
  - Support for static const fields and getters
