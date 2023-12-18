part of 'extensions.dart';

extension NumExtension on num {
  /// Formats the number in thousand format and returns it as a [String].
  ///
  /// The method formats the number with commas as thousand separators.
  /// It also handles decimal parts if [includeDecimalPart] is set to true.
  /// For example, 1234567.89 will be formatted as "1,234,567.89".
  ///
  /// If [includeDecimalPart] is set to false and the decimal part is zero or null,
  /// it will be excluded from the formatted output.
  ///
  /// If the number is negative, the formatted output will include a '-' sign at the beginning.
  ///
  /// Example:
  /// ```dart
  /// num number1 = 1234567;
  /// String formatted1 = number1.toThousandFormat();
  /// print(formatted1); // Output: "1,234,567"
  ///
  /// num number2 = 1234567.89;
  /// String formatted2 = number2.toThousandFormat();
  /// print(formatted2); // Output: "1,234,567.89"
  ///
  /// num number3 = -1234567.89;
  /// String formatted3 = number3.toThousandFormat();
  /// print(formatted3); // Output: "-1,234,567.89"
  ///
  /// num number4 = 1234.0;
  /// String formatted4 = number4.toThousandFormat(includeDecimalPart: false);
  /// print(formatted4); // Output: "1,234"
  /// ```
  String toThousandFormat({
    bool includeDecimalPart = false,
    int? fractionalDigits,
    bool? invertThousandSeparator,
  }) {
    String numString;

    if (fractionalDigits != null) {
      numString = toStringAsFixed(fractionalDigits);
    } else {
      numString = toString();
    }

    String formattedString = '';
    String decimalPart = '';

    if (numString.contains('.')) {
      int dotIndex = numString.indexOf('.');
      decimalPart = numString.substring(dotIndex);

      if (decimalPart.length > 1) {
        numString = numString.substring(0, dotIndex);
      } else {
        decimalPart = '';
      }
    }

    bool isNegative = false;
    if (numString.startsWith('-')) {
      isNegative = true;
      numString = numString.substring(1);
    }

    int count = 0;
    for (int i = numString.length - 1; i >= 0; i--) {
      formattedString = numString[i] + formattedString;
      count++;

      if (count % 3 == 0 && i != 0) {
        formattedString = '${(invertThousandSeparator ?? (navigatorKey.currentContext != null ? MWidgetTheme.of(navigatorKey.currentContext!)?.invertThousandSeparator : null) ?? false) ? '.' : ','}$formattedString';
      }
    }

    if (!includeDecimalPart && int.tryParse(decimalPart.replaceAll('.', '')) == 0) {
      return (isNegative ? '-' : '') + formattedString;
    }

    return (isNegative ? '-' : '') + formattedString + decimalPart.replaceFirst('.', (invertThousandSeparator ?? (navigatorKey.currentContext != null ? MWidgetTheme.of(navigatorKey.currentContext!)?.invertThousandSeparator : null) ?? false) ? ',' : '.');
  }
}
