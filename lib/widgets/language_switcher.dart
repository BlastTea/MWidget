part of 'widgets.dart';

/// A widget that provides a switcher for changing the language of the app.
class LanguageSwitcher extends StatelessWidget {
  /// Creates an instance of [LanguageSwitcher] with a dropdown button.
  ///
  /// The [key] parameter is inherited from [StatelessWidget].
  const LanguageSwitcher.dropdownButton({super.key}) : _isDropdownButton = true;

  /// Creates an instance of [LanguageSwitcher] with a list tile.
  ///
  /// The [key] parameter is inherited from [StatelessWidget].
  const LanguageSwitcher.listTile({super.key}) : _isDropdownButton = false;

  final bool _isDropdownButton;

  /// Handles the event when the language is changed.
  ///
  /// Updates the [Language] instance with the new language and saves it to
  /// [SharedPreferences] using the [keyLanguage] key.
  static Future<void> handleLanguageChanged(LanguageType? language) async {
    if (language != null) {
      Language.getInstance().languageType = language;
      await SharedPreferences.getInstance().then((value) => value.setString(keyLanguage, language.toFormattedString()));
    }
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Language.getInstance().languageTypeNotifier,
        builder: (context, languageType, child) => _isDropdownButton
            ? DropdownButton(
                value: languageType,
                items: availableLanguages
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.language),
                      ),
                    )
                    .toList(),
                onChanged: handleLanguageChanged,
              )
            : ValueListenableBuilder(
                valueListenable: Language.getInstance().languageNotifier,
                builder: (context, language, child) => ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(language['Language']!),
                  subtitle: Text(languageType.language),
                  onTap: () => NavigationHelper.to(
                    AdaptiveDialogRoute(
                      context: context,
                      builder: (context) => ChooseDialog(
                        data: () => availableLanguages
                            .map(
                              (e) => ChooseData(
                                value: e,
                                searchValue: e.language,
                                title: Text(e.language),
                                isSelected: languageType == e,
                              ),
                            )
                            .toList(),
                        title: Text(language['Choose language']!),
                        onDataEmpty: (retry) => RetryButton(
                          titleText: language['No data']!,
                          onRetryPressed: retry,
                        ),
                        onDataNotFound: Text(language['Data not found']!),
                        labelTextSearch: language['Search language']!,
                      ),
                    ),
                  ).then((value) => handleLanguageChanged(value)),
                ),
              ),
      );
}
