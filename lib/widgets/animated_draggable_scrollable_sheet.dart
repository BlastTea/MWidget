part of 'widgets.dart';

/// A typedef for a function that builds custom transitions for the draggable sheet.
typedef DraggableTransitionBuilder = Widget Function(BuildContext context, Animation<double> animation, Animation<double> curvedAnimation, Widget child);

/// A class representing a draggable scrollable sheet with animated transitions.
class AnimatedDraggableScrollableSheet extends StatefulWidget {
  /// Creates a new [AnimatedDraggableScrollableSheet].
  ///
  /// - [controller] can be used to control the scroll position of the sheet.
  /// - [minChildSize] is the minimum size of the child when fully collapsed.
  /// - [initialChildSize] is the initial size of the child. If not provided, it will be set to [minChildSize].
  /// - [maxChildSize] is the maximum size of the child when fully expanded.
  /// - [expand] determines whether the child can expand beyond the maximum size.
  /// - [snap] determines whether the sheet should snap to [snapSizes] if provided.
  /// - [snapAnimationDuration] specifies the duration of the snap animation.
  /// - [transitions] is a list of [SheetDraggableTransition]s that define animated transitions.
  /// - [snapSizes] is a list of sizes to snap the sheet to when [snap] is enabled.
  /// - [curve] is the curve for the animation.
  /// - [builder] is a function to build the main content of the sheet.
  const AnimatedDraggableScrollableSheet({
    super.key,
    this.controller,
    this.minChildSize = 0.25,
    this.initialChildSize,
    this.maxChildSize,
    this.expand = true,
    this.snap = false,
    this.snapAnimationDuration,
    this.transitions,
    this.snapSizes,
    this.curve = Curves.linear,
    required this.builder,
  });

  /// The [DraggableScrollableController] to control the scroll position of the sheet.
  final DraggableScrollableController? controller;

  /// The minimum size of the child when fully collapsed.
  final double minChildSize;

  /// The initial size of the child. If not provided, it will be set to [minChildSize].
  final double? initialChildSize;

  /// The maximum size of the child when fully expanded.
  final double? maxChildSize;

  /// Determines whether the child can expand beyond the maximum size.
  final bool expand;

  /// Determines whether the sheet should snap to [snapSizes] if provided.
  final bool snap;

  /// The duration of the snap animation.
  final Duration? snapAnimationDuration;

  /// A list of [SheetDraggableTransition]s that define animated transitions.
  final List<SheetDraggableTransition>? transitions;

  /// A list of sizes to snap the sheet to when [snap] is enabled.
  final List<double>? snapSizes;

  /// The curve for the animation.
  final Curve curve;

  /// A function to build the main content of the sheet.
  final Widget Function(
    BuildContext context,
    ScrollController scrollController,
    Animation<double> animation,
    List<SheetAnimatedDraggable>? animatedDraggables,
  ) builder;

  @override
  State<AnimatedDraggableScrollableSheet> createState() => _AnimatedDraggableScrollableSheetState();
}

/// The state of [AnimatedDraggableScrollableSheet].
class _AnimatedDraggableScrollableSheetState extends State<AnimatedDraggableScrollableSheet> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  late List<double>? _snapSizes;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Interval(widget.minChildSize, 1.0),
    );

    _snapSizes = [];
    if (widget.snapSizes != null) {
      for (double snapSize in widget.snapSizes!) {
        _snapSizes!.add(widget.minChildSize + snapSize);
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleSheetSizeChanged(double sheetSize) {
    _animationController.value = sheetSize;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        if (notification.extent >= 0.0 && notification.extent <= 1.0) {
          _handleSheetSizeChanged(notification.extent);
        }
        return false;
      },
      child: DraggableScrollableActuator(
        child: DraggableScrollableSheet(
          controller: widget.controller,
          maxChildSize: widget.maxChildSize ?? 1.0,
          minChildSize: widget.minChildSize,
          initialChildSize: widget.initialChildSize ?? widget.minChildSize,
          expand: widget.expand,
          snap: widget.snap,
          snapAnimationDuration: widget.snapAnimationDuration,
          snapSizes: _snapSizes,
          builder: (BuildContext context, ScrollController scrollController) => AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              List<SheetAnimatedDraggable>? animatedDraggables;
              if (widget.transitions != null) {
                animatedDraggables = [];
                Animation<double> curvedAnimation;
                for (SheetDraggableTransition transition in widget.transitions!) {
                  switch (transition.transitionCurve) {
                    case SheetDraggableTransitionCurves.start:
                      curvedAnimation = Tween<double>(begin: 1.0 - CurvedAnimation(parent: _animation, curve: Interval(transition.startTransition, transition.endTransition)).value, end: 0.0).animate(_animation);
                      break;
                    case SheetDraggableTransitionCurves.end:
                      curvedAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animation, curve: Interval(transition.startTransition, transition.endTransition)));
                      break;
                    case SheetDraggableTransitionCurves.mid:
                      double mid = (transition.endTransition - transition.startTransition) / 2 + transition.startTransition;
                      if (_animation.value <= mid) {
                        curvedAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animation, curve: Interval(transition.startTransition, mid)));
                      } else {
                        curvedAnimation = Tween<double>(begin: 1.0 - CurvedAnimation(parent: _animation, curve: Interval(mid, transition.endTransition)).value, end: 0.0).animate(_animation);
                      }
                  }

                  animatedDraggables.addAll(
                    switch (transition) {
                      SheetDraggableTransitionWithChildren() => transition.transitionBuilder != null
                          ? transition.children
                              .map(
                                (e) => transition.transitionBuilder!.call(
                                  context,
                                  CurvedAnimation(parent: _animation, curve: widget.curve),
                                  CurvedAnimation(parent: curvedAnimation, curve: transition.curve),
                                  e,
                                ),
                              )
                              .map(
                                (e) => SheetAnimatedDraggable(
                                  tag: transition.tag,
                                  child: e,
                                ),
                              )
                              .toList()
                          : transition.children
                              .map(
                                (e) => SheetAnimatedDraggable(
                                  tag: transition.tag,
                                  child: e,
                                ),
                              )
                              .toList(),
                      SingleChildSheetDraggableTransition() => [
                          SheetAnimatedDraggable(
                            tag: transition.tag,
                            child: transition.transitionBuilder != null
                                ? transition.transitionBuilder!.call(
                                    context,
                                    CurvedAnimation(parent: _animation, curve: widget.curve),
                                    CurvedAnimation(parent: curvedAnimation, curve: transition.curve),
                                    transition.child,
                                  )
                                : transition.child,
                          )
                        ],
                    },
                  );
                }
              }

              return widget.builder(
                context,
                scrollController,
                _animation.drive(CurveTween(curve: widget.curve)),
                animatedDraggables,
              );
            },
          ),
        ),
      ),
    );
  }
}

