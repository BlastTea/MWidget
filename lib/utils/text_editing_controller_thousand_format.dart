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
  /// - [min]: If provided, values smaller than this will be clamped to [min].
  /// - [max]: If provided, values larger than this will be clamped to [max].
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
    num? min,
    num? max,
    this.includeNegative = false,
    this.includeDouble = false,
    this.fractionalDigits,
    this.invertThousandSeparator,
    FocusNode? focusNode,
  }) : assert(
         min == null || max == null || min <= max,
         'min cannot be greater than max',
       ) {
    _minValue = min;
    _maxValue = max;
    _focusNode = focusNode;

    addListener(() {
      if (_ignoreListener) return;

      final raw = text;

      if (raw.trim().isEmpty) {
        _setFormattedText('');
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

      num? numericValue;
      if (intPart.isNotEmpty || fracPart.isNotEmpty) {
        final parseBuffer = StringBuffer(prefix);
        parseBuffer.write(intPart.isEmpty ? '0' : intPart);
        if (hasDec) {
          parseBuffer.write('.');
          parseBuffer.write(fracPart);
        }
        numericValue = num.tryParse(parseBuffer.toString());
      }

      final formattedInt = _formatIntWithThousand(intPart, thou);

      String formatted = prefix + formattedInt;
      if (hasDec) {
        formatted += dec + fracPart;
      }

      if (numericValue != null) {
        final boundedValue = _applyBounds(numericValue);
        if (boundedValue != null && boundedValue != numericValue) {
          if (_maxValue != null && numericValue > _maxValue!) {
            formatted = boundedValue.toThousandFormat(
              includeDecimalPart: includeDouble,
              fractionalDigits: fractionalDigits,
              invertThousandSeparator: invertThousandSeparator,
            );
          }
        }
      }

      if (formatted.isEmpty && prefix == '-') {
        formatted = '-';
      }

      _setFormattedText(formatted);
    });

    if (_focusNode != null) {
      _focusNodeListener = () {
        if (!_focusNode!.hasFocus) {
          _enforceBoundsOnText();
        }
      };
      _focusNode!.addListener(_focusNodeListener!);
    }

    final boundedInitialNumber = _applyBounds(number);

    if (boundedInitialNumber != null) {
      _setFormattedText(
        boundedInitialNumber.toThousandFormat(
          includeDecimalPart: includeDouble,
          fractionalDigits: fractionalDigits,
          invertThousandSeparator: invertThousandSeparator,
        ),
      );
    }
  }

  /// If `true`, negative numbers will include a negative sign at the beginning.
  final bool includeNegative;

  /// If `true`, numbers with decimal parts will display the decimal point and digits after it.
  final bool includeDouble;

  /// Minimum allowed value. If `null`, no lower bound is applied.
  num? get min => _minValue;
  set min(num? value) {
    assert(
      value == null || _maxValue == null || value <= _maxValue!,
      'min cannot be greater than max',
    );
    if (_minValue == value) return;
    _minValue = value;
    _enforceBoundsOnText();
  }

  /// Maximum allowed value. If `null`, no upper bound is applied.
  num? get max => _maxValue;
  set max(num? value) {
    assert(
      value == null || _minValue == null || value >= _minValue!,
      'max cannot be smaller than min',
    );
    if (_maxValue == value) return;
    _maxValue = value;
    _enforceBoundsOnText();
  }

  final int? fractionalDigits;

  final bool? invertThousandSeparator;

  FocusNode? _focusNode;
  VoidCallback? _focusNodeListener;
  String _previousText = '';
  bool _ignoreListener = false;

  num? _minValue;
  num? _maxValue;

  String get _thousandSeparator =>
      (invertThousandSeparator ??
          (navigatorKey.currentContext != null
              ? MWidgetTheme.of(
                  navigatorKey.currentContext!,
                )?.invertThousandSeparator
              : null) ??
          false)
      ? '.'
      : ',';

  String get _decimalSeparator =>
      (invertThousandSeparator ??
          (navigatorKey.currentContext != null
              ? MWidgetTheme.of(
                  navigatorKey.currentContext!,
                )?.invertThousandSeparator
              : null) ??
          false)
      ? ','
      : '.';

  void _setFormattedText(String formatted) {
    if (_previousText == formatted && text == formatted) {
      _previousText = formatted;
      return;
    }

    _ignoreListener = true;
    value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
        affinity: TextAffinity.upstream,
      ),
      composing: TextRange.empty,
    );
    _previousText = formatted;
    _ignoreListener = false;
  }

  num? _parseText() {
    final thou = _thousandSeparator;
    final dec = _decimalSeparator;
    final raw = text.replaceAll(thou, '').replaceAll(dec, '.').trim();
    if (raw.isEmpty || raw == '-') return null;
    return num.tryParse(raw);
  }

  void _enforceBoundsOnText() {
    final parsed = _parseText();
    final bounded = _applyBounds(parsed);

    if (bounded == null) {
      if (parsed != null) {
        _setFormattedText('');
      }
      return;
    }

    if (parsed != null && bounded == parsed) return;

    _setFormattedText(
      bounded.toThousandFormat(
        includeDecimalPart: includeDouble,
        fractionalDigits: fractionalDigits,
        invertThousandSeparator: invertThousandSeparator,
      ),
    );
  }

  num? _applyBounds(num? value) {
    if (value == null) return null;

    num result = value;
    if (_minValue != null && result < _minValue!) {
      result = _minValue!;
    }

    if (_maxValue != null && result > _maxValue!) {
      result = _maxValue!;
    }

    return result;
  }

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

  num? get number => _applyBounds(_parseText());

  @override
  void dispose() {
    if (_focusNodeListener != null) {
      _focusNode?.removeListener(_focusNodeListener!);
    }
    super.dispose();
  }
}
