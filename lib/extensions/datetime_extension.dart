part of 'extensions.dart';

/// An extension on the [DateTime] class that provides additional utility methods
/// for formatting dates based on the selected language.
extension DateTimeExtension on DateTime {
  /// Converts the [DateTime] object to a formatted date string.
  ///
  /// The optional parameters allow customizing the formatting of the date string:
  ///   - [withWeekday]: Whether to include the weekday name in the date string. Default is `false`.
  ///   - [withMonthName]: Whether to include the month name in the date string. Default is `false`.
  ///   - [withHour]: Whether to include the time (hour, minute, and second) in 12-hour format along with AM/PM. Default is `false`.
  ///
  /// The date string is formatted based on the selected language (English or other). If the language is English,
  /// the time is displayed in 12-hour format with AM/PM. Otherwise, the time is displayed in 24-hour format.
  ///
  /// Example:
  ///   - `toFormattedDate(withWeekday: true, withMonthName: true, withHour: true)`: 'Wednesday, August 03, 2022, 02:30:15 PM'
  ///   - `toFormattedDate()`: '08/03/2022'
  String toFormattedDate({bool withWeekday = false, bool withMonthName = false, bool withHour = false}) {
    switch (Language.language) {
      case LanguageType.english:
        String period = (hour < 12) ? 'AM' : 'PM';
        int hour12 = (hour > 12) ? hour - 12 : hour;

        return '${withWeekday ? '${getWeekday()}, ' : ''}${withMonthName ? getMonthName() : month.toString().padLeft(2, '0')} ${day.toString().padLeft(2, '0')}, $year${withHour ? ', ${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')} $period' : ''}';
      default:
        return '${withWeekday ? '${getWeekday()}, ' : ''}${day.toString().padLeft(2, '0')} ${withMonthName ? getMonthName() : month.toString().padLeft(2, '0')} $year${withHour ? ', ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}' : ''}';
    }
  }

  /// Gets the localized weekday name for the [DateTime] object.
  ///
  /// The weekday name is retrieved based on the selected language (English or other).
  ///
  /// Example:
  ///   - `getWeekday()`: 'Wednesday'
  String getWeekday() {
    switch (weekday) {
      case DateTime.sunday:
        return Language.getValue('Sunday')!;
      case DateTime.monday:
        return Language.getValue('Monday')!;
      case DateTime.tuesday:
        return Language.getValue('Tuesday')!;
      case DateTime.wednesday:
        return Language.getValue('Wednesday')!;
      case DateTime.thursday:
        return Language.getValue('Thursday')!;
      case DateTime.friday:
        return Language.getValue('Friday')!;
      default:
        return Language.getValue('Saturday')!;
    }
  }

  /// Gets the localized month name for the [DateTime] object.
  ///
  /// The month name is retrieved based on the selected language (English or other).
  ///
  /// Example:
  ///   - `getMonthName()`: 'August'
  String getMonthName() {
    switch (month) {
      case DateTime.january:
        return Language.getValue('January')!;
      case DateTime.february:
        return Language.getValue('February')!;
      case DateTime.march:
        return Language.getValue('March')!;
      case DateTime.april:
        return Language.getValue('April')!;
      case DateTime.may:
        return Language.getValue('May')!;
      case DateTime.june:
        return Language.getValue('June')!;
      case DateTime.july:
        return Language.getValue('July')!;
      case DateTime.august:
        return Language.getValue('August')!;
      case DateTime.september:
        return Language.getValue('September')!;
      case DateTime.october:
        return Language.getValue('October')!;
      case DateTime.november:
        return Language.getValue('November')!;
      default:
        return Language.getValue('December')!;
    }
  }
}
