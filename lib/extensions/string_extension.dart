part of 'extensions.dart';

/// A set of useful extension methods for manipulating strings.
extension StringExtension on String {
  /// Counts the occurrences of a [value] in the string.
  ///
  /// Example:
  /// ```dart
  /// String value = '0...';
  /// value.count('.'); // 3
  /// ```
  int count(String value) {
    int result = 0;
    for (int i = 0; i < length; i++) {
      if (this[i] == value) {
        result++;
      }
    }
    return result;
  }

  /// Extracts the leading number from the string and returns it as a [String].
  ///
  /// If a number is found at the beginning of the string, it is extracted and returned as a [String].
  /// If no number is found, returns [null].
  ///
  /// Example:
  /// ```dart
  /// String input = '034sasdf';
  /// input.extractNumberString(); // 034
  ///
  /// String input = 'asdf';
  /// input.extractNumberString(); // null
  ///
  /// String input = '-034asdf';
  /// input.extractNumberString(); // -034
  /// ```
  String? extractNumberString() {
    RegExpMatch? match = RegExp(r'^-?\d+').firstMatch(this);
    match ??= RegExp(r'(\d+)').firstMatch(this);

    if (match != null) {
      return match.group(0)!;
    }

    return null;
  }

  /// Extracts the leading number from the string.
  ///
  /// If a number is found at the beginning of the string, it is extracted and returned as an [int].
  /// If no number is found, returns [null].
  ///
  /// Example:
  /// ```dart
  /// String input = '034asdf';
  /// input.extractNumber(); // 34
  ///
  /// String input = 'asdf';
  /// input.extractNumber(); // null
  ///
  /// String input = '-034';
  /// input.extractNumber(); // -34
  /// ```
  int? extractNumber() {
    String? extractedNumber = extractNumberString();
    if (extractedNumber != null) {
      return int.tryParse(extractedNumber);
    }
    return null;
  }

  /// Centers the string within the specified [width] using the provided [fill] character.
  ///
  /// The method creates a new string by padding the original string on both sides
  /// with the [fill] character to center it within the given [width]. If the length
  /// of the original string is already greater than or equal to the [width], the
  /// original string is returned unchanged.
  ///
  /// Example:
  /// ```dart
  /// String text = 'Discount';
  /// text.center(13, '-'); // Output: '---Discount--'
  /// text.center(10, '+'); // Output: '+Discount+'
  /// ```
  String center(int width, [String fill = '-']) {
    if (length >= width) {
      return this;
    } else {
      int padding = (width - length) ~/ 2;
      String centeredText = fill * padding + this + fill * padding;
      if (centeredText.length < width) {
        centeredText = '$fill$centeredText';
      }
      return centeredText;
    }
  }

