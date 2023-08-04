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
}
