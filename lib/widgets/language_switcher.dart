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
  static Future<void> handleLanguageChanged(Locale? locale) async {
    if (locale != null) {
      await Get.updateLocale(locale);
      await SharedPreferences.getInstance().then((value) => value.setString(keyLocale, '${locale.languageCode}_${locale.countryCode}'));
    }
  }

  @override
  Widget build(BuildContext context) => _isDropdownButton
      ? DropdownButton(
          value: Get.locale,
          items: MWidget.availableLanguages
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.displayName ?? '?'),
                ),
              )
              .toList(),
          onChanged: handleLanguageChanged,
        )
      : ListTile(
          leading: const Icon(Icons.language),
          title: Text('Language'.tr),
          subtitle: Text(Get.locale?.displayName ?? ''),
          onTap: () => navigator!
              .push(
                AdaptiveDialogRoute(
                  builder: (context) => ChooseDialog(
                    data: () => MWidget.availableLanguages
                        .map(
                          (e) => ChooseData(
                            value: e,
                            searchValue: e.displayName,
                            title: Text(e.displayName ?? ''),
                            isSelected: Get.locale == e,
                          ),
                        )
                        .toList(),
                    title: Text('Choose language'.tr),
                    onDataEmpty: (retry) => RetryButton(
                      titleText: 'No data'.tr,
                      onRetryPressed: retry,
                    ),
                    onDataNotFound: Text('Data not found'.tr),
                    labelTextSearch: 'Search language'.tr,
                  ),
                ),
              )
              .then((value) => handleLanguageChanged(value)),
        );
}
