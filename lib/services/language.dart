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
  Map<String, String?> _getValue() {
    if (onSetState != null) _data.addAll(onSetState!.call());
    return _data.map((key, value) => MapEntry(key, _formatValue(value[languageTypeNotifier.value])));
  }

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

  Map<String, String?> getData() => _getValue();

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

  String? getKey(String value) {
    for (MapEntry<String, Map<LanguageType, String>> dataEntry in _data.entries) {
      for (MapEntry<LanguageType, String> dataEntryValue in dataEntry.value.entries) {
        if (dataEntryValue.value == value) return dataEntry.key;
      }
    }

    return null;
  }

  static Map<String, Map<LanguageType, String>> Function()? onSetState;

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
    'Save': {
      LanguageType.unitedStatesEnglish: 'Save',
      LanguageType.indonesiaIndonesian: 'Simpan',
    },
    'Retry': {
      LanguageType.unitedStatesEnglish: 'Retry',
      LanguageType.indonesiaIndonesian: 'Coba lagi',
    },
    'An error occured!': {
      LanguageType.unitedStatesEnglish: 'An error occured!',
      LanguageType.indonesiaIndonesian: 'Terjadi error!',
    },
    'Error': {
      LanguageType.unitedStatesEnglish: 'Error',
      LanguageType.indonesiaIndonesian: 'Error',
    },
    'Warning': {
      LanguageType.unitedStatesEnglish: 'Warning',
      LanguageType.indonesiaIndonesian: 'Peringatan',
    },
    'Save changes?': {
      LanguageType.unitedStatesEnglish: 'Save changes?',
      LanguageType.indonesiaIndonesian: 'Simpan perubahan?',
    },
    'Don\'t save': {
      LanguageType.unitedStatesEnglish: 'Don\'t save',
      LanguageType.indonesiaIndonesian: 'Jangan simpan',
    },
    'Change logo': {
      LanguageType.unitedStatesEnglish: 'Change logo',
      LanguageType.indonesiaIndonesian: 'Ganti logo',
    },
    'Change theme': {
      LanguageType.unitedStatesEnglish: 'Change theme',
      LanguageType.indonesiaIndonesian: 'Ganti tema',
    },
    'Theme': {
      LanguageType.unitedStatesEnglish: 'Theme',
      LanguageType.indonesiaIndonesian: 'Tema',
    },
    'System': {
      LanguageType.unitedStatesEnglish: 'System',
      LanguageType.indonesiaIndonesian: 'Sistem',
    },
    'Dark': {
      LanguageType.unitedStatesEnglish: 'Dark',
      LanguageType.indonesiaIndonesian: 'Gelap',
    },
    'Light': {
      LanguageType.unitedStatesEnglish: 'Light',
      LanguageType.indonesiaIndonesian: 'Terang',
    },
    'Don\'t use dynamic colors': {
      LanguageType.unitedStatesEnglish: 'Don\'t use dynamic colors',
      LanguageType.indonesiaIndonesian: 'Jangan gunakan warna dinamis',
    },
    'Use dynamic colors': {
      LanguageType.unitedStatesEnglish: 'Use dynamic colors',
      LanguageType.indonesiaIndonesian: 'Gunakan warna dinamis',
    },
    'With custom colors': {
      LanguageType.unitedStatesEnglish: 'With custom colors',
      LanguageType.indonesiaIndonesian: 'Dengan warna khusus',
    },
    'Language': {
      LanguageType.unitedStatesEnglish: 'Language',
      LanguageType.indonesiaIndonesian: 'Bahasa',
    },
    'Choose language': {
      LanguageType.unitedStatesEnglish: 'Choose language',
      LanguageType.indonesiaIndonesian: 'Pilih bahasa',
    },
    'No data': {
      LanguageType.unitedStatesEnglish: 'No data',
      LanguageType.indonesiaIndonesian: 'Tidak ada data',
    },
    'Data not found': {
      LanguageType.unitedStatesEnglish: 'Data not found',
      LanguageType.indonesiaIndonesian: 'Data tidak ditemukan',
    },
    'Search language': {
      LanguageType.unitedStatesEnglish: 'Search language',
      LanguageType.indonesiaIndonesian: 'Cari bahasa',
    },
    'Information': {
      LanguageType.unitedStatesEnglish: 'Information',
      LanguageType.indonesiaIndonesian: 'Informasi',
    },
    'Yes': {
      LanguageType.unitedStatesEnglish: 'Yes',
      LanguageType.indonesiaIndonesian: 'Ya',
    },
    'No': {
      LanguageType.unitedStatesEnglish: 'No',
      LanguageType.indonesiaIndonesian: 'Tidak',
    },
    'Minimum {0} characters': {
      LanguageType.unitedStatesEnglish: 'Minimum {0} characters',
      LanguageType.indonesiaIndonesian: 'Minimal {0} karakter',
    },
    'Contains lowercase letters': {
      LanguageType.unitedStatesEnglish: 'Contains lowercase letters',
      LanguageType.indonesiaIndonesian: 'Berisi huruf kecil',
    },
    'Contains uppercase letters': {
      LanguageType.unitedStatesEnglish: 'Contains uppercase letters',
      LanguageType.indonesiaIndonesian: 'Berisi huruf besar',
    },
    'Contains numbers': {
      LanguageType.unitedStatesEnglish: 'Contains numbers',
      LanguageType.indonesiaIndonesian: 'Berisi angka',
    },
    'Contains special characters': {
      LanguageType.unitedStatesEnglish: 'Contains special characters',
      LanguageType.indonesiaIndonesian: 'Berisi karakter spesial',
    },
    'Password does not meet criteria': {
      LanguageType.unitedStatesEnglish: 'Password does not meet criteria',
      LanguageType.indonesiaIndonesian: 'Kata sandi tidak memenuhi kriteria',
    },
    'Continue': {
      LanguageType.unitedStatesEnglish: 'Continue',
      LanguageType.indonesiaIndonesian: 'Lanjutkan',
    },
    '{0}%': {
      LanguageType.unitedStatesEnglish: '{0}%',
      LanguageType.indonesiaIndonesian: '{0}%',
    },
    '{0} Seconds': {
      LanguageType.unitedStatesEnglish: '{0} Seconds',
      LanguageType.indonesiaIndonesian: '{0} Detik',
    },
  };
}
