part of 'utils.dart';

class MWidget {
  static List<Locale> availableLanguages = [const Locale('en', 'US'), const Locale('id', 'ID')];

  static ThemeValue themeValue = ThemeValue();

  static Locale locale = availableLanguages.first;

  static Future<void> initialize({ThemeValue? defaultTheme, Locale? defaultLocale}) async {
    debugPrint('initialize MWidget');

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? themeValueString = sharedPreferences.getString(keyThemeMode);
    if (themeValueString == ThemeMode.dark.toString()) {
      themeValue.themeMode = ThemeMode.dark;
    } else if (themeValueString == ThemeMode.light.toString()) {
      themeValue.themeMode = ThemeMode.light;
    } else if (themeValueString == ThemeMode.system.toString()) {
      themeValue.themeMode = ThemeMode.system;
    } else {
      themeValue.themeMode = defaultTheme?.themeMode ?? ThemeMode.system;
    }

    int? colorValueInt = sharedPreferences.getInt(keyColor);
    themeValue.color = colorValueInt != null ? Color(colorValueInt) : defaultTheme?.color;

    bool? withCustomColorsValue = sharedPreferences.getBool(keyWithCustomColors);
    themeValue.withCustomColors = withCustomColorsValue ?? defaultTheme?.withCustomColors ?? false;

    bool? useDynamicColors = sharedPreferences.getBool(keyUseDynamicColors);
    themeValue.useDynamicColors = useDynamicColors ?? defaultTheme?.useDynamicColors ?? false;

    String? localeValue = sharedPreferences.getString(keyLocale);
    if (localeValue != null) {
      List<String> splittedLocale = localeValue.split('_');

      locale = Locale(splittedLocale[0], splittedLocale[1]);
    } else {
      locale = defaultLocale ?? availableLanguages.first;
    }
  }
}

class MWidgetDynamicColorBuilder extends StatelessWidget {
  const MWidgetDynamicColorBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, ThemeData theme, ThemeData darkTheme, ThemeMode themeMode, ColorScheme? colorScheme, ColorScheme? darkColorScheme) builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: MWidget.themeValue,
    builder: (context, themeValue, child) => DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        CustomColors lightCustomColors = const CustomColors(danger: Color(0xFFE53935));
        CustomColors darkCustomColors = const CustomColors(danger: Color(0xFFEF9A9A));

        ColorScheme? lightColorScheme;
        ColorScheme? darkColorScheme;

        if (themeValue._imageProviderLightColorScheme != null && themeValue._imageProviderDarkColorScheme != null) {
          lightColorScheme = themeValue._imageProviderLightColorScheme!;
          darkColorScheme = themeValue._imageProviderDarkColorScheme!;
        } else if (lightDynamic != null && darkDynamic != null && themeValue.useDynamicColors && !themeValue.withCustomColors && themeValue.color == null) {
          lightColorScheme = lightDynamic.harmonized();
          lightCustomColors = lightCustomColors.harmonized(lightColorScheme);

          darkColorScheme = darkDynamic.harmonized();
          darkCustomColors = darkCustomColors.harmonized(darkColorScheme);
        } else if (themeValue.useDynamicColors && themeValue.withCustomColors && themeValue.color != null) {
          lightColorScheme = ColorScheme.fromSeed(seedColor: themeValue.color!)..harmonized();

          darkColorScheme = ColorScheme.fromSeed(seedColor: themeValue.color!, brightness: Brightness.dark)..harmonized();
        }

        return builder(
          context,
          themeValue.useDynamicColors ? ThemeData(colorScheme: lightColorScheme, extensions: [lightCustomColors], fontFamily: themeValue.fontFamily, useMaterial3: true) : ThemeData.light(useMaterial3: true),
          themeValue.useDynamicColors ? ThemeData(colorScheme: darkColorScheme, extensions: [darkCustomColors], fontFamily: themeValue.fontFamily, useMaterial3: true) : ThemeData.dark(useMaterial3: true),
          themeValue.themeMode,
          lightColorScheme,
          darkColorScheme,
          // themeValue.themeMode == ThemeMode.dark
          //     ? darkColorScheme
          //     : themeValue.themeMode == ThemeMode.light
          //         ? lightColorScheme
          //         : Theme.of(context).brightness == Brightness.dark
          //             ? darkColorScheme
          //             : lightColorScheme,
        );
      },
    ),
  );
}

