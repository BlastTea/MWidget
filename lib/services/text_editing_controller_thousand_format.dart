part of 'services.dart';

class TextEditingControllerThousandFormat extends material.TextEditingController {
  TextEditingControllerThousandFormat({num? number}) {
    addListener(() {
      if (text.trim().isEmpty) {
        value = const material.TextEditingValue(
          text: '',
          selection: material.TextSelection.collapsed(
            offset: ''.length,
            affinity: material.TextAffinity.upstream,
          ),
          composing: material.TextRange.empty,
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

      formattedString = (double.tryParse(numString) ?? 0).toThousandFormat();

      formattedString += decimalPart;

      if (previousText != formattedString) {
        final newSelection = material.TextSelection.collapsed(
          offset: formattedString.length,
          affinity: material.TextAffinity.upstream,
        );

        value = material.TextEditingValue(
          text: formattedString,
          selection: newSelection,
          composing: material.TextRange.empty,
        );

        previousText = formattedString;
      }
    });

    if (number != null) {
      text = number.toString();
    }
  }

  String previousText = '';
}
