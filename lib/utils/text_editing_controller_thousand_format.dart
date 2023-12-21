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
    _isFirstTime = true;

    addListener(() {
      if (ignoreChanges) return;

      if (text.trim().isEmpty) {
        value = const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(
            offset: ''.length,
            affinity: TextAffinity.upstream,
          ),
          composing: TextRange.empty,
        );
        return;
      }

      String thousandSeparator = (invertThousandSeparator ?? (navigatorKey.currentContext != null ? MWidgetTheme.of(navigatorKey.currentContext!)?.invertThousandSeparator : null) ?? false) ? '.' : ',';
      String decimalSeparator = (invertThousandSeparator ?? (navigatorKey.currentContext != null ? MWidgetTheme.of(navigatorKey.currentContext!)?.invertThousandSeparator : null) ?? false) ? ',' : '.';

      String prefix = '';
      String numString = text.replaceAll(thousandSeparator, '');
      String formattedString = '';
      String decimalPart = '';
      String afterDot = '';

      if (numString[0] == '-' && includeNegative) {
        prefix = '-';
      }

      if (numString.contains(decimalSeparator)) {
        int dotIndex = numString.indexOf(decimalSeparator);
        decimalPart = numString.substring(dotIndex);

        if (decimalPart.length > 1) {
          afterDot = decimalPart.substring(1);
          numString = numString.substring(0, dotIndex);
        } else {
          decimalPart = decimalSeparator;
        }
      }

      int? numStringInt = numString.extractNumber();

      if (numStringInt != null) {
        formattedString = numStringInt.toThousandFormat(includeDecimalPart: false, fractionalDigits: fractionalDigits, invertThousandSeparator: invertThousandSeparator);
      }

      if (numString[0] == '-' && numStringInt == null) {
        formattedString = prefix;
      }

      if (decimalPart.count(decimalPart) == 1 && afterDot.isEmpty && includeDouble) {
        formattedString += decimalPart;
      } else if (afterDot.isNotEmpty) {
        formattedString += '$decimalPart${afterDot.extractNumberString() ?? ''}';
      }

      if (formattedString.contains(decimalPart) && _isFirstTime && afterDot.extractNumber() == 0) {
        formattedString = formattedString.substring(0, formattedString.indexOf(decimalPart));
      }

      if (_previousText != formattedString || text != formattedString || text.contains(decimalPart)) {
        ignoreChanges = true;

        final newSelection = TextSelection.collapsed(
          offset: formattedString.length,
          affinity: TextAffinity.upstream,
        );

        value = TextEditingValue(
          text: formattedString,
          selection: newSelection,
          composing: TextRange.empty,
        );

        _previousText = formattedString;
        ignoreChanges = false;
      }
      _isFirstTime = false;
    });

    if (number != null) {
      text = number.toThousandFormat(includeDecimalPart: false, fractionalDigits: fractionalDigits, invertThousandSeparator: invertThousandSeparator);
    }
  }

  /// If `true`, negative numbers will include a negative sign at the beginning.
  final bool includeNegative;

  /// If `true`, numbers with decimal parts will display the decimal point and digits after it.
  final bool includeDouble;

  final int? fractionalDigits;

  final bool? invertThousandSeparator;

  bool _isFirstTime = false;

  String _previousText = '';

  @override
  set text(String newText) {
    _isFirstTime = true;
    super.text = newText;
  }
}
