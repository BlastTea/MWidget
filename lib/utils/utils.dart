import 'dart:math';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_widget/m_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'material_utils.dart';
part 'firestore_auto_id_generator.dart';
part 'custom_scroll_behavior.dart';
part 'adaptive_dialog_route.dart';
part 'text_editing_controller_thousand_format.dart';
part 'submit_focus_node.dart';
part 'dialog_utils.dart';

class MWidget {
  static ThemeValue themeValue = ThemeValue();

  static Future<void> initialize({
    ThemeValue? defaultTheme,
    LanguageType? defaultLanguage,
  }) async {
    debugPrint('initialize MWidget');
    Language language = Language.initialize();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? themeValueString = sharedPreferences.getString(keyThemeMode);
    if (themeValueString == ThemeMode.dark.toString()) {
      themeValue.themeMode = ThemeMode.dark;
    } else if (themeValueString == ThemeMode.light.toString()) {
      themeValue.themeMode = ThemeMode.light;
    } else {
      themeValue.themeMode = defaultTheme?.themeMode ?? ThemeMode.system;
    }

    int? colorValueInt = sharedPreferences.getInt(keyColor);
    themeValue.color = colorValueInt != null ? Color(colorValueInt) : defaultTheme?.color;

    bool? withCustomColorsValue = sharedPreferences.getBool(keyWithCustomColors);
    themeValue.withCustomColors = withCustomColorsValue ?? defaultTheme?.withCustomColors ?? false;

    bool? useDynamicColors = sharedPreferences.getBool(keyUseDynamicColors);
    themeValue.useDynamicColors = useDynamicColors ?? defaultTheme?.useDynamicColors ?? false;

    String? languageValue = sharedPreferences.getString(keyLanguage);
    language.languageType = languageValue != null ? LanguageType.fromFormattedString(languageValue) : defaultLanguage ?? LanguageType.unitedStatesEnglish;
  }
}

class MWidgetThemeBuilder extends StatelessWidget {
  const MWidgetThemeBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(
    BuildContext context,
    ThemeData theme,
    ThemeData darkTheme,
    ThemeMode themeMode,
  ) builder;

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
              lightColorScheme = ColorScheme.fromSeed(
                seedColor: themeValue.color!,
              )..harmonized();

              darkColorScheme = ColorScheme.fromSeed(
                seedColor: themeValue.color!,
                brightness: Brightness.dark,
              )..harmonized();
            }

            return builder(
              context,
              themeValue.useDynamicColors
                  ? ThemeData(
                      colorScheme: lightColorScheme,
                      extensions: [lightCustomColors],
                      useMaterial3: true,
                    )
                  : ThemeData.light(useMaterial3: true),
              themeValue.useDynamicColors
                  ? ThemeData(
                      colorScheme: darkColorScheme,
                      extensions: [darkCustomColors],
                      useMaterial3: true,
                    )
                  : ThemeData.dark(useMaterial3: true),
              themeValue.themeMode,
            );
          },
        ),
      );
}

class ThemeValue extends ChangeNotifier implements ValueListenable<ThemeValue> {
  ThemeValue({
    ThemeMode themeMode = ThemeMode.system,
    Color? color,
    bool withCustomColors = false,
    bool useDynamicColors = false,
  })  : _themeMode = themeMode,
        _color = color,
        _withCustomColors = withCustomColors,
        _useDynamicColors = useDynamicColors;

  ThemeMode _themeMode = ThemeMode.system;
  Color? _color;
  ColorScheme? _imageProviderLightColorScheme;
  ColorScheme? _imageProviderDarkColorScheme;
  bool _withCustomColors;
  bool _useDynamicColors;

  @override
  ThemeValue get value => this;

  set value(ThemeValue value) {
    _themeMode = value.themeMode;
    _color = value.color;
    _withCustomColors = value.withCustomColors;
    _useDynamicColors = value.useDynamicColors;
    notifyListeners();
  }

  Future<void> saveToSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(keyThemeMode, themeMode.toString());

