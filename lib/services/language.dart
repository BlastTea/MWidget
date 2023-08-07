part of 'services.dart';

/// The `Language` class provides localization support for different languages in the application.
/// It allows switching between different languages and getting localized strings based on the selected language.
///
/// The class contains methods and properties to handle language switching and localization.
final class Language {
  Language._internal(this.name) {
    languageNotifier = ValueNotifier(_getValue());
  }

  /// Initializes a new instance of the `Language` class with the given [name].
  ///
  /// If [name] is not provided, the default language will be set.
  factory Language.initialize({String? name}) {
    Language newInstance = Language._internal(name ?? 'default');

    _instances.addAll({name ?? 'default': newInstance});

    return _instances[name ?? 'default']!;
  }

  /// Gets the existing instance of the `Language` class with the given [name].
  ///
  /// If [name] is not provided, the default instance will be returned.
  static Language getInstance({String? name}) => _instances[name ?? 'default']!;

  static final Map<String, Language> _instances = {};

  /// The name of the current language.
  final String name;

  /// A [ValueNotifier] that holds the currently selected [LanguageType].
  /// Listeners are notified whenever the language is changed.
  ValueNotifier<LanguageType> languageTypeNotifier = ValueNotifier(LanguageType.unitedStatesEnglish);

  /// Returns the currently selected [LanguageType].
  LanguageType get languageType => languageTypeNotifier.value;

  /// Sets the selected [LanguageType].
  set languageType(LanguageType value) {
    languageTypeNotifier.value = value;
    languageNotifier.value = _getValue();
  }

  /// A [ValueNotifier] that holds a map of localized strings based on the selected [LanguageType].
  /// Listeners are notified whenever the language is changed or new data is added.
  late ValueNotifier<Map<String, String?>> languageNotifier;

  /// A private method that generates a map of localized strings based on the selected language.
  Map<String, String?> _getValue() => _data.map((key, value) => MapEntry(key, _formatValue(value[languageTypeNotifier.value])));

  /// A private method that formats the [value] with the provided [arguments].
  ///
  /// The [arguments] parameter should be a list of dynamic values that replace placeholders
  /// `{0}`, `{1}`, etc., in the [value].
  ///
  /// Returns the formatted string, or `null` if the [value] is `null`.
  String? _formatValue(String? value, [List<dynamic> arguments = const []]) {
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
  /// Language.getInstance().addData(
  ///   {
  ///     'greeting': {
  ///       LanguageType.unitedStatesEnglish: 'Hello, {0}'
  ///     }
  ///   },
  /// );
  ///
  /// String? greeting = Language.getInstance().getValue('greeting', ['John']);
  /// print(greeting); // Output: 'Hello, John!'
  /// ```
  String? getValue(String key, [List<dynamic>? arguments]) {
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
    'File': {
      LanguageType.unitedStatesEnglish: 'File',
      LanguageType.indonesiaIndonesian: 'File',
    },
  };
}
