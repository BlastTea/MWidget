part of 'widgets.dart';

class ModalDraggableScrollableSheet extends StatelessWidget {
  const ModalDraggableScrollableSheet({
    super.key,
    this.controller,
    required this.builder,
    this.withDragHandle = true,
    this.expand = true,
    this.initialChildSize = 0.5,
    this.maxChildSize = 1.0,
    this.minChildSize = 0.25,
    this.shouldCloseOnMinExtent = true,
    this.snap = false,
    this.snapAnimationDuration,
    this.snapSizes,
  });

  final DraggableScrollableController? controller;
  final Widget Function(BuildContext context, ScrollController scrollController) builder;
  final bool withDragHandle;
  final bool expand;
  final double initialChildSize;
  final double maxChildSize;
  final double minChildSize;
  final bool shouldCloseOnMinExtent;
  final bool snap;
  final Duration? snapAnimationDuration;
  final List<double>? snapSizes;

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
            controller: controller,
            expand: expand,
            initialChildSize: initialChildSize,
            maxChildSize: maxChildSize,
            minChildSize: minChildSize,
            shouldCloseOnMinExtent: shouldCloseOnMinExtent,
            snap: snap,
            snapAnimationDuration: snapAnimationDuration,
            snapSizes: snapSizes,
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
