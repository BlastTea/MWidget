part of 'widgets.dart';

/// A widget that adapts between a full-screen dialog and a normal-sized dialog based on screen size.
///
/// The `AdaptiveFullScreenDialog` widget provides a flexible way to create dialogs that can adapt between
/// a full-screen layout or a normal-sized dialog layout based on the screen size. The widget automatically
/// selects the appropriate layout based on the provided parameters and the current screen size.
///
/// The [alwaysFullScreen] parameter, when set to `true`, forces the dialog to be displayed in full-screen mode
/// regardless of the screen size. Similarly, setting [alwaysDialog] to `true` forces the dialog to be displayed
/// as a normal-sized dialog regardless of the screen size. Note that both [alwaysFullScreen] and [alwaysDialog]
/// cannot be `true` at the same time.
///
/// The [fullScreenFab] parameter allows you to provide a floating action button that will be displayed in full-screen
/// mode. This is useful for full-screen dialogs that need additional actions. For normal-sized dialogs, the floating
/// action button is ignored.
///
/// The [fullScreenLeading] parameter allows you to provide a leading widget (typically a back button) for the app bar
/// in full-screen mode. If not provided, a default back button will be shown. For normal-sized dialogs, this parameter
/// is ignored, and the default back button won't be used.
///
/// The [title] parameter is used to set the title of the dialog. It can be a text widget or any other widget
/// that represents the title content.
///
/// The [body] parameter represents the main content of the dialog when displayed in full-screen mode. In normal-sized
/// dialogs, the content is displayed in the body of the dialog, unless the [dialogBody] parameter is provided.
///
/// The [dialogBody] parameter allows you to provide specific content for normal-sized dialogs. If this parameter
/// is provided, it will be used as the content of the dialog when displayed in normal size, overriding the [body].
///
/// The [actions] parameter allows you to specify a list of widgets as actions for the dialog. These actions are
/// typically placed in the app bar for full-screen dialogs and as buttons at the bottom of normal-sized dialogs.
///
/// The [dialogActions] parameter allows you to provide specific actions for normal-sized dialogs. If this parameter
/// is provided, it will be used as the actions of the dialog when displayed in normal size, overriding the [actions].
///
/// Example usage:
/// ```dart
/// AdaptiveFullScreenDialog(
///   alwaysFullScreen: false,
///   alwaysDialog: false,
///   fullScreenFab: FloatingActionButton(
///     onPressed: () => print('Floating action button pressed'),
///     child: const Icon(Icons.add),
///   ),
///   fullScreenLeading: IconButton(
///     onPressed: () => NavigationHelper.back(),
///     icon: const Icon(Icons.close),
///   ),
///   title: Text('My Dialog'),
///   body: Container(
///     child: Text('Content goes here...'),
///   ),
///   dialogBody: Container(
///     child: Text('Content for normal-sized dialog...'),
///   ),
///   actions: [
///     TextButton(
///       onPressed: () => print('Action 1 pressed'),
///       child: Text('Action 1'),
///     ),
///     TextButton(
///       onPressed: () => print('Action 2 pressed'),
///       child: Text('Action 2'),
///     ),
///   ],
///   dialogActions: [
///     ElevatedButton(
///       onPressed: () => print('Action for normal-sized dialog pressed'),
///       child: Text('Action for Normal Dialog'),
///     ),
///   ],
/// )
/// ```
class AdaptiveFullScreenDialog extends StatelessWidget {
  /// Creates a widget that adapts between a full-screen dialog and a normal-sized dialog based on screen size.
  ///
  /// The [alwaysFullScreen] parameter, when set to `true`, forces the dialog to be displayed in full-screen mode
  /// regardless of the screen size. Similarly, setting [alwaysDialog] to `true` forces the dialog to be displayed
  /// as a normal-sized dialog regardless of the screen size. Note that both [alwaysFullScreen] and [alwaysDialog]
  /// cannot be `true` at the same time.
  ///
  /// The [fullScreenFab] parameter allows you to provide a floating action button that will be displayed in full-screen
  /// mode. This is useful for full-screen dialogs that need additional actions. For normal-sized dialogs, the floating
  /// action button is ignored.
  ///
  /// The [fullScreenLeading] parameter allows you to provide a leading widget (typically a back button) for the app bar
  /// in full-screen mode. If not provided, a default back button will be shown. For normal-sized dialogs, this parameter
  /// is ignored, and the default back button won't be used.
  ///
  /// The [title] parameter is used to set the title of the dialog. It can be a text widget or any other widget
  /// that represents the title content.
  ///
  /// The [body] parameter represents the main content of the dialog when displayed in full-screen mode. In normal-sized
  /// dialogs, the content is displayed in the body of the dialog, unless the [dialogBody] parameter is provided.
  ///
  /// The [dialogBody] parameter allows you to provide specific content for normal-sized dialogs. If this parameter
  /// is provided, it will be used as the content of the dialog when displayed in normal size, overriding the [body].
  ///
  /// The [actions] parameter allows you to specify a list of widgets as actions for the dialog. These actions are
  /// typically placed in the app bar for full-screen dialogs and as buttons at the bottom of normal-sized dialogs.
  ///
  /// The [dialogActions] parameter allows you to provide specific actions for normal-sized dialogs. If this parameter
  /// is provided, it will be used as the actions of the dialog when displayed in normal size, overriding the [actions].
  ///
  /// Example usage:
  /// ```dart
  /// AdaptiveFullScreenDialog(
  ///   alwaysFullScreen: false,
  ///   alwaysDialog: false,
  ///   fullScreenFab: FloatingActionButton(
  ///     onPressed: () => print('Floating action button pressed'),
  ///     child: const Icon(Icons.add),
  ///   ),
  ///   fullScreenLeading: IconButton(
  ///     onPressed: () => NavigationHelper.back(),
  ///     icon: const Icon(Icons.close),
  ///   ),
  ///   title: Text('My Dialog'),
  ///   body: Container(
  ///     child: Text('Content goes here...'),
  ///   ),
  ///   dialogBody: Container(
  ///     child: Text('Content for normal-sized dialog...'),
  ///   ),
  ///   actions: [
  ///     TextButton(
  ///       onPressed: () => print('Action 1 pressed'),
  ///       child: Text('Action 1'),
  ///     ),
  ///     TextButton(
  ///       onPressed: () => print('Action 2 pressed'),
  ///       child: Text('Action 2'),
  ///     ),
  ///   ],
  ///   dialogActions: [
  ///     ElevatedButton(
  ///       onPressed: () => print('Action for normal-sized dialog pressed'),
  ///       child: Text('Action for Normal Dialog'),
  ///     ),
  ///   ],
  /// )
  /// ```
  const AdaptiveFullScreenDialog({
    super.key,
    this.alwaysFullScreen = false,
    this.alwaysDialog = false,
    this.fullScreenFab,
    this.fullScreenLeading,
    this.title,
    this.body,
    this.dialogBody,
    this.actions,
    this.dialogActions,
  }) : assert(alwaysFullScreen || alwaysDialog || (!alwaysFullScreen && !alwaysDialog), 'alwaysFullScreen and alwaysDialog both cannot be true');

  final bool alwaysFullScreen;
  final bool alwaysDialog;
  final Widget? fullScreenFab;
  final Widget? fullScreenLeading;
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
          leading: fullScreenLeading ??
              IconButton(
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