class ThemeValue extends ChangeNotifier implements ValueListenable<ThemeValue> {
  ThemeValue({ThemeMode themeMode = ThemeMode.system, Color? color, bool withCustomColors = false, bool useDynamicColors = false, String? fontFamily}) : _themeMode = themeMode, _color = color, _withCustomColors = withCustomColors, _useDynamicColors = useDynamicColors, _fontFamily = fontFamily;

  ThemeMode _themeMode = ThemeMode.system;
  Color? _color;
  ColorScheme? _imageProviderLightColorScheme;
  ColorScheme? _imageProviderDarkColorScheme;
  bool _withCustomColors;
  bool _useDynamicColors;
  String? _fontFamily;

  @override
  ThemeValue get value => this;

  set value(ThemeValue value) {
    _themeMode = value.themeMode;
    _color = value.color;
    _withCustomColors = value.withCustomColors;
    _useDynamicColors = value.useDynamicColors;
    _fontFamily = value.fontFamily;
    notifyListeners();
  }

  Future<void> saveToSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(keyThemeMode, themeMode.toString());

    if (color == null) {
      await sharedPreferences.remove(keyColor);
    } else {
      await sharedPreferences.setInt(keyColor, color!.toARGB32());
    }

    await sharedPreferences.setBool(keyWithCustomColors, withCustomColors);

    await sharedPreferences.setBool(keyUseDynamicColors, useDynamicColors);
  }

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode value) {
    if (_themeMode == value) return;
    _themeMode = value;
    notifyListeners();
  }

  Color? get color => _color;

  set color(Color? value) {
    if (_color == value) return;
    _color = value;
    notifyListeners();
  }

  Future<void> fromImageProvider(ImageProvider<Object>? value) async {
    if (value == null) {
      _imageProviderLightColorScheme = null;
      _imageProviderDarkColorScheme = null;
      notifyListeners();
      return;
    }

    _imageProviderLightColorScheme = await ColorScheme.fromImageProvider(provider: value).then((value) => value.harmonized());
    _imageProviderDarkColorScheme = await ColorScheme.fromImageProvider(provider: value, brightness: Brightness.dark).then((value) => value.harmonized());
    notifyListeners();
  }

  bool get withCustomColors => _withCustomColors;

  set withCustomColors(bool value) {
    if (_withCustomColors == value) return;
    _withCustomColors = value;
    notifyListeners();
  }

  bool get useDynamicColors => _useDynamicColors;

  set useDynamicColors(bool value) {
    if (_useDynamicColors == value) return;
    _useDynamicColors = value;
    notifyListeners();
  }

  String? get fontFamily => _fontFamily;

  set fontFamily(String? value) {
    if (_fontFamily == value) return;
    _fontFamily = value;
    notifyListeners();
  }

  ThemeValue copyWith({ThemeMode? themeMode, Color? color, bool? withCustomColors, bool? useDynamicColors}) => ThemeValue(themeMode: themeMode ?? this.themeMode, color: color ?? this.color, withCustomColors: withCustomColors ?? this.withCustomColors, useDynamicColors: useDynamicColors ?? this.useDynamicColors);

  @override
  String toString() => 'ThemeValue($_themeMode, $_color, $_useDynamicColors, $_withCustomColors, $_fontFamily)';
}

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({required this.danger});

  final Color? danger;

  @override
  CustomColors copyWith({Color? danger}) {
    return CustomColors(danger: danger ?? this.danger);
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(danger: Color.lerp(danger, other.danger, t));
  }

  CustomColors harmonized(ColorScheme dynamic) => copyWith(danger: danger!.harmonizeWith(dynamic.primary));
}
