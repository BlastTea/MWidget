part of 'widgets.dart';

/// A widget that provides a switcher for toggling between light and dark themes.
class ThemeSwitcher extends StatelessWidget {
  /// Creates an instance of [ThemeSwitcher] with an icon button.
  ///
  /// The [key] parameter is inherited from [StatelessWidget].
  const ThemeSwitcher.iconButton({super.key}) : _isIconButton = true;

  /// Creates an instance of [ThemeSwitcher] with a list tile.
  ///
  /// The [key] parameter is inherited from [StatelessWidget].
  const ThemeSwitcher.listTile({super.key}) : _isIconButton = false;

  final bool _isIconButton;

  /// Handles the event when the theme is changed.
  ///
  /// Determines the current theme brightness and updates the theme accordingly
  /// using [SharedPreferences] and [themeNotifier].
  Future<void> _handleThemeChanged() async {
    Brightness brightness = Theme.of(navigatorKey.currentContext!).brightness;

    if (brightness == Brightness.dark) {
      await SharedPreferences.getInstance().then((value) => value.setString(keyThemeMode, ThemeMode.light.toString()));
      themeNotifier.value = ThemeMode.light;
    } else {
      await SharedPreferences.getInstance().then((value) => value.setString(keyThemeMode, ThemeMode.dark.toString()));
      themeNotifier.value = ThemeMode.dark;
    }
  }

  /// Returns the icon data based on the specified [themeMode].
  ///
  /// If [themeMode] is light, returns [Icons.light_mode]; otherwise, returns [Icons.dark_mode].
  IconData _getIconData({required ThemeMode themeMode}) => themeMode == ThemeMode.light ? Icons.light_mode : Icons.dark_mode;

  /// Builds the icon button with theme switch animation.
  ///
  /// This widget displays an animated switcher with an icon button that triggers
  /// the [_handleThemeChanged] function on press.
  Widget _iconButton({required Map<String, String?> language, required ThemeMode themeMode}) => AnimatedSwitcher(
        duration: const Duration(milliseconds: kDurationLong4),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: RotationTransition(
              turns: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
        ),
        child: IconButton(
          key: ValueKey(themeMode),
          onPressed: _handleThemeChanged,
          icon: Icon(_getIconData(themeMode: themeMode)),
          tooltip: language['Change theme']!,
        ),
      );

  /// Builds the list tile for theme switching.
  ///
  /// This widget displays a list tile with an icon and texts for the current theme,
  /// allowing the user to tap and switch the theme.
  Widget _listTile({required Map<String, String?> language, required ThemeMode themeMode}) => ListTile(
        leading: Icon(_getIconData(themeMode: themeMode)),
        title: Text(language['Theme']!),
        subtitle: Text(language[themeMode == ThemeMode.light ? 'Light' : 'Dark']!),
        onTap: _handleThemeChanged,
      );

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Language.getInstance().languageNotifier,
        builder: (context, language, child) => ValueListenableBuilder(
          valueListenable: themeNotifier,
          builder: (context, themeMode, child) => _isIconButton
              ? _iconButton(
                  language: language,
                  themeMode: themeMode,
                )
              : _listTile(
                  language: language,
                  themeMode: themeMode,
                ),
        ),
      );
}
