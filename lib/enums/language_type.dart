part of 'enums.dart';

/// An enumeration representing the available language types in the application.
enum LanguageType {
  /// Represents the Indonesian language with the identifier 'id'.
  indonesian('id'),

  /// Represents the English language with the identifier 'en'.
  english('en');

  const LanguageType(this.id);
  final String id;

  /// A factory constructor to create a [LanguageType] from the provided language identifier.
  ///
  /// The [id] parameter is the language identifier (e.g., 'id' for Indonesian, 'en' for English).
  /// If the provided identifier matches the identifier of any language type, the corresponding
  /// language type is returned. Otherwise, the default language type (English) is returned.
  ///
  /// Example:
  /// ```
  /// LanguageType language = LanguageType.fromId('id');
  /// print(language); // Output: LanguageType.indonesian
  /// ```
  factory LanguageType.fromId(String id) {
    switch (id) {
      case 'id':
        return indonesian;
    }
    return english;
  }

  /// A getter method to retrieve the title of the language associated with the language type.
  ///
  /// The [title] property returns the title of the language, which can be used for displaying
  /// the language name to the user.
  ///
  /// Example:
  /// ```
  /// LanguageType language = LanguageType.indonesian;
  /// print(language.title); // Output: 'Indonesia'
  /// ```
  String get title {
    switch (id) {
      case 'id':
        return 'Indonesia';
    }
    return 'English';
  }
}
