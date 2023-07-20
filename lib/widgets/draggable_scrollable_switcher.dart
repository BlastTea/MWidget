part of 'widgets.dart';

/// A widget that switches between draggable scrollable sheets with transitions and snap behavior.
///
/// The `DraggableScrollableSwitcher` widget allows you to switch between different draggable scrollable sheets.
/// Each sheet can have its own transition and snap behavior, and the switcher animates the transitions
/// when the user drags the sheet up or down.
///
/// The widget takes a list of `DraggableScrollableTransition` objects, each representing a different sheet
/// with its transition characteristics. The `transitionBuilder` and `builder` parameters are used to customize
/// the appearance and behavior of the sheets during the transitions.
///
/// The `snap` parameter controls whether the sheets snap to specific sizes when released. You can specify the snap sizes
/// using the `snapSizes` parameter, which is a list of double values representing the height of each snap size.
///
/// Example usage:
/// ```dart
/// DraggableScrollableSwitcher(
///   minChildSize: 0.2,
///   snap: true,
///   snapSizes: [0.2, 0.6, 0.8],
///   children: [
///     DraggableScrollableTransition(
///       startTransition: 0.0,
///       endTransition: 0.3,
///       visibility: DraggableScrollableTransitionVisibility.start,
///       children: [
///         Text('Sheet 1 - Start'),
///       ],
///     ),
///     DraggableScrollableTransition(
///       startTransition: 0.3,
///       endTransition: 0.7,
///       visibility: DraggableScrollableTransitionVisibility.mid,
///       children: [
///         Text('Sheet 2 - Mid'),
///       ],
///     ),
///     DraggableScrollableTransition(
///       startTransition: 0.7,
///       endTransition: 1.0,
///       visibility: DraggableScrollableTransitionVisibility.end,
///       children: [
///         Text('Sheet 3 - End'),
///       ],
///     ),
///   ],
///   transitionBuilder: (context, animation, child) => SlideTransition(
///     position: Tween<Offset>(
///       begin: const Offset(0, 1),
///       end: Offset.zero,
///     ).animate(animation),
///     child: child,
///   ),
///   builder: (context, scrollController, children, animation) => DraggableScrollableSheet(
///     maxChildSize: 1.0,
///     minChildSize: 0.2,
///     initialChildSize: 0.6,
///     expand: true,
///     snap: true,
///     snapSizes: [0.2, 0.6, 0.8],
///     builder: (context, scrollController) => ListView(
///       controller: scrollController,
///       children: children,
///     ),
///   ),
/// )
/// ```
class DraggableScrollableSwitcher extends StatefulWidget {
  /// Creates a widget that switches between draggable scrollable sheets with transitions and snap behavior.
  ///
  /// The [controller] parameter allows you to control the scroll position of the sheet.
  ///
  /// The [minChildSize] parameter sets the minimum height of the sheet when fully collapsed.
  ///
  /// The [initialChildSize] parameter sets the initial height of the sheet when opened (default is [minChildSize]).
  ///
  /// The [maxChildSize] parameter sets the maximum height of the sheet when fully expanded (default is 1.0).
  ///
  /// The [expand] parameter determines whether the sheet can expand beyond [maxChildSize] when dragged (default is true).
  ///
  /// The [snap] parameter controls whether the sheet snaps to specific sizes when released (default is false).
  ///
  /// The [snapAnimationDuration] parameter sets the duration of the snap animation when [snap] is enabled.
  ///
  /// The [children] parameter is a list of [DraggableScrollableTransition] objects representing different sheets
  /// with their transition characteristics.
  ///
  /// The [snapSizes] parameter is a list of double values representing the height of each snap size
  /// when [snap] is enabled. If [snapSizes] is not provided, the sheet will snap to [minChildSize],
  /// [initialChildSize], and [maxChildSize].
  ///
  /// The [transitionBuilder] parameter is a function that customizes the appearance of the sheets during the transitions.
  ///
  /// The [builder] parameter is a function that customizes the contents of the sheets and provides a
  /// [DraggableScrollableSheet] widget with its corresponding [ScrollController].
  ///
  /// Example usage:
  /// ```dart
  /// DraggableScrollableSwitcher(
  ///   minChildSize: 0.2,
  ///   snap: true,
  ///   snapSizes: [0.2, 0.6, 0.8],
  ///   children: [
  ///     DraggableScrollableTransition(
  ///       startTransition: 0.0,
  ///       endTransition: 0.3,
  ///       visibility: DraggableScrollableTransitionVisibility.start,
  ///       children: [
  ///         Text('Sheet 1 - Start'),
  ///       ],
  ///     ),
  ///     // Add more DraggableScrollableTransition objects for other sheets
  ///   ],
  ///   transitionBuilder: (context, animation, child) => SlideTransition(
  ///     position: Tween<Offset>(
  ///       begin: const Offset(0, 1),
  ///       end: Offset.zero,
  ///     ).animate(animation),
  ///     child: child,
  ///   ),
  ///   builder: (context, scrollController, children, animation) => DraggableScrollableSheet(
  ///     maxChildSize: 1.0,
  ///     minChildSize: 0.2,
  ///     initialChildSize: 0.6,
  ///     expand: true,
  ///     snap: true,
  ///     snapSizes: [0.2, 0.6, 0.8],
  ///     builder: (context, scrollController) => ListView(
  ///       controller: scrollController,
  ///       children: children,
  ///     ),
  ///   ),
  /// )
  /// ```
  const DraggableScrollableSwitcher({
    super.key,
    this.controller,
    required this.minChildSize,
    this.initialChildSize,
    this.maxChildSize,
    this.expand = true,
    this.snap = false,
    this.snapAnimationDuration,
    required this.children,
    this.snapSizes,
    required this.transitionBuilder,
    required this.builder,
  });

