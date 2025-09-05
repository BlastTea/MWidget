part of 'utils.dart';

/// A custom [TextEditingController] that automatically formats the text input as a thousand-formatted number.
///
/// The [TextEditingControllerThousandFormat] formats the text input by adding commas as thousand separators.
/// It allows for easy input and display of large numbers with commas.
///
/// By default, the formatting includes only positive numbers without decimal parts.
/// You can customize the behavior by specifying the [includeNegative] and [includeDouble] flags:
/// - [includeNegative]: If set to `true`, negative numbers will include a negative sign at the beginning.
/// - [includeDouble]: If set to `true`, numbers with decimal parts will display the decimal point and digits after it.
///
/// Usage:
/// ```dart
/// TextEditingControllerThousandFormat controller = TextEditingControllerThousandFormat(
///   includeNegative: true,
///   includeDouble: true,
///   number: 1234567.89,
/// );
///
/// // Assuming the user inputs '-1234567.89'
/// print(controller.text); // Output: '-1,234,567.89'
/// ```
class TextEditingControllerThousandFormat extends TextEditingController {
  /// Creates a [TextEditingControllerThousandFormat].
  ///
  /// The [includeNegative] and [includeDouble] flags control the formatting behavior.
  /// If [number] is provided, it will be formatted and set as the initial value.
  ///
  /// By default, [includeNegative] is set to `false` and [includeDouble] is set to `false`.
  /// - [includeNegative]: If set to `true`, negative numbers will include a negative sign at the beginning.
  /// - [includeDouble]: If set to `true`, numbers with decimal parts will display the decimal point and digits after it.
  ///
  /// Example usage:
  /// ```dart
  /// TextEditingControllerThousandFormat controller = TextEditingControllerThousandFormat(
  ///   includeNegative: true,
  ///   includeDouble: true,
  ///   number: 1234567.89,
  /// );
  /// ```
  TextEditingControllerThousandFormat({
    num? number,
    this.includeNegative = false,
    this.includeDouble = false,
    this.fractionalDigits,
    this.invertThousandSeparator,
  }) {
    bool ignoreChanges = false;

    addListener(() {
      if (ignoreChanges) return;

      final raw = text;

      if (raw.trim().isEmpty) {
        value = const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0, affinity: TextAffinity.upstream),
          composing: TextRange.empty,
        );
        _previousText = '';
        return;
      }

      final thou = _thousandSeparator;
      final dec = _decimalSeparator;

      String prefix = '';
      String t = raw;

      if (includeNegative && t.startsWith('-')) {
        prefix = '-';
        t = t.substring(1);
      }

      t = t.replaceAll('-', '');

      t = t.replaceAll(thou, '');

      if (includeDouble && (fractionalDigits ?? 1) > 0) {
        t = t.replaceAll(RegExp('[^0-9$dec]'), '');
      } else {
        t = t.replaceAll(RegExp('[^0-9]'), '');
      }

      String intPart = t;
      String fracPart = '';
      bool hasDec = false;

      if (includeDouble && (fractionalDigits ?? 1) > 0) {
        final firstDec = t.indexOf(dec);
        if (firstDec != -1) {
          hasDec = true;
          intPart = t.substring(0, firstDec);
          fracPart = t.substring(firstDec + 1);

          if (fracPart.contains(dec)) {
            fracPart = fracPart.replaceAll(dec, '');
          }

          fracPart = fracPart.replaceAll(RegExp(r'[^0-9]'), '');

          if (fractionalDigits != null && fracPart.length > fractionalDigits!) {
            fracPart = fracPart.substring(0, fractionalDigits!);
          }
        }
      }

      intPart = intPart.replaceAll(RegExp(r'[^0-9]'), '');

      final formattedInt = _formatIntWithThousand(intPart, thou);

      String formatted = prefix + formattedInt;
      if (hasDec) {
        formatted += dec + fracPart;
      }

      if (formatted.isEmpty && prefix == '-') {
        formatted = '-';
      }

      if (_previousText != formatted || text != formatted) {
        ignoreChanges = true;
        value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length, affinity: TextAffinity.upstream),
          composing: TextRange.empty,
        );
        _previousText = formatted;
        ignoreChanges = false;
      }
    });

    if (number != null) {
      text = number.toThousandFormat(
        includeDecimalPart: includeDouble,
        fractionalDigits: fractionalDigits,
        invertThousandSeparator: invertThousandSeparator,
      );
    }
  }

  /// If `true`, negative numbers will include a negative sign at the beginning.
  final bool includeNegative;

  /// If `true`, numbers with decimal parts will display the decimal point and digits after it.
  final bool includeDouble;

  final int? fractionalDigits;

  final bool? invertThousandSeparator;

  String _previousText = '';

  String get _thousandSeparator => (invertThousandSeparator ?? (Get.context != null ? MWidgetTheme.of(Get.context!)?.invertThousandSeparator : null) ?? false) ? '.' : ',';

  String get _decimalSeparator => (invertThousandSeparator ?? (Get.context != null ? MWidgetTheme.of(Get.context!)?.invertThousandSeparator : null) ?? false) ? ',' : '.';

  String _formatIntWithThousand(String digits, String sep) {
    if (digits.isEmpty) return '';
    final buf = StringBuffer();
    int count = 0;
    for (int i = digits.length - 1; i >= 0; i--) {
      buf.write(digits[i]);
      count++;
      if (count % 3 == 0 && i != 0) buf.write(sep);
    }
    return buf.toString().split('').reversed.join();
  }

  num? get number {
    final thou = _thousandSeparator;
    final dec = _decimalSeparator;
    final raw = text.replaceAll(thou, '').replaceAll(dec, '.').trim();
    if (raw.isEmpty || raw == '-') return null;
    return num.tryParse(raw);
  }
}
