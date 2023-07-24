part of 'widgets.dart';

/// A customizable number picker widget that allows users to input a numeric value within a specific range.
///
/// The `MNumberPicker` widget provides a text input field with increment and decrement buttons
/// to adjust the numeric value within the specified [minValue] and [maxValue] range.
///
/// The user can adjust the value using the increment and decrement buttons
/// or by directly typing a numeric value in the text input field. The value is clamped to the specified [minValue] and [maxValue].
///
/// The [step] parameter determines the amount to increment or decrement the value when using the buttons (default is 1).
///
/// When the numeric value changes, the [onChanged] callback is called with the updated value.
///
/// Example usage:
/// ```dart
/// MNumberPicker(
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
  /// The [controller] parameter can be used to control the numeric value of the picker externally.
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

  /// The controller for the number picker.
  ///
  /// The controller can be used to manipulate the numeric value externally and listen to value changes.
  /// If no controller is provided, a default controller will be created and used internally.
  final MNumberPickerController? controller;

  /// The minimum value that the number picker can take.
  final int minValue;

  /// The maximum value that the number picker can take.
  final int maxValue;

  /// The amount to increment or decrement the value when using the buttons (default is 1).
  final int step;

  /// Callback that is called when the numeric value changes.
  ///
  /// This function will be called with the updated numeric [value].
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
    _textController = TextEditingController(text: _controller.value.toString());
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

/// A controller class for managing the numeric value of the [MNumberPicker] widget.
///
/// The [tag] parameter can be used to associate a tag or identifier with this controller.
/// It can be helpful when managing multiple number pickers with different controllers.
///
/// The [initialValue] parameter sets the initial numeric value of the controller.
/// If not provided, the default initial value is 0.
///
/// Example usage:
/// ```dart
/// MNumberPickerController controller = MNumberPickerController(initialValue: 10);
///
/// // Retrieve the current value
/// int currentValue = controller.value;
///
/// // Change the value and notify listeners
/// controller.value = 20;
/// ```
class MNumberPickerController extends ChangeNotifier {
  MNumberPickerController({
    this.tag,
    int? initialValue,
  }) : _value = initialValue ?? 0;

  /// An optional tag or identifier associated with this controller.
  /// It can be used to distinguish different controllers if managing multiple number pickers.
  Object? tag;

  /// The internal value managed by this controller.
  int _value;

  /// Retrieves the current numeric value from the controller.
  int get value => _value;

  /// Sets the numeric [value] for the controller and notifies listeners about the change.
  set value(int value) {
    _value = value;
    notifyListeners();
  }
}
