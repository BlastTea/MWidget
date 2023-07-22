part of 'services.dart';

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

      String prefix = '';
      String numString = text.replaceAll(',', '');
      String formattedString = '';
      String decimalPart = '';
      String afterDot = '';

      if (numString[0] == '-' && includeNegative) {
        prefix = '-';
      }

      if (numString.contains('.')) {
        int dotIndex = numString.indexOf('.');
        decimalPart = numString.substring(dotIndex);

        if (decimalPart.length > 1) {
          afterDot = decimalPart.substring(1);
          numString = numString.substring(0, dotIndex);
        } else {
          decimalPart = '.';
        }
      }

      int? numStringInt = numString.extractNumber();

      if (numStringInt != null) {
        formattedString = numStringInt.toThousandFormat(includeDecimalPart: false);
      }

      if (numString[0] == '-' && numStringInt == null) {
        formattedString = prefix;
      }

      if (decimalPart.count('.') == 1 && afterDot.isEmpty && includeDouble) {
        formattedString += decimalPart;
      } else if (afterDot.isNotEmpty) {
        formattedString += '.${afterDot.extractNumberString() ?? ''}';
      }

      if (formattedString.contains('.') && _isFirstTime && afterDot.extractNumber() == 0) {
        formattedString = formattedString.substring(0, formattedString.indexOf('.'));
      }

      if (_previousText != formattedString || text != formattedString || text.contains('.')) {
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
      text = number.toThousandFormat(includeDecimalPart: false);
    }
  }

  /// If `true`, negative numbers will include a negative sign at the beginning.
  final bool includeNegative;

  /// If `true`, numbers with decimal parts will display the decimal point and digits after it.
  final bool includeDouble;

  bool _isFirstTime = false;

  String _previousText = '';

  @override
  set text(String newText) {
    _isFirstTime = true;
    super.text = newText;
  }
}
