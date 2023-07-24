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
    this.controller,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    this.step = 1,
  });

  final MNumberPickerController? controller;
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

  late MNumberPickerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? MNumberPickerController();
    _controller.addListener(() {
      if (mounted) {
        setState(() {
          _text = _controller.value.toString();
          widget.onChanged(_controller.value);
        });
      }
    });
    _textController = TextEditingController(text: widget.controller?.value.toString());
  }

  @override
  void dispose() {
    _textController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _decrementValue() => setState(() {
        _controller.value = (_controller.value - widget.step).clamp(widget.minValue, widget.maxValue);
        _text = _controller.value.toString();
        widget.onChanged(_controller.value);
      });

  void _incrementValue() => setState(() {
        _controller.value = (_controller.value + widget.step).clamp(widget.minValue, widget.maxValue);
        _text = _controller.value.toString();
        widget.onChanged(_controller.value);
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
            onPressed: _controller.value != widget.minValue ? _decrementValue : null,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.add),
            onPressed: _controller.value != widget.maxValue ? _incrementValue : null,
          ),
        ),
        onChanged: (value) => setState(() {
          _controller.value = (int.tryParse(value) ?? widget.minValue).clamp(widget.minValue, widget.maxValue);
          _text = _controller.value.toString();
          widget.onChanged(_controller.value);
        }),
      );
}

class MNumberPickerController extends ChangeNotifier {
  MNumberPickerController({int? initialValue}) : _value = initialValue ?? 0;

  int _value;

  int get value => _value;

  set value(int value) {
    _value = value;
    notifyListeners();
  }
}
