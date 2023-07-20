part of 'extensions.dart';

/// An extension on the [TimeOfDay] class that provides additional utility methods
/// to convert [TimeOfDay] objects from and to formatted strings.
extension TimeOfDayExtension on TimeOfDay {
  /// Creates a [TimeOfDay] instance from a formatted string.
  ///
  /// The [formattedString] parameter should be in the format 'HH:mm', where 'HH' represents
  /// the hour (0-23) and 'mm' represents the minute (0-59).
  ///
  /// If the formatted string is invalid or does not match the format, default values of 0 for hour and minute are used.
  /// If any part of the formatted string cannot be parsed into an integer, it is treated as 0.
  static TimeOfDay fromFormattedString(String formattedString) {
    List<String> formattedTexts = formattedString.split(':');

    int hour = int.tryParse(formattedTexts[0]) ?? 0;
    int minute = int.tryParse(formattedTexts[1]) ?? 0;

    return TimeOfDay(hour: hour, minute: minute);
  }

  /// Converts the [TimeOfDay] object to a formatted string.
  ///
  /// The optional [isPeriod] parameter determines whether to include the period (AM/PM) in the formatted string.
  /// By default, the period is not included.
  ///
  /// If [isPeriod] is true, the formatted string will have the hour in 12-hour format (1-12) along with the period (AM/PM).
  /// If [isPeriod] is false, the formatted string will have the hour in 24-hour format (00-23).
  /// In both cases, the minute will be represented as two digits (00-59).
  ///
  /// Example:
  ///   - `toFormattedString()`: '14:30'
  ///   - `toFormattedString(isPeriod: true)`: '02:30 PM'
  String toFormattedString({bool isPeriod = false}) {
    if (!isPeriod) {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }

    String period = (hour < 12) ? 'AM' : 'PM';
    int hour12 = (hour > 12) ? hour - 12 : hour;

    return '${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }
}
