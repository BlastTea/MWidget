import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_widget/m_widget.dart';

part 'material_utils.dart';
part 'firestore_auto_id_generator.dart';
part 'custom_scroll_behavior.dart';
part 'adaptive_dialog_route.dart';
part 'text_editing_controller_thousand_format.dart';
part 'submit_focus_node.dart';

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

/// Displays an error dialog with the provided message.
///
/// The [message] parameter is the error message to display.
Future<void> showErrorDialog(String message) => NavigationHelper.showDialog(
      builder: (context) => AlertDialog(
        title: Text(Language.getInstance().getValue('Error')!),
        content: SelectableText(message),
        actions: [
          TextButton(
            autofocus: true,
            onPressed: () => NavigationHelper.back(),
            child: Text(Language.getInstance().getValue('Ok')!),
          ),
        ],
      ),
    );

/// Displays a warning dialog with the provided message.
///
/// The [message] parameter is the warning message to display.
Future<void> showWarningDialog(String message) => NavigationHelper.showDialog(
      builder: (context) => AlertDialog(
        title: Text(Language.getInstance().getValue('Warning')!),
        content: SelectableText(message),
        actions: [
          TextButton(
            autofocus: true,
            onPressed: () => NavigationHelper.back(),
            child: Text(Language.getInstance().getValue('Ok')!),
          ),
        ],
      ),
    );

/// Displays a loading dialog with a progress indicator.
Future<void> showLoadingDialog() => NavigationHelper.showDialog(
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

/// Displays a dialog asking whether to save changes.
///
/// Returns the user's decision (true for Save, false for Don't Save, null if the user close the dialog).
Future<bool?> showSaveChangesDialog() => NavigationHelper.showDialog(
      builder: (context) => AlertDialog(
        title: Text(Language.getInstance().getValue('Save changes?')!),
        actions: [
          TextButton(
            onPressed: () => NavigationHelper.back(false),
            child: Text(Language.getInstance().getValue('Don\'t save')!),
          ),
          TextButton(
            onPressed: () => NavigationHelper.back(true),
            child: Text(Language.getInstance().getValue('Save')!),
          ),
        ],
      ),
    );

/// Determines the color for a selected tile based on the theme mode.
///
/// The [themeMode] parameter is the current theme mode.
///
/// The [animation] parameter is an optional animation value for color transition.
///
/// Returns the selected tile color for the specified theme mode.
Color? selectedTileColor({required ThemeMode themeMode, Animation<double>? animation}) => animation != null
    ? themeMode == ThemeMode.dark
        ? Color.lerp(Colors.transparent, kColorSecondaryContainerDark, animation.value)
        : Color.lerp(Colors.transparent, kColorSecondaryContainerLight, animation.value)
    : themeMode == ThemeMode.dark
        ? kColorSecondaryContainerDark
        : kColorSecondaryContainerLight;

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

/// Animates the given [pageController] to a specified [offset].
///
/// The [offset] parameter specifies the desired offset to scroll to.
///
/// The [pageController] parameter is the PageController to be animated.
Future<void> animatePageController({required double offset, required PageController pageController}) => pageController.animateTo(
      offset,
      duration: const Duration(milliseconds: kDurationShort2),
      curve: Curves.fastOutSlowIn,
    );
