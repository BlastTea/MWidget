part of 'services.dart';

class AdaptiveDialogRoute<T> extends DialogRoute<T> implements PageRoute<T> {
  AdaptiveDialogRoute({
    required super.context,
    required super.builder,
    this.maintainState = true,
    this.fullscreenDialog = false,
    super.themes,
    super.barrierColor = Colors.black54,
    super.barrierDismissible,
    super.barrierLabel,
    super.useSafeArea = true,
    super.settings,
    super.anchorPoint,
    super.traversalEdgeBehavior,
  }) : widgetBuilder = builder;

  final WidgetBuilder widgetBuilder;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: DisplayFeatureSubScreen(
        anchorPoint: anchorPoint,
        // child: _pageBuilder(context, animation, secondaryAnimation),
        child: theme.buildTransitions(this, context, animation, secondaryAnimation, widgetBuilder(context)),
      ),
    );
  }

  @override
  final bool maintainState;

  @override
  final bool fullscreenDialog;
}
