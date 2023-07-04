part of 'enums.dart';

enum LanguageType {
  indonesian('id'),
  english('en');

  const LanguageType(this.id);
  final String id;

  factory LanguageType.fromId(String id) {
    switch (id) {
      case 'en':
        return english;
    }
    return indonesian;
  }

  String get title {
    switch (id) {
      case 'en':
        return 'English';
    }
    return 'Indonesia';
  }
}
