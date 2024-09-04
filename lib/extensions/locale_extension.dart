part of 'extensions.dart';

extension LocaleExtension on Locale {
  String? get displayName => switch (languageCode) {
        'en' => 'English',
        'id' => 'Bahasa Indonesia',
        _ => null,
      };
}
