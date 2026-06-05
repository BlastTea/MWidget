part of 'utils.dart';

/// A [TextEditingController] that inserts a separator every few characters
/// while keeping the raw text accessible without formatting.
///
/// Example:
/// ```dart
/// final controller = TextEditingControllerSeparatorFormat(
///   separator: '-',
///   groupLengths: const <int>[4],
///   allowedPattern: RegExp(r'[0-9]'),
/// );
///
/// controller.text = '1234567890';
/// print(controller.text); // 1234-5678-90
/// print(controller.rawText); // 1234567890
/// ```
class TextEditingControllerSeparatorFormat extends TextEditingController {
  TextEditingControllerSeparatorFormat({
    String? text,
    this.separator = '-',
    this.groupLengths = const <int>[4],
    this.allowedPattern,
  }) : assert(separator.isNotEmpty, 'separator cannot be empty'),
       assert(groupLengths.isNotEmpty, 'groupLengths cannot be empty'),
       assert(
         groupLengths.every((length) => length > 0),
         'groupLengths must contain positive values',
       ) {
    addListener(_handleTextChanged);

    if (text != null && text.isNotEmpty) {
      setText(text);
    }
  }

  /// The separator inserted between groups.
  final String separator;

  /// Group lengths applied from left to right.
  ///
  /// If the raw text is longer than the provided list, the last group length
  /// will be repeated for the remaining characters.
  final List<int> groupLengths;

  /// Optional per-character allow pattern.
  ///
  /// If provided, only characters matching this pattern are kept in [rawText].
  /// This is useful for digit-only or alphanumeric-only inputs.
  final RegExp? allowedPattern;

  bool _ignoreListener = false;

  /// Returns the text without separators.
  String get rawText => _extractRaw(super.text);

  /// Sets the text using the raw value.
  set rawText(String value) => setText(value);

  /// Sets a raw value and updates the displayed text with separators.
  void setText(String value) {
    final raw = _extractRaw(value);
    final formatted = _formatRaw(raw);
    _setFormattedValue(
      formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  @override
  set text(String newText) => setText(newText);

  void _handleTextChanged() {
    if (_ignoreListener) {
      return;
    }

    final currentValue = value;
    final formatted = _formatRaw(_extractRaw(currentValue.text));
    final selection = _mapSelection(currentValue, formatted);

    if (currentValue.text == formatted && currentValue.selection == selection && currentValue.composing == TextRange.empty) {
      return;
    }

    _setFormattedValue(formatted, selection: selection);
  }

  TextSelection _mapSelection(
    TextEditingValue currentValue,
    String formattedText,
  ) {
    if (!currentValue.selection.isValid) {
      return TextSelection.collapsed(offset: formattedText.length);
    }

    final baseRawIndex = _countRawCharsBeforeOffset(
      currentValue.text,
      currentValue.selection.baseOffset,
    );
    final extentRawIndex = _countRawCharsBeforeOffset(
      currentValue.text,
      currentValue.selection.extentOffset,
    );

    return TextSelection(
      baseOffset: _formattedOffsetForRawIndex(formattedText, baseRawIndex),
      extentOffset: _formattedOffsetForRawIndex(formattedText, extentRawIndex),
      affinity: currentValue.selection.affinity,
      isDirectional: currentValue.selection.isDirectional,
    );
  }

  int _countRawCharsBeforeOffset(String value, int offset) {
    final safeOffset = offset.clamp(0, value.length);
    return _extractRaw(value.substring(0, safeOffset)).length;
  }

  int _formattedOffsetForRawIndex(String formattedText, int rawIndex) {
    if (rawIndex <= 0) {
      return 0;
    }

    int rawCount = 0;
    int index = 0;
    while (index < formattedText.length) {
      if (formattedText.startsWith(separator, index)) {
        index += separator.length;
        continue;
      }

      rawCount += 1;
      index += 1;

      if (rawCount >= rawIndex) {
        return index;
      }
    }

    return formattedText.length;
  }

  String _extractRaw(String value) {
    if (value.isEmpty) {
      return '';
    }

    final buffer = StringBuffer();
    for (final rune in value.runes) {
      buffer.write(String.fromCharCode(rune));
    }

    var raw = buffer.toString().replaceAll(separator, '');
    if (allowedPattern == null) {
      return raw;
    }

    final sanitized = StringBuffer();
    for (final rune in raw.runes) {
      final character = String.fromCharCode(rune);
      if (allowedPattern!.hasMatch(character)) {
        sanitized.write(character);
      }
    }
    return sanitized.toString();
  }

  String _formatRaw(String raw) {
    if (raw.isEmpty) {
      return '';
    }

    final buffer = StringBuffer();
    int start = 0;
    int groupIndex = 0;

    while (start < raw.length) {
      final groupLength = groupLengths[min(groupIndex, groupLengths.length - 1)];
      final end = min(start + groupLength, raw.length);

      if (buffer.isNotEmpty) {
        buffer.write(separator);
      }

      buffer.write(raw.substring(start, end));
      start = end;
      groupIndex += 1;
    }

    return buffer.toString();
  }

  void _setFormattedValue(
    String formatted, {
    required TextSelection selection,
  }) {
    _ignoreListener = true;
    value = TextEditingValue(
      text: formatted,
      selection: selection,
      composing: TextRange.empty,
    );
    _ignoreListener = false;
  }
}
