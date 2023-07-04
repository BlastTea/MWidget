part of 'extensions.dart';

extension TimeOfDayFromFormattedString on TimeOfDay {
  static TimeOfDay fromFormattedString(String formattedString) {
    List<String> formattedTexts = formattedString.split(':');

    int hour = int.tryParse(formattedTexts[0]) ?? 0;
    int minute = int.tryParse(formattedTexts[1]) ?? 0;

    return TimeOfDay(hour: hour, minute: minute);
  }
}

extension TimeOfDayToFormattedString on TimeOfDay {
  String toFormattedString({bool isPeriod = false}) {
    if (!isPeriod) {
      return '$hour:$minute';
    }

    String period = (hour < 12) ? 'AM' : 'PM';
    int hour12 = (hour > 12) ? hour - 12 : hour;

    return '$hour12:$minute $period';
  }
}
