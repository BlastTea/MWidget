part of 'utils.dart';

/// A custom [PageRoute] that implements a dialog-style route with adaptive behavior.
///
/// This route is designed to be used as a dialog, appearing on top of the current screen.
/// It is intended to work seamlessly across different platforms with adaptive transitions.
class AdaptiveDialogRoute<T> extends DialogRoute<T> implements PageRoute<T> {
  /// Creates an [AdaptiveDialogRoute] with the given parameters.
  ///
  /// The [builder] is required parameters inherited from [DialogRoute].
  /// The [maintainState] determines whether the state of the underlying screen should be maintained
  /// when the dialog route is closed. By default, the state is maintained.
  /// The [fullscreenDialog] parameter specifies whether the dialog should take up the entire screen
  /// when it is displayed. By default, this is set to true.
  ///
  /// Other parameters are inherited from [DialogRoute] and [PageRoute].
  /// The [themes] parameter can be used to provide a custom [TransitionTheme] for the page transitions.
  /// The [barrierColor] defines the color of the modal barrier that appears behind the dialog.
  /// The [barrierDismissible] determines whether the dialog can be dismissed by tapping outside it.
  /// The [barrierLabel] specifies the semantic label for the modal barrier.
  /// The [useSafeArea] parameter indicates whether the dialog should avoid system areas.
  /// The [settings] parameter is used to define the settings for this route.
  /// The [anchorPoint] can be set to a specific offset, and [traversalEdgeBehavior] can be used
  /// to customize the behavior when the route is popped.
  ///
  /// The [builder] is a [WidgetBuilder] that returns the widget tree for the dialog content.
  AdaptiveDialogRoute({
    required this.builder,
    this.maintainState = true,
    this.fullscreenDialog = true,
    super.themes,
    super.barrierColor,
    super.barrierDismissible,
    super.barrierLabel,
    super.useSafeArea,
    super.settings,
    super.anchorPoint,
    super.traversalEdgeBehavior,
  }) : super(
          context: Get.context!,
          builder: builder,
        );

  /// The builder that returns the widget tree for the dialog content.
  final WidgetBuilder builder;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: DisplayFeatureSubScreen(
        anchorPoint: anchorPoint,
        // child: _pageBuilder(context, animation, secondaryAnimation),
        child: theme.buildTransitions(this, context, animation, secondaryAnimation, builder(context)),
      ),
    );
  }

  @override
  final bool maintainState;

  @override
  final bool fullscreenDialog;
}