    if (color == null) {
      await sharedPreferences.remove(keyColor);
    } else {
      await sharedPreferences.setInt(keyColor, color!.value);
    }

    await sharedPreferences.setBool(keyWithCustomColors, withCustomColors);

    await sharedPreferences.setBool(keyUseDynamicColors, useDynamicColors);
  }

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode value) {
    if (_themeMode == value) {
      return;
    }
    _themeMode = value;
    notifyListeners();
  }

  Color? get color => _color;

  set color(Color? value) {
    if (_color == value) {
      return;
    }
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

    _imageProviderLightColorScheme = await ColorScheme.fromImageProvider(
      provider: value,
    ).then((value) => value.harmonized());
    _imageProviderDarkColorScheme = await ColorScheme.fromImageProvider(
      provider: value,
      brightness: Brightness.dark,
    ).then((value) => value.harmonized());
    notifyListeners();
  }

  bool get withCustomColors => _withCustomColors;

  set withCustomColors(bool value) {
    if (_withCustomColors == value) {
      return;
    }
    _withCustomColors = value;
    notifyListeners();
  }

  bool get useDynamicColors => _useDynamicColors;

  set useDynamicColors(bool value) {
    if (_useDynamicColors == value) {
      return;
    }
    _useDynamicColors = value;
    notifyListeners();
  }

  ThemeValue copyWith({
    ThemeMode? themeMode,
    Color? color,
    bool? withCustomColors,
    bool? useDynamicColors,
  }) =>
      ThemeValue(
        themeMode: themeMode ?? this.themeMode,
        color: color ?? this.color,
        withCustomColors: withCustomColors ?? this.withCustomColors,
        useDynamicColors: useDynamicColors ?? this.useDynamicColors,
      );

  @override
  String toString() => 'ThemeValue($_themeMode, $_color, $_useDynamicColors, $_withCustomColors)';
}

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.danger,
  });

  final Color? danger;

  @override
  CustomColors copyWith({Color? danger}) {
    return CustomColors(
      danger: danger ?? this.danger,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      danger: Color.lerp(danger, other.danger, t),
    );
  }

  CustomColors harmonized(ColorScheme dynamic) => copyWith(danger: danger!.harmonizeWith(dynamic.primary));
}

List<LanguageType> availableLanguages = [
  LanguageType.unitedStatesEnglish,
  LanguageType.indonesiaIndonesian,
];

const keyLanguage = 'language';
const keyThemeMode = 'theme_mode';
const keyColor = 'color';
const keyWithCustomColors = 'with_custom_colors';
const keyUseDynamicColors = 'use_dynamic_colors';

/// The maximum width for compact screen layout.
const double kCompactSize = 600.0;

/// The maximum width for medium-sized screen layout.
const double kMediumSize = 840.0;

const double kSecondaryBodyWidth = 400.0;
const double kBottomFabPadding = 84.0;
const double kMinimumDraggableScrollableHeight = 94.0;
const double kMaximumDescriptionHeight = 400.0;

const String shortLorem = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer convallis ipsum tortor, cursus volutpat sapien iaculis ac. Vivamus eu dui pharetra, accumsan eros non, placerat sem.';
const String longLorem = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer convallis ipsum tortor, cursus volutpat sapien iaculis ac. Vivamus eu dui pharetra, accumsan eros non, placerat sem. Etiam pulvinar venenatis ligula, non condimentum lorem blandit nec. Nam elementum in tellus id viverra. Aliquam erat volutpat. Suspendisse placerat efficitur diam at laoreet. Maecenas feugiat purus sem, in malesuada sapien aliquam quis. Vestibulum ut velit eget massa egestas viverra non et turpis. Morbi fermentum pellentesque molestie. Fusce tempus neque nec justo iaculis aliquet. Duis consequat consequat aliquet.';