/// An abstract class representing a draggable transition for the scrollable sheet.
sealed class SheetDraggableTransition {
  /// Creates a [SheetDraggableTransition].
  ///
  /// - [tag] is a unique identifier for this transition.
  /// - [startTransition] is the starting point of the transition.
  /// - [endTransition] is the ending point of the transition.
  /// - [transitionCurve] defines the curve of the transition.
  /// - [curve] is the animation curve for this transition.
  SheetDraggableTransition({
    required this.tag,
    required this.startTransition,
    required this.endTransition,
    required this.transitionCurve,
    this.curve = Curves.linear,
    this.transitionBuilder,
  });

  /// A unique identifier for this transition.
  final Object tag;

  /// The starting point of the transition.
  final double startTransition;

  /// The ending point of the transition.
  final double endTransition;

  /// The curve of the transition.
  final SheetDraggableTransitionCurves transitionCurve;

  /// The animation curve for this transition.
  final Curve curve;

  /// A function to build custom transitions for the sheet.
  final DraggableTransitionBuilder? transitionBuilder;
}

/// A class representing a draggable transition with multiple children.
class SheetDraggableTransitionWithChildren extends SheetDraggableTransition {
  /// Creates a [SheetDraggableTransitionWithChildren].
  ///
  /// - [tag] is a unique identifier for this transition.
  /// - [startTransition] is the starting point of the transition.
  /// - [endTransition] is the ending point of the transition.
  /// - [transitionCurve] defines the curve of the transition.
  /// - [curve] is the animation curve for this transition.
  /// - [children] is the list of children widgets that participate in the transition.
  /// - [transitionBuilder] a function to build custom transitions for the sheet.
  SheetDraggableTransitionWithChildren({
    required super.tag,
    required super.startTransition,
    required super.endTransition,
    required super.transitionCurve,
    super.curve = Curves.linear,
    required this.children,
    super.transitionBuilder,
  });

  /// The list of children widgets that participate in the transition.
  final List<Widget> children;
}

/// A class representing a draggable transition with a single child.
class SingleChildSheetDraggableTransition extends SheetDraggableTransition {
  /// Creates a [SingleChildSheetDraggableTransition].
  ///
  /// - [tag] is a unique identifier for this transition.
  /// - [startTransition] is the starting point of the transition.
  /// - [endTransition] is the ending point of the transition.
  /// - [transitionCurve] defines the curve of the transition.
  /// - [curve] is the animation curve for this transition.
  /// - [child] is the child widget that participates in the transition.
  /// - [transitionBuilder] a function to build custom transitions for the sheet.
  SingleChildSheetDraggableTransition({
    required super.tag,
    required super.startTransition,
    required super.endTransition,
    required super.transitionCurve,
    super.curve = Curves.linear,
    required this.child,
    super.transitionBuilder,
  });

  /// The child widget that participates in the transition.
  final Widget child;
}

/// A class representing an animated draggable widget.
class SheetAnimatedDraggable {
  /// Creates a [SheetAnimatedDraggable].
  ///
  /// - [tag] is a unique identifier for the animated draggable widget.
  /// - [child] is the child widget to animate.
  SheetAnimatedDraggable({
    required this.tag,
    required this.child,
  });

  /// A unique identifier for this animated draggable widget.
  final Object tag;

  /// The child widget to animate.
  final Widget child;
}

/// Enumeration of draggable transition curves.
enum SheetDraggableTransitionCurves {
  /// The animation value at the start of the transition will be 1.0
  start,

  /// The animation value at the mid of the transition will be 1.0
  mid,

  /// The animation value at the end of the transition will be 1.0
  end,
}