  final DraggableScrollableController? controller;
  final double minChildSize;
  final double? initialChildSize;
  final double? maxChildSize;
  final bool expand;
  final bool snap;
  final Duration? snapAnimationDuration;
  final List<DraggableScrollableTransition> children;
  final List<double>? snapSizes;
  final Widget Function(BuildContext context, Animation<double> animation, Widget child) transitionBuilder;
  final Widget Function(BuildContext context, ScrollController scrollController, List<Widget> children, Animation<double> animation) builder;

  @override
  State<DraggableScrollableSwitcher> createState() => _DraggableScrollableSwitcherState();
}

class _DraggableScrollableSwitcherState extends State<DraggableScrollableSwitcher> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  late List<double>? snapSizes;

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

    snapSizes = [];
    if (widget.snapSizes != null) {
      for (double snapSize in widget.snapSizes!) {
        snapSizes!.add(widget.minChildSize + snapSize);
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
          snapSizes: snapSizes,
          builder: (BuildContext context, ScrollController scrollController) => AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              DraggableScrollableTransition transition;
              try {
                transition = widget.children.singleWhere((element) => _animation.value >= element.startTransition && _animation.value <= element.endTransition);
              } on StateError {
                return widget.builder(context, scrollController, [], _animation);
              }

              Animation<double> animation;
              switch (transition.visibility) {
                case DraggableScrollableTransitionVisibility.start:
                  animation = Tween<double>(begin: 1.0 - CurvedAnimation(parent: _animation, curve: Interval(transition.startTransition, transition.endTransition)).value, end: 0.0).animate(_animation);
                  break;
                case DraggableScrollableTransitionVisibility.end:
                  animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animation, curve: Interval(transition.startTransition, transition.endTransition)));
                  break;
                case DraggableScrollableTransitionVisibility.mid:
                  double mid = (transition.endTransition - transition.startTransition) / 2 + transition.startTransition;
                  if (_animation.value <= mid) {
                    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animation, curve: Interval(transition.startTransition, mid)));
                  } else {
                    animation = Tween<double>(begin: 1.0 - CurvedAnimation(parent: _animation, curve: Interval(mid, transition.endTransition)).value, end: 0.0).animate(_animation);
                  }
              }

              return widget.builder(
                context,
                scrollController,
                transition.children.map((e) => widget.transitionBuilder(context, animation, e)).toList(),
                animation,
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Represents a draggable scrollable transition with a specific range and visibility.
///
/// The [startTransition] and [endTransition] parameters define the range of the transition,
/// while the [visibility] parameter specifies the visibility of the widget during the transition.
/// The [children] parameter is a list of widgets that will be displayed during the transition range.
/// The widgets will be shown or hidden based on the specified [visibility].
class DraggableScrollableTransition {
  /// Creates a draggable scrollable transition.
  ///
  /// The [startTransition] parameter represents the starting point of the transition range.
  ///
  /// The [endTransition] parameter represents the ending point of the transition range.
  ///
  /// The [visibility] parameter defines the visibility of the widget during the transition.
  ///
  /// The [children] parameter is a list of widgets to be displayed during the transition range.
  DraggableScrollableTransition({
    required this.startTransition,
    required this.endTransition,
    required this.visibility,
    required this.children,
  });

  final double startTransition;
  final double endTransition;
  final DraggableScrollableTransitionVisibility visibility;
  final List<Widget> children;
}

/// Enum representing the visibility of a [DraggableScrollableTransition].
///
/// The widget will be visible at [start], [mid], or [end] of the transition range.
enum DraggableScrollableTransitionVisibility {
  /// The widget will be visible at the start of the transition range.
  start,

  /// The widget will be visible at the middle of the transition range.
  mid,

  /// The widget will be visible at the end of the transition range.
  end,
}
