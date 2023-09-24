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
  ///   - [language]: The [Language] to be used for formatting. If not provided, the language will be determined based on the default value.
  ///
  /// The date string is formatted based on the selected language (English or other). If the language is English,
  /// the time is displayed in 12-hour format with AM/PM. Otherwise, the time is displayed in 24-hour format.
  ///
  /// Example:
  ///   - `toFormattedDate(withWeekday: true, withMonthName: true, withHour: true)`: 'Wednesday, August 03, 2022, 02:30:15 PM'
  ///   - `toFormattedDate()`: '08/03/2022'
  String toFormattedDate({bool withYear = true, bool withWeekday = false, bool withMonthName = false, bool withHour = false, String dateHourSeparator = ',', Language? language}) {
    switch (language?.languageType ?? Language.getInstance().languageType) {
      case LanguageType.indonesiaIndonesian:
        return '${withWeekday ? '${getWeekday(language)}, ' : ''}${day.toString().padLeft(2, '0')} ${withMonthName ? getMonthName(language) : month.toString().padLeft(2, '0')}${withYear ? ' $year' : ''}${withHour ? '$dateHourSeparator ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}' : ''}';
      default:
        String period = (hour < 12) ? 'AM' : 'PM';
        int hour12 = (hour > 12) ? hour - 12 : hour;

        return '${withWeekday ? '${getWeekday(language)}, ' : ''}${withMonthName ? getMonthName(language) : month.toString().padLeft(2, '0')} ${day.toString().padLeft(2, '0')}${withYear ? ', $year' : ''}${withHour ? '$dateHourSeparator ${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')} $period' : ''}';
    }
  }

  /// Gets the localized weekday name for the [DateTime] object.
  ///
  /// The weekday name is retrieved based on the selected language (English or other).
  ///
  /// If the [language] parameter is provided, the weekday name will be retrieved based on that language.
  /// Otherwise, it will use the default language set in the `Language` class.
  ///
  /// Example:
  ///   - `getWeekday()`: 'Wednesday'
  ///   - `getWeekday(language)`: 'Rabu' (Indonesian)
  String getWeekday([Language? language]) {
    switch (weekday) {
      case DateTime.sunday:
        return language?.getValue('Sunday') ?? Language.getInstance().getValue('Sunday')!;
      case DateTime.monday:
        return language?.getValue('Monday') ?? Language.getInstance().getValue('Monday')!;
      case DateTime.tuesday:
        return language?.getValue('Tuesday') ?? Language.getInstance().getValue('Tuesday')!;
      case DateTime.wednesday:
        return language?.getValue('Wednesday') ?? Language.getInstance().getValue('Wednesday')!;
      case DateTime.thursday:
        return language?.getValue('Thursday') ?? Language.getInstance().getValue('Thursday')!;
      case DateTime.friday:
        return language?.getValue('Friday') ?? Language.getInstance().getValue('Friday')!;
      default:
        return language?.getValue('Saturday') ?? Language.getInstance().getValue('Saturday')!;
    }
  }

  /// Gets the localized month name for the [DateTime] object.
  ///
  /// The month name is retrieved based on the selected language (English or other).
  ///
  /// If the [language] parameter is provided, the month name will be retrieved based on that language.
  /// Otherwise, it will use the default language set in the `Language` class.
  ///
  /// Example:
  ///   - `getMonthName()`: 'August'
  ///   - `getMonthName(language)`: 'Agustus' (Indonesian)
  String getMonthName([Language? language]) {
    switch (month) {
      case DateTime.january:
        return language?.getValue('January') ?? Language.getInstance().getValue('January')!;
      case DateTime.february:
        return language?.getValue('February') ?? Language.getInstance().getValue('February')!;
      case DateTime.march:
        return language?.getValue('March') ?? Language.getInstance().getValue('March')!;
      case DateTime.april:
        return language?.getValue('April') ?? Language.getInstance().getValue('April')!;
      case DateTime.may:
        return language?.getValue('May') ?? Language.getInstance().getValue('May')!;
      case DateTime.june:
        return language?.getValue('June') ?? Language.getInstance().getValue('June')!;
      case DateTime.july:
        return language?.getValue('July') ?? Language.getInstance().getValue('July')!;
      case DateTime.august:
        return language?.getValue('August') ?? Language.getInstance().getValue('August')!;
      case DateTime.september:
        return language?.getValue('September') ?? Language.getInstance().getValue('September')!;
      case DateTime.october:
        return language?.getValue('October') ?? Language.getInstance().getValue('October')!;
      case DateTime.november:
        return language?.getValue('November') ?? Language.getInstance().getValue('November')!;
      default:
        return language?.getValue('December') ?? Language.getInstance().getValue('December')!;
    }
  }
}
