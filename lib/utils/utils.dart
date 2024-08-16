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
part 'm_widget.dart';
part 'm_widget_theme.dart';

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
EdgeInsets responsivePadding(Size size, {double minimumHorizontalPadding = 16.0}) {
  if (size.width < kCompactSize) {
    return EdgeInsets.symmetric(horizontal: minimumHorizontalPadding);
  }
  if (size.width <= kMediumSize) {
    return EdgeInsets.symmetric(horizontal: (size.width - kCompactSize) / 2 + minimumHorizontalPadding);
  }

  return EdgeInsets.symmetric(horizontal: (size.width - kMediumSize) / 2 + minimumHorizontalPadding);
}

/// Calculates responsive width based on the screen size.
///
/// The [size] parameter is the current screen size.
///
/// Returns the appropriate width for responsive layouts.
double responsiveWidth(Size size, {double minimumHorizontalPadding = 16.0}) {
  if (size.width < kCompactSize) {
    return size.width - minimumHorizontalPadding * 2.0;
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
double responsiveDialogWidth(Size size, {double minimumHorizontalPadding = 16.0}) {
  if (size.width < kCompactSize) {
    return size.width - minimumHorizontalPadding * 2.0;
  }
  return kCompactSize - minimumHorizontalPadding * 2.0;
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
      duration: Durations.medium2,
      curve: Curves.fastOutSlowIn,
    );

/// Animates the given [controller] of a DraggableScrollableSheet to a specified [size].
///
/// The [size] parameter specifies the desired size to animate the sheet to.
///
/// The [controller] parameter is the DraggableScrollableController to be animated.
Future<void> animateDraggableScrollableController({required double size, required DraggableScrollableController controller}) => controller.animateTo(
      size,
      duration: Durations.short2,
      curve: Curves.fastOutSlowIn,
    );

/// Animates the given [pageController] to a specified [page].
///
/// The [page] parameter specifies the desired page to scroll to.
///
/// The [pageController] parameter is the PageController to be animated.
Future<void> animatePageController({required int page, required PageController pageController}) => pageController.animateToPage(
      page,
      duration: Durations.short2,
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

  if (words.contains('\\"')) {
    words = words.replaceAll('\\"', '');
  }

  if (words.contains('\\')) {
    words = words.replaceAll('\\', '');
  }

  return words;
}

Size getTextSize({
  required String text,
  required TextStyle style,
  TextDirection textDirection = TextDirection.ltr,
  double minWidth = 0.0,
  double maxWidth = double.infinity,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: textDirection,
    // textScaleFactor: PlatformDispatcher.instance.textScaleFactor,
  )..layout(minWidth: minWidth, maxWidth: maxWidth);
  return textPainter.size;
}
