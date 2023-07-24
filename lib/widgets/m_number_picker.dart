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
/// To control the numeric value of the picker externally, you can provide a [controller].
/// The [controller] can be used to manipulate the numeric value and listen to value changes.
/// If no controller is provided, a default controller will be created and used internally.
///
/// Example usage:
/// ```dart
/// // Create a controller with an initial value of 10
/// MNumberPickerController controller = MNumberPickerController(initialValue: 10);
///
/// // Use the MNumberPicker widget with the custom controller
/// MNumberPicker(
///   controller: controller,
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
  /// // Create a controller with an initial value of 10
  /// MNumberPickerController controller = MNumberPickerController(initialValue: 10);
  ///
  /// // Use the MNumberPicker widget with the custom controller
  /// MNumberPicker(
  ///   controller: controller,
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
  final void Function(int value) onChanged;

  @override
  State<MNumberPicker> createState() => _MNumberPickerState();
}

class _MNumberPickerState extends State<MNumberPicker> {
  final FocusNode _focusNodeTextField = FocusNode();
  late TextEditingController _textController;
  late int _previousValue;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.controller?.value ?? widget.minValue;
    final initialValue = widget.controller?.value ?? widget.minValue;
    _textController = TextEditingController(text: initialValue.toString());
    _textController.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleTextChange() {
    final selection = _textController.selection;
    final value = int.tryParse(_textController.text) ?? widget.minValue;
    final clampedValue = value.clamp(widget.minValue, widget.maxValue);
    if (widget.controller != null) {
      widget.controller!.value = clampedValue;
      widget.onChanged(widget.controller!.value);
    }

    if (_focusNodeTextField.hasFocus && _previousValue != clampedValue) {
      final int addedLength = clampedValue.toString().length - _textController.text.length;
      final updatedOffset = selection.baseOffset + addedLength;
      _textController.value = TextEditingValue(
        text: clampedValue.toString(),
        selection: TextSelection.collapsed(offset: updatedOffset),
      );
    }
    _previousValue = clampedValue;
  }

  void _decrementValue() {
    if (widget.controller != null) {
      final newValue = (widget.controller!.value - widget.step).clamp(widget.minValue, widget.maxValue);
      setState(() {
        widget.controller!.value = newValue;
        _textController.text = newValue.toString();
        final newCursorPos = _textController.text.length;
        _textController.selection = TextSelection.collapsed(offset: newCursorPos);
        widget.onChanged(widget.controller!.value);
      });
    } else {
      final currentValue = int.tryParse(_textController.text) ?? widget.minValue;
      final newValue = (currentValue - widget.step).clamp(widget.minValue, widget.maxValue);
      _updateTextField(newValue);
      widget.onChanged(newValue);
    }
  }

  void _incrementValue() {
    if (widget.controller != null) {
      final newValue = (widget.controller!.value + widget.step).clamp(widget.minValue, widget.maxValue);
      setState(() {
        widget.controller!.value = newValue;
        _textController.text = newValue.toString();
        final newCursorPos = _textController.text.length;
        _textController.selection = TextSelection.collapsed(offset: newCursorPos);
        widget.onChanged(widget.controller!.value);
      });
    } else {
      final currentValue = int.tryParse(_textController.text) ?? widget.minValue;
      final newValue = (currentValue + widget.step).clamp(widget.minValue, widget.maxValue);
      _updateTextField(newValue);
      widget.onChanged(newValue);
    }
  }

  void _updateTextField(int newValue) {
    final newCursorPos = newValue.toString().length;
    _textController.value = TextEditingValue(
      text: newValue.toString(),
      selection: TextSelection.collapsed(offset: newCursorPos),
    );
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
            onPressed: widget.controller?.value != widget.minValue ? _decrementValue : null,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.add),
            onPressed: widget.controller?.value != widget.maxValue ? _incrementValue : null,
          ),
        ),
        onChanged: (value) => _handleTextChange(),
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
/// // Create a controller with an initial value of 10
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
