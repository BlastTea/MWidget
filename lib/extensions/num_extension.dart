part of 'extensions.dart';

extension NumExtension on num {
  String toThousandFormat({bool includeDecimalPart = true}) {
    String numString = toString();
    String formattedString = '';
    String decimalPart = '';

    if (numString.contains('.')) {
      int dotIndex = numString.indexOf('.');
      decimalPart = numString.substring(dotIndex);

      if (decimalPart.length > 1) {
        numString = numString.substring(0, dotIndex);
      } else {
        decimalPart = '';
      }
    }

    int count = 0;
    for (int i = numString.length - 1; i >= 0; i--) {
      formattedString = numString[i] + formattedString;
      count++;

      if (count % 3 == 0 && i != 0) {
        formattedString = ',$formattedString';
      }
    }

    if (!includeDecimalPart && int.tryParse(decimalPart.replaceAll('.', '')) == 0) {
      return formattedString;
    }

    return formattedString + decimalPart;
  }
}
