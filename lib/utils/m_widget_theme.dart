part of 'utils.dart';

class MWidgetTheme extends InheritedWidget {
  const MWidgetTheme({
    super.key,
    required super.child,
    this.dialogTheme = const MWidgetDialogThemeData(),
    this.invertThousandSeparator = false,
  });

  final MWidgetDialogThemeData dialogTheme;
  final bool invertThousandSeparator;

  static MWidgetTheme? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<MWidgetTheme>();

  @override
  bool updateShouldNotify(MWidgetTheme oldWidget) => dialogTheme.updateShouldNotify(oldWidget.dialogTheme);
}

@immutable
class MWidgetDialogThemeData {
  const MWidgetDialogThemeData({
    this.errorTitleText,
    this.warningTitleText,
    this.informationTitleText,
    this.saveChangesTitleText,
    this.titleTextStyle,
    this.messageTextStyle,
    this.primaryFilledButton = false,
    this.onRenderMessage,
  });

  final String? errorTitleText;
  final String? warningTitleText;
  final String? informationTitleText;
  final String? saveChangesTitleText;
  final TextStyle? titleTextStyle;
  final TextStyle? messageTextStyle;
  final bool primaryFilledButton;
  final Widget Function(BuildContext context, String message)? onRenderMessage;

  bool updateShouldNotify(MWidgetDialogThemeData oldWidget) => oldWidget.errorTitleText != errorTitleText || oldWidget.primaryFilledButton != primaryFilledButton;
}
