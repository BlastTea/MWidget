part of 'extensions.dart';

extension DurationExtension on Duration {
  //TODO: maybe add a params for hour, days, month, etc.
  String toFormattedString() => '${(inSeconds ~/ 60).toString().padLeft(2, '0')}:${(inSeconds % 60).toString().padLeft(2, '0')}';
}
