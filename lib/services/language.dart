part of 'services.dart';

/// The `Language` class provides localization support for different languages in the application.
/// It allows switching between different languages and getting localized strings based on the selected language.
///
/// The class contains static methods and properties to handle language switching and localization.
abstract class Language {
  /// A [ValueNotifier] that holds the currently selected [LanguageType].
  /// Listeners are notified whenever the language is changed.
  static ValueNotifier<LanguageType> languageTypeNotifier = ValueNotifier(LanguageType.unitedStatesEnglish)..addListener(() => languageNotifier.value = _getValue());

  /// Returns the currently selected [LanguageType].
  static LanguageType get language => languageTypeNotifier.value;

  /// Sets the selected [LanguageType].
  static set language(LanguageType value) => languageTypeNotifier.value = value;

  /// A [ValueNotifier] that holds a map of localized strings based on the selected [LanguageType].
  /// Listeners are notified whenever the language is changed or new data is added.
  static ValueNotifier<Map<String, String?>> languageNotifier = ValueNotifier(_getValue());

  /// A private method that generates a map of localized strings based on the selected language.
  static Map<String, String?> _getValue() => _data.map((key, value) => MapEntry(key, _formatValue(value[languageTypeNotifier.value])));

  /// A private method that formats the [value] with the provided [arguments].
  ///
  /// The [arguments] parameter should be a list of dynamic values that replace placeholders
  /// `{0}`, `{1}`, etc., in the [value].
  ///
  /// Returns the formatted string, or `null` if the [value] is `null`.
  static String? _formatValue(String? value, [List<dynamic> arguments = const []]) {
    if (value == null) {
      return null;
    }
    var formattedValue = value;
    for (var i = 0; i < arguments.length; i++) {
      formattedValue = formattedValue.replaceAll('{$i}', '${arguments[i]}');
    }
    return formattedValue;
  }

  /// Retrieves the localized string for the given [key] based on the selected language.
  ///
  /// If [arguments] are provided, the localized string is formatted using the provided arguments.
  /// The [arguments] parameter should be a list of dynamic values that replace placeholders
  /// `{0}`, `{1}`, etc., in the localized string.
  ///
  /// Returns the localized string associated with the [key], or `null` if the [key] is not found.
  ///
  /// Example:
  /// ```
  /// String? greeting = Language.getValue('greeting', ['John']);
  /// print(greeting); // Output: 'Hello, John!'
  /// ```
  static String? getValue(String key, [List<dynamic>? arguments]) {
    final localizedValue = _getValue()[key];
    if (localizedValue != null && arguments != null) {
      return _formatValue(localizedValue, arguments);
    }
    return localizedValue;
  }

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
      LanguageType.unitedStatesEnglish: 'January',
      LanguageType.indonesiaIndonesian: 'Januari',
    },
    'February': {
      LanguageType.unitedStatesEnglish: 'February',
      LanguageType.indonesiaIndonesian: 'Februari',
    },
    'March': {
      LanguageType.unitedStatesEnglish: 'March',
      LanguageType.indonesiaIndonesian: 'Maret',
    },
    'April': {
      LanguageType.unitedStatesEnglish: 'April',
      LanguageType.indonesiaIndonesian: 'April',
    },
    'May': {
      LanguageType.unitedStatesEnglish: 'May',
      LanguageType.indonesiaIndonesian: 'Mei',
    },
    'June': {
      LanguageType.unitedStatesEnglish: 'June',
      LanguageType.indonesiaIndonesian: 'Juni',
    },
    'July': {
      LanguageType.unitedStatesEnglish: 'July',
      LanguageType.indonesiaIndonesian: 'Juli',
    },
    'August': {
      LanguageType.unitedStatesEnglish: 'August',
      LanguageType.indonesiaIndonesian: 'Agustus',
    },
    'September': {
      LanguageType.unitedStatesEnglish: 'September',
      LanguageType.indonesiaIndonesian: 'September',
    },
    'October': {
      LanguageType.unitedStatesEnglish: 'October',
      LanguageType.indonesiaIndonesian: 'Oktober',
    },
    'November': {
      LanguageType.unitedStatesEnglish: 'November',
      LanguageType.indonesiaIndonesian: 'November',
    },
    'December': {
      LanguageType.unitedStatesEnglish: 'December',
      LanguageType.indonesiaIndonesian: 'Desember',
    },
    'Sunday': {
      LanguageType.unitedStatesEnglish: 'Sunday',
      LanguageType.indonesiaIndonesian: 'Minggu',
    },
    'Monday': {
      LanguageType.unitedStatesEnglish: 'Monday',
      LanguageType.indonesiaIndonesian: 'Senin',
    },
    'Tuesday': {
      LanguageType.unitedStatesEnglish: 'Tuesday',
      LanguageType.indonesiaIndonesian: 'Selasa',
    },
    'Wednesday': {
      LanguageType.unitedStatesEnglish: 'Wednesday',
      LanguageType.indonesiaIndonesian: 'Rabu',
    },
    'Thursday': {
      LanguageType.unitedStatesEnglish: 'Thursday',
      LanguageType.indonesiaIndonesian: 'Kamis',
    },
    'Friday': {
      LanguageType.unitedStatesEnglish: 'Friday',
      LanguageType.indonesiaIndonesian: 'Jum\'at',
    },
    'Saturday': {
      LanguageType.unitedStatesEnglish: 'Saturday',
      LanguageType.indonesiaIndonesian: 'Sabtu',
    },
    'Ok': {
      LanguageType.unitedStatesEnglish: 'Ok',
      LanguageType.indonesiaIndonesian: 'Ok',
    },
    'Cancel': {
      LanguageType.unitedStatesEnglish: 'Cancel',
      LanguageType.indonesiaIndonesian: 'Batal',
    },
    'Gallery': {
      LanguageType.unitedStatesEnglish: 'Gallery',
      LanguageType.indonesiaIndonesian: 'Galeri',
    },
    'Camera': {
      LanguageType.unitedStatesEnglish: 'Camera',
      LanguageType.indonesiaIndonesian: 'Kamera',
    },
    'Delete': {
      LanguageType.unitedStatesEnglish: 'Delete',
      LanguageType.indonesiaIndonesian: 'Hapus',
    },
  };
}
