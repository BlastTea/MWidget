part of 'services.dart';

/// The `Language` class provides localization support for different languages in the application.
/// It allows switching between different languages and getting localized strings based on the selected language.
///
/// The class contains static methods and properties to handle language switching and localization.
class Language {
  /// A [ValueNotifier] that holds the currently selected [LanguageType].
  /// Listeners are notified whenever the language is changed.
  static ValueNotifier<LanguageType> languageTypeListenable = ValueNotifier(LanguageType.english)..addListener(() => languageListenable.value = _setValue());

  /// A [ValueNotifier] that holds a map of localized strings based on the selected [LanguageType].
  /// Listeners are notified whenever the language is changed or new data is added.
  static ValueNotifier<Map<String, String>> languageListenable = ValueNotifier(_setValue());

  /// A private method that generates a map of localized strings based on the selected language.
  static Map<String, String> _setValue() => _data.map((key, value) => MapEntry(key, value[languageTypeListenable.value]!));

  /// Returns the currently selected [LanguageType].
  static LanguageType get language => languageTypeListenable.value;

  /// Sets the selected [LanguageType].
  static set language(LanguageType value) => languageTypeListenable.value = value;

  /// Retrieves the localized string for the given [key] based on the selected language.
  ///
  /// Returns the localized string associated with the [key], or `null` if the [key] is not found.
  static String? getValue(String key) => _setValue()[key];

  /// Adds new localization data to the language map.
  ///
  /// The `data` parameter should be a map where the key is the localization key, and the value is
  /// another map that maps [LanguageType] to the localized string for that language.
  static void addData(Map<String, Map<LanguageType, String>> data) => _data.addAll(data);

  /// A map that holds the localization data for different strings.
  ///
  /// The keys of this map are the localization keys, and the values are nested maps.
  /// The nested maps associate each [LanguageType] with its localized string for that key.
  static final Map<String, Map<LanguageType, String>> _data = {
    'January': {
      LanguageType.english: 'January',
      LanguageType.indonesian: 'Januari',
    },
    'February': {
      LanguageType.english: 'February',
      LanguageType.indonesian: 'Februari',
    },
    'March': {
      LanguageType.english: 'March',
      LanguageType.indonesian: 'Maret',
    },
    'April': {
      LanguageType.english: 'April',
      LanguageType.indonesian: 'April',
    },
    'May': {
      LanguageType.english: 'May',
      LanguageType.indonesian: 'Mei',
    },
    'June': {
      LanguageType.english: 'June',
      LanguageType.indonesian: 'Juni',
    },
    'July': {
      LanguageType.english: 'July',
      LanguageType.indonesian: 'Juli',
    },
    'August': {
      LanguageType.english: 'August',
      LanguageType.indonesian: 'Agustus',
    },
    'September': {
      LanguageType.english: 'September',
      LanguageType.indonesian: 'September',
    },
    'October': {
      LanguageType.english: 'October',
      LanguageType.indonesian: 'Oktober',
    },
    'November': {
      LanguageType.english: 'November',
      LanguageType.indonesian: 'November',
    },
    'December': {
      LanguageType.english: 'December',
      LanguageType.indonesian: 'Desember',
    },
    'Sunday': {
      LanguageType.english: 'Sunday',
      LanguageType.indonesian: 'Minggu',
    },
    'Monday': {
      LanguageType.english: 'Monday',
      LanguageType.indonesian: 'Senin',
    },
    'Tuesday': {
      LanguageType.english: 'Tuesday',
      LanguageType.indonesian: 'Selasa',
    },
    'Wednesday': {
      LanguageType.english: 'Wednesday',
      LanguageType.indonesian: 'Rabu',
    },
    'Thursday': {
      LanguageType.english: 'Thursday',
      LanguageType.indonesian: 'Kamis',
    },
    'Friday': {
      LanguageType.english: 'Friday',
      LanguageType.indonesian: 'Jum\'at',
    },
    'Saturday': {
      LanguageType.english: 'Saturday',
      LanguageType.indonesian: 'Sabtu',
    },
    'Ok': {
      LanguageType.english: 'Ok',
      LanguageType.indonesian: 'Ok',
    },
    'Cancel': {
      LanguageType.english: 'Cancel',
      LanguageType.indonesian: 'Batal',
    },
    'Gallery': {
      LanguageType.english: 'Gallery',
      LanguageType.indonesian: 'Galeri',
    },
    'Camera': {
      LanguageType.english: 'Camera',
      LanguageType.indonesian: 'Kamera',
    },
    'Delete': {
      LanguageType.english: 'Delete',
      LanguageType.indonesian: 'Hapus',
    },
  };
}
