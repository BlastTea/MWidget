part of 'widgets.dart';

/// A widget that provides a switcher for toggling between light and dark themes.
class ThemeSwitcher extends StatelessWidget {
  /// Creates an instance of [ThemeSwitcher] with an icon button.
  ///
  /// The [key] parameter is inherited from [StatelessWidget].
  const ThemeSwitcher.iconButton({
    super.key,
    this.showDynamicColorOptions = true,
  }) : _isIconButton = true;

  /// Creates an instance of [ThemeSwitcher] with a list tile.
  ///
  /// The [key] parameter is inherited from [StatelessWidget].
  const ThemeSwitcher.listTile({
    super.key,
    this.showDynamicColorOptions = true,
  }) : _isIconButton = false;

  final bool _isIconButton;
  final bool showDynamicColorOptions;

  /// Handles the event when the theme is changed.
  ///
  /// Determines the current theme brightness and updates the theme accordingly
  /// using [SharedPreferences] and [themeNotifier].
  Future<void> _handleThemeChanged() async {
    ThemeValue? themeValue = await NavigationHelper.to(
      AdaptiveDialogRoute(
        builder: (context) {
          ThemeValue currentValue = MWidget.themeValue.copyWith();
          currentValue.color ??= Colors.red;

          return ValueListenableBuilder(
            valueListenable: Language.getInstance().languageNotifier,
            builder: (context, language, child) => ValueListenableBuilder(
              valueListenable: currentValue,
              builder: (context, themeValue, child) {
                return AdaptiveFullScreenDialog(
                  title: Text(language['Change theme']!),
                  body: _themeChangeBody(themeValue: currentValue, language: language),
                  dialogBody: SizedBox(
                    width: kCompactSize,
                    height: kCompactSize,
                    child: _themeChangeBody(themeValue: currentValue, language: language),
                  ),
                  fullScreenFab: FloatingActionButton(
                    onPressed: () => NavigationHelper.back(currentValue),
                    child: const Icon(Icons.done),
                  ),
                  dialogActions: [
                    TextButton(
                      onPressed: () => NavigationHelper.back(),
                      child: Text(language['Cancel']!),
                    ),
                    TextButton(
                      onPressed: () => NavigationHelper.back(currentValue),
                      child: Text(language['Ok']!),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );

    if (themeValue == null) return;

    if (themeValue.useDynamicColors && !themeValue.withCustomColors && themeValue.color != null) {
      themeValue.color = null;
    } else if (!themeValue.useDynamicColors) {
      themeValue.withCustomColors = false;
      themeValue.color = null;
    }

    MWidget.themeValue.value = themeValue;
    await MWidget.themeValue.saveToSharedPreferences();

    // Brightness brightness = Theme.of(navigatorKey.currentContext!).brightness;

    // if (brightness == Brightness.dark) {
    //   await SharedPreferences.getInstance().then((value) => value.setString(keyThemeMode, ThemeMode.light.toString()));
    //   themeNotifier.value = ThemeMode.light;
    // } else {
    //   await SharedPreferences.getInstance().then((value) => value.setString(keyThemeMode, ThemeMode.dark.toString()));
    //   themeNotifier.value = ThemeMode.dark;
    // }
  }

  Widget _themeChangeBody({required ThemeValue themeValue, required Map<String, String?> language}) => ListView(
        children: [
          ...List.generate(
            3,
            (index) => RadioListTile<ThemeMode>(
              value: const [ThemeMode.system, ThemeMode.light, ThemeMode.dark][index],
              groupValue: themeValue.themeMode,
              onChanged: (value) => themeValue.themeMode = value!,
              title: Text(language[['System', 'Light', 'Dark'][index]]!),
            ),
          ),
          if (showDynamicColorOptions) ...[
            const Divider(),
            ...List.generate(
              2,
              (index) => RadioListTile<bool>(
                value: const [false, true][index],
                groupValue: themeValue.useDynamicColors,
                onChanged: (value) => themeValue.useDynamicColors = value!,
                title: Text(language[['Don\'t use dynamic colors', 'Use dynamic colors'][index]]!),
              ),
            ),
            SwitchListTile(
              value: themeValue.withCustomColors,
              onChanged: themeValue.value.useDynamicColors ? (value) => themeValue.withCustomColors = value : null,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(language['With custom colors']!),
            ),
            if (themeValue.useDynamicColors && themeValue.withCustomColors)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ColorPicker(
                  pickerColor: themeValue.color!,
                  onColorChanged: (value) => themeValue.color = value,
                  colorPickerWidth: kCompactSize - 372.0,
                  enableAlpha: false,
                  paletteType: PaletteType.hueWheel,
                  labelTypes: const [ColorLabelType.rgb],
                ),
              ),
          ]
        ],
      );

  /// Returns the icon data based on the specified [themeMode].
  ///
  /// If [themeMode] is light, returns [Icons.light_mode]; otherwise, returns [Icons.dark_mode].
  IconData _getIconData({required Brightness brightness}) => brightness == Brightness.light ? Icons.light_mode : Icons.dark_mode;

  /// Builds the icon button with theme switch animation.
  ///
  /// This widget displays an animated switcher with an icon button that triggers
  /// the [_handleThemeChanged] function on press.
  Widget _iconButton({required Map<String, String?> language, required Brightness brightness}) => AnimatedSwitcher(
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
          key: ValueKey(brightness),
          onPressed: _handleThemeChanged,
          icon: Icon(_getIconData(brightness: brightness)),
          tooltip: language['Change theme']!,
        ),
      );

  /// Builds the list tile for theme switching.
  ///
  /// This widget displays a list tile with an icon and texts for the current theme,
  /// allowing the user to tap and switch the theme.
  Widget _listTile({required Map<String, String?> language, required Brightness brightness}) => ListTile(
        leading: Icon(_getIconData(brightness: brightness)),
        title: Text(language['Change theme']!),
        subtitle: Text(language[brightness == Brightness.light ? 'Light' : 'Dark']!),
        onTap: _handleThemeChanged,
      );

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Language.getInstance().languageNotifier,
        builder: (context, language, child) => ValueListenableBuilder(
          valueListenable: MWidget.themeValue,
          builder: (context, themeValue, child) => _isIconButton
              ? _iconButton(
                  language: language,
                  brightness: Theme.of(context).brightness,
                )
              : _listTile(
                  language: language,
                  brightness: Theme.of(context).brightness,
                ),
        ),
      );
}
