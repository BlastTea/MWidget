part of 'extensions.dart';

extension TimeOfDayExtension on TimeOfDay {
  static TimeOfDay fromFormattedString(String formattedString) {
    List<String> formattedTexts = formattedString.split(':');

    int hour = int.tryParse(formattedTexts[0]) ?? 0;
    int minute = int.tryParse(formattedTexts[1]) ?? 0;

    return TimeOfDay(hour: hour, minute: minute);
  }

  String toFormattedString({bool isPeriod = false}) {
    if (!isPeriod) {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }

    String period = (hour < 12) ? 'AM' : 'PM';
    int hour12 = (hour > 12) ? hour - 12 : hour;

    return '${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }
}