TextInputFormatter textFormatterDoubleWithNegative = FilteringTextInputFormatter.allow(RegExp(r'^-?\d+\.?\d*$'));
TextInputFormatter textFormatterDoubleOnly = FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*$'));
TextInputFormatter textFormattedDigitsWithNegative = FilteringTextInputFormatter.allow(RegExp(r'^-?\d+'));
TextInputFormatter textFormatterDigitsOnly = FilteringTextInputFormatter.digitsOnly;
TextInputFormatter textFormatterSingleLine = FilteringTextInputFormatter.singleLineFormatter;
TextInputFormatter textFormatterLetterOnly = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'));
TextInputFormatter textFormatterLetterDigitsOnly = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'));

/// Generates responsive horizontal padding based on the screen size.
///
/// The [size] parameter is the current screen size.
///
/// Returns the appropriate [EdgeInsets] for horizontal padding.
EdgeInsets responsivePadding(Size size) {
  if (size.width < kCompactSize) {
    return const EdgeInsets.symmetric(horizontal: 16.0);
  }
  if (size.width <= kMediumSize) {
    return EdgeInsets.symmetric(horizontal: (size.width - kCompactSize) / 2 + 16.0);
  }

  return EdgeInsets.symmetric(horizontal: (size.width - kMediumSize) / 2 + 16.0);
}

/// Calculates responsive width based on the screen size.
///
/// The [size] parameter is the current screen size.
///
/// Returns the appropriate width for responsive layouts.
double responsiveWidth(Size size) {
  if (size.width < kCompactSize) {
    return size.width - 32.0;
  }
  if (size.width <= kMediumSize) {
    return kCompactSize;
  }

  return kMediumSize;
}

/// Calculates responsive width for dialog components based on the screen size.
///
/// The [size] parameter is the current screen size.
///
/// Returns the appropriate width for responsive dialogs.
double responsiveDialogWidth(Size size) {
  if (size.width < kCompactSize) {
    return size.width - 32.0;
  }
  return kCompactSize - 32.0;
}

/// Determines the color for a selected tile based on the theme mode.
///
/// The [themeMode] parameter is the current theme mode.
///
/// The [animation] parameter is an optional animation value for color transition.
///
/// Returns the selected tile color for the specified theme mode.
Color selectedTileColor({Animation<double>? animation}) => animation != null ? Color.lerp(Colors.transparent, Theme.of(navigatorKey.currentContext!).colorScheme.secondaryContainer, animation.value)! : Theme.of(navigatorKey.currentContext!).colorScheme.secondaryContainer;

/// Animates the given [scrollController] to a specified [offset].
///
/// The [offset] parameter specifies the desired offset to scroll to.
///
/// The [scrollController] parameter is the ScrollController to be animated.
Future<void> animateScrollController({required double offset, required ScrollController scrollController}) => scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: kDurationMedium2),
      curve: Curves.fastOutSlowIn,
    );

/// Animates the given [controller] of a DraggableScrollableSheet to a specified [size].
///
/// The [size] parameter specifies the desired size to animate the sheet to.
///
/// The [controller] parameter is the DraggableScrollableController to be animated.
Future<void> animateDraggableScrollableController({required double size, required DraggableScrollableController controller}) => controller.animateTo(
      size,
      duration: const Duration(milliseconds: kDurationShort2),
      curve: Curves.fastOutSlowIn,
    );

/// Animates the given [pageController] to a specified [page].
///
/// The [page] parameter specifies the desired page to scroll to.
///
/// The [pageController] parameter is the PageController to be animated.
Future<void> animatePageController({required int page, required PageController pageController}) => pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: kDurationShort2),
      curve: Curves.fastOutSlowIn,
    );

String jsonToCorrectStringFormat(String jsonString) {
  String words = jsonString;

  while (words.characters.elementAt(0) == '\'' || words.characters.elementAt(0) == '"') {
    words = words.substring(1);
  }
  while (words.characters.elementAt(words.length - 1) == '\'' || words.characters.elementAt(words.length - 1) == '"') {
    words = words.substring(0, words.length - 1);
  }

  if (words.contains('\\')) {
    words = words.replaceAll('\\', '');
  }
  return words;
}
