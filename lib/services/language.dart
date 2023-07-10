part of 'services.dart';

class Language {
  static ValueNotifier<LanguageType> languageTypeListenable = ValueNotifier(LanguageType.english)..addListener(() => languageListenable.value = _setValue());

  static ValueNotifier<Map<String, String>> languageListenable = ValueNotifier(_setValue());

  static Map<String, String> _setValue() => _data.map((key, value) => MapEntry(key, value[languageTypeListenable.value]!));

  static LanguageType get language => languageTypeListenable.value;

  static set language(LanguageType value) => languageTypeListenable.value = value;

  static String? getValue(String key) => _setValue()[key];

  static void addData(Map<String, Map<LanguageType, String>> data) => _data.addAll(data);

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
