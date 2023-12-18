part of 'utils.dart';

class MWidgetTheme extends InheritedWidget {
  const MWidgetTheme({
    super.key,
    required super.child,
    this.errorDialogTheme = const MWidgetErrorDialogThemeData(),
    this.invertThousandSeparator = false,
  });

  final MWidgetErrorDialogThemeData errorDialogTheme;
  final bool invertThousandSeparator;

  static MWidgetTheme? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<MWidgetTheme>();

  @override
  bool updateShouldNotify(MWidgetTheme oldWidget) => errorDialogTheme.updateShouldNotify(oldWidget.errorDialogTheme);
}

@immutable
class MWidgetErrorDialogThemeData {
  const MWidgetErrorDialogThemeData({
    this.titleText,
    this.useFilledButton = false,
  });

  final String? titleText;
  final bool useFilledButton;

  bool updateShouldNotify(MWidgetErrorDialogThemeData oldWidget) => oldWidget.titleText != titleText || oldWidget.useFilledButton != useFilledButton;
}
