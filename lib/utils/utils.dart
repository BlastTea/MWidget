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

const double kCompactSize = 600.0;
const double kMediumSize = 840.0;

const String shortLorem = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer convallis ipsum tortor, cursus volutpat sapien iaculis ac. Vivamus eu dui pharetra, accumsan eros non, placerat sem.';
const String longLorem = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer convallis ipsum tortor, cursus volutpat sapien iaculis ac. Vivamus eu dui pharetra, accumsan eros non, placerat sem. Etiam pulvinar venenatis ligula, non condimentum lorem blandit nec. Nam elementum in tellus id viverra. Aliquam erat volutpat. Suspendisse placerat efficitur diam at laoreet. Maecenas feugiat purus sem, in malesuada sapien aliquam quis. Vestibulum ut velit eget massa egestas viverra non et turpis. Morbi fermentum pellentesque molestie. Fusce tempus neque nec justo iaculis aliquet. Duis consequat consequat aliquet.';

TextInputFormatter textFormatterDoubleWithNegative = FilteringTextInputFormatter.allow(RegExp(r'^-?\d+\.?\d*$'));
TextInputFormatter textFormatterDoubleOnly = FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*$'));
TextInputFormatter textFormattedDigitsWithNegative = FilteringTextInputFormatter.allow(RegExp(r'^-?\d+'));
TextInputFormatter textFormatterDigitsOnly = FilteringTextInputFormatter.digitsOnly;
TextInputFormatter textFormatterSingleLine = FilteringTextInputFormatter.singleLineFormatter;
TextInputFormatter textFormatterLetterOnly = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'));
TextInputFormatter textFormatterLetterDigitsOnly = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'));

ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

EdgeInsets responsivePadding(Size size) {
  if (size.width < kCompactSize) {
    return const EdgeInsets.symmetric(horizontal: 16.0);
  }
  if (size.width <= kMediumSize) {
    return EdgeInsets.symmetric(horizontal: (size.width - kCompactSize) / 2 + 16.0);
  }

  return EdgeInsets.symmetric(horizontal: (size.width - kMediumSize) / 2 + 16.0);
}

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

Future<void> showLoadingDialog() => NavigationHelper.showDialog(
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

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

Color? selectedTileColor({required ThemeMode themeMode, Animation<double>? animation}) => animation != null
    ? themeMode == ThemeMode.dark
        ? Color.lerp(Colors.transparent, kColorSecondaryContainerDark, animation.value)
        : Color.lerp(Colors.transparent, kColorSecondaryContainerLight, animation.value)
    : themeMode == ThemeMode.dark
        ? kColorSecondaryContainerDark
        : kColorSecondaryContainerLight;

double responsiveWidth(Size size) {
  if (size.width < kCompactSize) {
    return size.width - 32.0;
  }
  if (size.width <= kMediumSize) {
    return kCompactSize;
  }

  return kMediumSize;
}

double responsiveDialogWidth(Size size) {
  if (size.width < kCompactSize) {
    return size.width - 32.0;
  }
  return kCompactSize - 32.0;
}
