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
    ThemeValue? themeValue = await navigator!.push(
      AdaptiveDialogRoute(
        builder: (context) {
          ThemeValue currentValue = MWidget.themeValue.copyWith();
          currentValue.color ??= Colors.red;

          return ValueListenableBuilder(
            valueListenable: currentValue,
            builder: (context, themeValue, child) {
              return AdaptiveFullScreenDialog(
                title: Text('Change theme'.tr),
                body: _themeChangeBody(themeValue: currentValue),
                dialogBody: SizedBox(
                  width: kCompactSize,
                  height: kCompactSize,
                  child: _themeChangeBody(themeValue: currentValue),
                ),
                fullScreenFab: FloatingActionButton(
                  onPressed: () => Get.back(result: currentValue),
                  child: const Icon(Icons.done),
                ),
                dialogActions: [
                  TextButton(onPressed: () => Get.back(), child: Text('Cancel'.tr)),
                  TextButton(
                    onPressed: () => Get.back(result: currentValue),
                    child: Text('Ok'.tr),
                  ),
                ],
              );
            },
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

    // Get.changeThemeMode(themeValue.themeMode);
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

  Widget _themeChangeBody({required ThemeValue themeValue}) => ListView(
    children: [
      ...List.generate(
        3,
        (index) => RadioGroup(
          groupValue: themeValue.themeMode,
          onChanged: (value) => themeValue.themeMode = value!,
          child: RadioListTile<ThemeMode>(
            value: const [ThemeMode.system, ThemeMode.light, ThemeMode.dark][index],
            title: Text(['System', 'Light', 'Dark'][index].tr),
          ),
        ),
      ),
      if (showDynamicColorOptions) ...[
        const Divider(),
        ...List.generate(
          2,
          (index) => RadioGroup(
            groupValue: themeValue.useDynamicColors,
            onChanged: (value) => themeValue.useDynamicColors = value!,
            child: RadioListTile<bool>(
              value: const [false, true][index],
              title: Text(['Don\'t use dynamic colors', 'Use dynamic colors'][index].tr),
            ),
          ),
        ),
        SwitchListTile(
          value: themeValue.withCustomColors,
          onChanged: themeValue.value.useDynamicColors ? (value) => themeValue.withCustomColors = value : null,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text('With custom colors'.tr),
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
      ],
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
  Widget _iconButton({required Brightness brightness}) => AnimatedSwitcher(
    duration: Durations.long4,
    transitionBuilder: (child, animation) => FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: RotationTransition(
          turns: animation,
          child: FadeTransition(opacity: animation, child: child),
        ),
      ),
    ),
    child: IconButton(
      key: ValueKey(brightness),
      onPressed: _handleThemeChanged,
      icon: Icon(_getIconData(brightness: brightness)),
      tooltip: 'Change theme'.tr,
    ),
  );

  /// Builds the list tile for theme switching.
  ///
  /// This widget displays a list tile with an icon and texts for the current theme,
  /// allowing the user to tap and switch the theme.
  Widget _listTile({required Brightness brightness}) => ListTile(
    leading: Icon(_getIconData(brightness: brightness)),
    title: Text('Change theme'.tr),
    subtitle: Text((brightness == Brightness.light ? 'Light' : 'Dark').tr),
    onTap: _handleThemeChanged,
  );

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: MWidget.themeValue,
    builder: (context, themeValue, child) => _isIconButton ? _iconButton(brightness: Theme.of(context).brightness) : _listTile(brightness: Theme.of(context).brightness),
  );
}
