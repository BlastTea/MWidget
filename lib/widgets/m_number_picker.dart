part of 'widgets.dart';

/// A customizable number picker widget that allows users to input a numeric value within a specific range.
///
/// The `MNumberPicker` widget provides a text input field with increment and decrement buttons
/// to adjust the numeric value within the specified [minValue] and [maxValue] range.
///
/// The initial value is set using [initialValue], and the user can adjust the value using the increment and decrement buttons
/// or by directly typing a numeric value in the text input field. The value is clamped to the specified [minValue] and [maxValue].
///
/// The [step] parameter determines the amount to increment or decrement the value when using the buttons (default is 1).
///
/// When the numeric value changes, the [onChanged] callback is called with the updated value.
///
/// Example usage:
/// ```dart
/// MNumberPicker(
///   initialValue: 10,
///   minValue: 0,
///   maxValue: 100,
///   step: 5,
///   onChanged: (value) {
///     // Handle the updated value
///     print('New value: $value');
///   },
/// )
/// ```
class MNumberPicker extends StatefulWidget {
  /// Creates a customizable number picker widget.
  ///
  /// The [initialValue] parameter sets the initial numeric value of the picker.
  ///
  /// The [minValue] and [maxValue] parameters define the range within which the numeric value can be adjusted.
  ///
  /// The [onChanged] callback is called when the numeric value changes and provides the updated value.
  ///
  /// The [step] parameter determines the amount to increment or decrement the value when using the buttons (default is 1).
  ///
  /// Example usage:
  /// ```dart
  /// MNumberPicker(
  ///   initialValue: 10,
  ///   minValue: 0,
  ///   maxValue: 100,
  ///   step: 5,
  ///   onChanged: (value) {
  ///     // Handle the updated value
  ///     print('New value: $value');
  ///   },
  /// )
  /// ```
  const MNumberPicker({
    super.key,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    this.step = 1,
  });

  final int initialValue;
  final int minValue;
  final int maxValue;
  final int step;
  final ValueChanged<int> onChanged;

  @override
  State<MNumberPicker> createState() => _MNumberPickerState();
}

class _MNumberPickerState extends State<MNumberPicker> {
  final FocusNode _focusNodeTextField = FocusNode();

  late TextEditingController _textController;

  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    _textController = TextEditingController(text: _value.toString());
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _decrementValue() => setState(() {
        _value = (_value - widget.step).clamp(widget.minValue, widget.maxValue);
        _text = _value.toString();
        widget.onChanged(_value);
      });

  void _incrementValue() => setState(() {
        _value = (_value + widget.step).clamp(widget.minValue, widget.maxValue);
        _text = _value.toString();
        widget.onChanged(_value);
      });

  set _text(String value) {
    _textController.text = value.toString();
    if (_focusNodeTextField.hasFocus) {
      _textController.selection = TextSelection.collapsed(
        offset: value.toString().length,
        affinity: TextAffinity.upstream,
      );
    }
  }

  @override
  Widget build(BuildContext context) => TextField(
        focusNode: _focusNodeTextField,
        controller: _textController,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [textFormatterDigitsOnly],
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          prefixIcon: IconButton(
            icon: const Icon(Icons.remove),
            onPressed: _value != widget.minValue ? _decrementValue : null,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.add),
            onPressed: _value != widget.maxValue ? _incrementValue : null,
          ),
        ),
        onChanged: (value) => setState(() {
          _value = (int.tryParse(value) ?? widget.minValue).clamp(widget.minValue, widget.maxValue);
          _text = _value.toString();
          widget.onChanged(_value);
        }),
      );
}
