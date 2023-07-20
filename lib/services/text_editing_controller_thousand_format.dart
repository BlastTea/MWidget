part of 'services.dart';

class TextEditingControllerThousandFormat extends TextEditingController {
  TextEditingControllerThousandFormat({num? number}) {
    bool ignoreChanges = false;

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

      String numString = text.replaceAll(',', '');
      String formattedString = '';
      String decimalPart = '';

      if (numString.contains('.')) {
        int dotIndex = numString.indexOf('.');
        decimalPart = numString.substring(dotIndex);

        if (decimalPart.length > 1) {
          numString = numString.substring(0, dotIndex);
        } else {
          decimalPart = '.';
        }
      }

      formattedString = (double.tryParse(numString) ?? 0).toThousandFormat(includeDecimalPart: int.tryParse(decimalPart.replaceAll('.', '')) != 0);

      formattedString += decimalPart;

      if (_previousText != formattedString) {
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
    });

    if (number != null) {
      text = number.toString();
    }
  }

  String _previousText = '';
}
