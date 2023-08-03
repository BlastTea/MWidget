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
  ///   - [languageType]: The [LanguageType] to be used for formatting. If not provided, the language type will be determined based on the selected language.
  ///
  /// The date string is formatted based on the selected language (English or other). If the language is English,
  /// the time is displayed in 12-hour format with AM/PM. Otherwise, the time is displayed in 24-hour format.
  ///
  /// Example:
  ///   - `toFormattedDate(withWeekday: true, withMonthName: true, withHour: true)`: 'Wednesday, August 03, 2022, 02:30:15 PM'
  ///   - `toFormattedDate()`: '08/03/2022'
  String toFormattedDate({bool withWeekday = false, bool withMonthName = false, bool withHour = false, LanguageType? languageType}) {
    switch (languageType ?? Language.getInstance().languageType) {
      case LanguageType.indonesiaIndonesian:
        return '${withWeekday ? '${getWeekday()}, ' : ''}${day.toString().padLeft(2, '0')} ${withMonthName ? getMonthName() : month.toString().padLeft(2, '0')} $year${withHour ? ', ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}' : ''}';
      default:
        String period = (hour < 12) ? 'AM' : 'PM';
        int hour12 = (hour > 12) ? hour - 12 : hour;

        return '${withWeekday ? '${getWeekday()}, ' : ''}${withMonthName ? getMonthName() : month.toString().padLeft(2, '0')} ${day.toString().padLeft(2, '0')}, $year${withHour ? ', ${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')} $period' : ''}';
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
        return Language.getInstance().getValue('Sunday')!;
      case DateTime.monday:
        return Language.getInstance().getValue('Monday')!;
      case DateTime.tuesday:
        return Language.getInstance().getValue('Tuesday')!;
      case DateTime.wednesday:
        return Language.getInstance().getValue('Wednesday')!;
      case DateTime.thursday:
        return Language.getInstance().getValue('Thursday')!;
      case DateTime.friday:
        return Language.getInstance().getValue('Friday')!;
      default:
        return Language.getInstance().getValue('Saturday')!;
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
        return Language.getInstance().getValue('January')!;
      case DateTime.february:
        return Language.getInstance().getValue('February')!;
      case DateTime.march:
        return Language.getInstance().getValue('March')!;
      case DateTime.april:
        return Language.getInstance().getValue('April')!;
      case DateTime.may:
        return Language.getInstance().getValue('May')!;
      case DateTime.june:
        return Language.getInstance().getValue('June')!;
      case DateTime.july:
        return Language.getInstance().getValue('July')!;
      case DateTime.august:
        return Language.getInstance().getValue('August')!;
      case DateTime.september:
        return Language.getInstance().getValue('September')!;
      case DateTime.october:
        return Language.getInstance().getValue('October')!;
      case DateTime.november:
        return Language.getInstance().getValue('November')!;
      default:
        return Language.getInstance().getValue('December')!;
    }
  }
}