  /// Converts the string to PascalCase.
  ///
  /// Converts a string into PascalCase where each word starts with an uppercase letter
  /// and there are no spaces or underscores between words.
  ///
  /// Example:
  /// ```dart
  /// final input = 'hello world';
  /// final pascalCase = input.toPascalCase();
  /// print(pascalCase); // Output: 'HelloWorld'
  /// ```
  String toPascalCase() {
    final words = split(RegExp(r'[_\s]')).map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    });
    return words.join();
  }

  /// Converts the string to camelCase.
  ///
  /// Converts a string into camelCase where each word starts with an uppercase letter
  /// except the first word, and there are no spaces or underscores between words.
  ///
  /// Example:
  /// ```dart
  /// final input = 'hello world';
  /// final camelCase = input.toCamelCase();
  /// print(camelCase); // Output: 'helloWorld'
  /// ```
  String toCamelCase() {
    final pascalCase = toPascalCase();
    return pascalCase[0].toLowerCase() + pascalCase.substring(1);
  }

  /// Converts the string to snake_case.
  ///
  /// Converts a string into snake_case where words are separated by underscores
  /// and all letters are lowercase.
  ///
  /// Example:
  /// ```dart
  /// final input = 'HelloWorld';
  /// final snakeCase = input.toSnakeCase();
  /// print(snakeCase); // Output: 'hello_world'
  /// ```
  String toSnakeCase() => replaceAllMapped(RegExp(r'(?<=[a-z])[A-Z]'), (match) => '_${match.group(0)!.toLowerCase()}').toLowerCase();

  /// Converts the string to kebab-case.
  ///
  /// Converts a string into kebab-case where words are separated by hyphens
  /// and all letters are lowercase.
  ///
  /// Example:
  /// ```dart
  /// final input = 'HelloWorld';
  /// final kebabCase = input.toKebabCase();
  /// print(kebabCase); // Output: 'hello-world'
  /// ```
  String toKebabCase() => replaceAllMapped(RegExp(r'(?<=[a-z])[A-Z]'), (match) => '-${match.group(0)!.toLowerCase()}').toLowerCase();

  /// Converts the string to flatcase.
  ///
  /// Converts a string into flatcase where words are concatenated without any separation,
  /// and all letters are lowercase.
  ///
  /// Example:
  /// ```dart
  /// final input = 'Hello World';
  /// final flatcase = input.toFlatCase();
  /// print(flatcase); // Output: 'helloworld'
  /// ```
  String toFlatCase() => replaceAll(RegExp(r'[\s]'), '').toLowerCase();

  /// Converts the string to UPPER_FLAT_CASE.
  ///
  /// Converts a string into UPPER_FLAT_CASE where words are concatenated with underscores,
  /// and all letters are uppercase.
  ///
  /// Example:
  /// ```dart
  /// final input = 'Hello World';
  /// final upperFlatCase = input.toUpperFlatCase();
  /// print(upperFlatCase); // Output: 'HELLO_WORLD'
  /// ```
  String toUpperFlatCase() => replaceAll(RegExp(r'[\s]'), '_').toUpperCase();

  /// Converts the string to Pascal_Snake_Case.
  ///
  /// Converts a string into Pascal_Snake_Case where words are concatenated with underscores,
  /// each word starts with an uppercase letter, and all letters are lowercase.
  ///
  /// Example:
  /// ```dart
  /// final input = 'Hello World';
  /// final pascalSnakeCase = input.toPascalSnakeCase();
  /// print(pascalSnakeCase); // Output: 'Hello_World'
  /// ```
  String toPascalSnakeCase() => split(RegExp(r'[_\s]')).map((word) => _capitalize(word)).join('_');

  /// Converts the string to camel_Snake_Case.
  ///
  /// Converts a string into camel_Snake_Case where words are concatenated with underscores,
  /// each word starts with an uppercase letter except the first word,
  /// and all letters are lowercase.
  ///
  /// Example:
  /// ```dart
  /// final input = 'Hello World';
  /// final camelSnakeCase = input.toCamelSnakeCase();
  /// print(camelSnakeCase); // Output: 'hello_World'
  /// ```
  String toCamelSnakeCase() {
    final words = split(RegExp(r'[_\s]')).map((word) {
      if (word.isEmpty) return '';
      return word[0].toLowerCase() + word.substring(1).toLowerCase();
    });
    return words.join('_');
  }

  /// Converts the string to SCREAMING_SNAKE_CASE.
  ///
  /// Converts a string into SCREAMING_SNAKE_CASE where words are concatenated with underscores,
  /// each word is in uppercase, and all letters are uppercase.
  ///
  /// Example:
  /// ```dart
  /// final input = 'Hello World';
  /// final screamingSnakeCase = input.toScreamingSnakeCase();
  /// print(screamingSnakeCase); // Output: 'HELLO_WORLD'
  /// ```
  String toScreamingSnakeCase() => split(RegExp(r'[_\s]')).map((word) => word.toUpperCase()).join('_');

  /// Converts the string to Train-Case.
  ///
  /// Converts a string into Train-Case where words are concatenated with hyphens,
  /// each word starts with an uppercase letter, and all letters are lowercase.
  ///
  /// Example:
  /// ```dart
  /// final input = 'Hello World';
  /// final trainCase = input.toTrainCase();
  /// print(trainCase); // Output: 'Hello-World'
  /// ```
  String toTrainCase() => split(RegExp(r'[_\s]')).map((word) => _capitalize(word)).join('-');

  /// Converts the string to COBOL-CASE.
  ///
  /// Converts a string into COBOL-CASE where words are concatenated with hyphens,
  /// each word is in uppercase, and all letters are uppercase.
  ///
  /// Example:
  /// ```dart
  /// final input = 'Hello World';
  /// final cobolCase = input.toCobolCase();
  /// print(cobolCase); // Output: 'HELLO-WORLD'
  /// ```
  String toCobolCase() => split(RegExp(r'[_\s]')).map((word) => word.toUpperCase()).join('-');

  String _capitalize(String word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1);
  }

  bool containsSequential() {
    List<int> charCodes = codeUnits;

    for (int i = 0; i < charCodes.length - 1; i++) {
      if (i + 2 < charCodes.length && (charCodes[i + 1] == charCodes[i] + 1) && (charCodes[i + 2] == charCodes[i] + 2)) return true;
    }

    return false;
  }
}
