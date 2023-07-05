part of 'widgets.dart';

class AdaptiveFullScreenDialog extends StatelessWidget {
  const AdaptiveFullScreenDialog({
    super.key,
    this.alwaysFullScreen = false,
    this.alwaysDialog = false,
    this.fullScreenFab,
    this.title,
    this.body,
    this.dialogBody,
    this.actions,
    this.dialogActions,
  }) : assert(alwaysFullScreen || alwaysDialog || (!alwaysFullScreen && !alwaysDialog), 'alwaysFullScreen and alwaysDialog both cannot be true');

  final bool alwaysFullScreen;
  final bool alwaysDialog;
  final Widget? fullScreenFab;
  final Widget? title;
  final Widget? body;
  final Widget? dialogBody;
  final List<Widget>? actions;
  final List<Widget>? dialogActions;

  @override
  Widget build(BuildContext context) {
    if (alwaysFullScreen) {
      return _scaffold(context);
    } else if (alwaysDialog) {
      return _alertDialog(context);
    } else if (MediaQuery.sizeOf(context).width < kCompactSize) {
      return _scaffold(context);
    }

    return _alertDialog(context);
  }

  Widget _scaffold(BuildContext context) => Scaffold(
        floatingActionButton: fullScreenFab,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => NavigationHelper.back(),
            icon: const Icon(Icons.close),
          ),
          title: title,
          actions: actions,
        ),
        body: body,
      );

  Widget _alertDialog(BuildContext context) => AlertDialog(
        title: title,
        content: dialogBody ?? body,
        actions: dialogActions ?? actions,
      );
}
