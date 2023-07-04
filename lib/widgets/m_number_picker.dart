part of 'widgets.dart';

class MNumberPicker extends StatefulWidget {
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
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _decrementValue() => setState(() {
        _value = (_value - widget.step).clamp(widget.minValue, widget.maxValue);
        widget.onChanged(_value);
      });

  void _incrementValue() => setState(() {
        _value = (_value + widget.step).clamp(widget.minValue, widget.maxValue);
        widget.onChanged(_value);
      });

  @override
  Widget build(BuildContext context) => TextField(
        controller: TextEditingControllerThousandFormat(
          number: _value,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [textFormatterDigitsOnly],
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).unselectedWidgetColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).unselectedWidgetColor,
            ),
          ),
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
          widget.onChanged(_value);
        }),
      );
}
