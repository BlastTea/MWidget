part of 'extensions.dart';

extension DateTimeExtension on DateTime {
  // ignore: unused_element
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
