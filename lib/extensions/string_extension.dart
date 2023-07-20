part of 'extensions.dart';

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
  /// input.extractNumberString() // -034
  /// ```
  String? extractNumberString() {
    RegExpMatch? match = RegExp(r'^-?\d+').firstMatch(this);

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
}
