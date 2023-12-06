part of 'widgets.dart';

class ModalDraggableScrollableSheet extends StatelessWidget {
  const ModalDraggableScrollableSheet({
    super.key,
    required this.builder,
    this.withDragHandle = true,
  });

  final Widget Function(BuildContext context, ScrollController scrollController) builder;
  final bool withDragHandle;

  static show({
    required Widget Function(BuildContext context) builder,
    Color backgroundColor = Colors.transparent,
    double elevation = 0.0,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = true,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool? showDragHandle,
    bool useSafeArea = false,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
  }) =>
      NavigationHelper.showModalBottomSheet(
        builder: builder,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        constraints: constraints,
        barrierColor: barrierColor,
        isScrollControlled: isScrollControlled,
        useRootNavigator: useRootNavigator,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
        routeSettings: routeSettings,
        transitionAnimationController: transitionAnimationController,
        anchorPoint: anchorPoint,
      );

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () async => NavigationHelper.back(),
        child: Container(
          color: const Color.fromRGBO(0, 0, 0, 0.001),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) => Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(kShapeExtraLarge),
                ),
              ),
              child: withDragHandle
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SingleChildScrollView(
                          controller: scrollController,
                          child: const DragHandle(),
                        ),
                        Expanded(
                          child: builder(context, scrollController),
                        ),
                      ],
                    )
                  : builder(context, scrollController),
            ),
          ),
        ),
      );
}
