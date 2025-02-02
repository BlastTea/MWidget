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
  String toFormattedDate({
    bool withYear = true,
    bool withWeekday = false,
    bool withMonthName = false,
    bool withHour = false,
    bool withSeconds = true,
    String dateHourSeparator = ',',
    Locale? locale,
  }) {
    switch (locale ?? Get.locale?.languageCode ?? 'en') {
      case 'id':
        return '${withWeekday ? '${getWeekday()}, ' : ''}${day.toString().padLeft(2, '0')} ${withMonthName ? getMonthName() : month.toString().padLeft(2, '0')}${withYear ? ' $year' : ''}${withHour ? '$dateHourSeparator ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}${withSeconds ? ':${second.toString().padLeft(2, '0')}' : ''}' : ''}';
      default:
        String period = (hour < 12) ? 'AM' : 'PM';
        int hour12 = (hour > 12) ? hour - 12 : hour;

        return '${withWeekday ? '${getWeekday()}, ' : ''}${withMonthName ? getMonthName() : month.toString().padLeft(2, '0')} ${day.toString().padLeft(2, '0')}${withYear ? ', $year' : ''}${withHour ? '$dateHourSeparator ${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}${withSeconds ? ':${second.toString().padLeft(2, '0')} $period' : ''}' : ''}';
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
  String getWeekday() {
    // TODO : add locale
    switch (weekday) {
      case DateTime.sunday:
        return 'Sunday'.tr;
      case DateTime.monday:
        return 'Monday'.tr;
      case DateTime.tuesday:
        return 'Tuesday'.tr;
      case DateTime.wednesday:
        return 'Wednesday'.tr;
      case DateTime.thursday:
        return 'Thursday'.tr;
      case DateTime.friday:
        return 'Friday'.tr;
      default:
        return 'Saturday'.tr;
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
  String getMonthName() {
    // TODO : add locale
    switch (month) {
      case DateTime.january:
        return 'January'.tr;
      case DateTime.february:
        return 'February'.tr;
      case DateTime.march:
        return 'March'.tr;
      case DateTime.april:
        return 'April'.tr;
      case DateTime.may:
        return 'May'.tr;
      case DateTime.june:
        return 'June'.tr;
      case DateTime.july:
        return 'July'.tr;
      case DateTime.august:
        return 'August'.tr;
      case DateTime.september:
        return 'September'.tr;
      case DateTime.october:
        return 'October'.tr;
      case DateTime.november:
        return 'November'.tr;
      default:
        return 'December'.tr;
    }
  }
}
