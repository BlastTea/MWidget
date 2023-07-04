part of 'services.dart';

class AdaptiveDialogRoute<T> extends material.DialogRoute<T> implements material.PageRoute<T> {
  AdaptiveDialogRoute({
    required super.context,
    required super.builder,
    this.maintainState = true,
    this.fullscreenDialog = false,
    super.themes,
    super.barrierColor = material.Colors.black54,
    super.barrierDismissible,
    super.barrierLabel,
    super.useSafeArea = true,
    super.settings,
    super.anchorPoint,
    super.traversalEdgeBehavior,
  }) : widgetBuilder = builder;

  final material.WidgetBuilder widgetBuilder;

  @override
  material.Widget buildPage(material.BuildContext context, material.Animation<double> animation, material.Animation<double> secondaryAnimation) {
    final material.PageTransitionsTheme theme = material.Theme.of(context).pageTransitionsTheme;
    return material.Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: material.DisplayFeatureSubScreen(
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
