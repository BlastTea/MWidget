part of 'widgets.dart';

class DraggableScrollableSwitcher extends StatefulWidget {
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

class DraggableScrollableTransition {
  /// Start the transition from bottom to top\
  /// for example, the children will start transitioning at 0.0\
  /// and the transition will be done at 0.3
  /// ```
  ///DraggableScrollableTransitionChildren(
  ///   startTransition: 0.0,
  ///   endTransition: 0.3,
  ///   children: [
  ///     Text('I will gone at 0.3'),
  ///   ]
  ///);
  /// ```
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

enum DraggableScrollableTransitionVisibility {
  /// the widget will be visible at start
  start,

  /// the widget will be visible at mid
  mid,

  /// the widget will be visible at end
  end,
}
