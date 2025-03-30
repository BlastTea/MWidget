part of 'widgets.dart';

/// An animated transitions for items in an [AnimatedList] or [SliverAnimatedList].
///
/// The `DefaultAnimatedListTransition` widget provides a common way to animate the insertion and removal of items in
/// animated lists. It utilizes fade and slide transitions to smoothly animate items into and out of the list.
///
/// Example usage:
///
/// ```dart
/// DefaultAnimatedListTransition(
///   animation: animation,
///   builder: (context, animation) {
///     return ListTile(
///       title: Text('Item $index'),
///       // Additional item properties...
///     );
///   },
/// )
/// ```
class DefaultAnimatedListTransition extends StatelessWidget {
  /// Creates a `DefaultAnimatedListTransition` widget.
  ///
  /// The [animation] is the animation controlling the transition.
  ///
  /// The [builder] function constructs the child widget with the given context and animation.
  const DefaultAnimatedListTransition({
    super.key,
    required this.animation,
    required this.builder,
    this.curve = Curves.fastOutSlowIn,
  });

  /// The animation controlling the transition.
  final Animation<double>? animation;

  /// A function that constructs the child widget with the given context and animation.
  final Widget Function(BuildContext context, Animation<double>? animation) builder;

  final Curve curve;

  /// Inserts an item into a [SliverAnimatedList] with a sliding and fading animation.
  ///
  /// The [index] is the position at which to insert the item.
  ///
  /// The [state] is the [SliverAnimatedListState] of the list.
  static Future<void> insertItemSliver({required int index, required SliverAnimatedListState state, Duration duration = Durations.short4}) async {
    state.insertItem(index, duration: duration);
    await Future.delayed(Duration(milliseconds: (duration.inMilliseconds + 50) * timeDilation.toInt()));
  }

  /// Removes an item from a [SliverAnimatedList] with a sliding and fading animation.
  ///
  /// The [index] is the position of the item to remove.
  ///
  /// The [state] is the [SliverAnimatedListState] of the list.
  ///
  /// The [builder] is a function that constructs the transition for the removed item.
  static Future<void> removeItemSliver({required int index, required SliverAnimatedListState state, required Widget Function(BuildContext context, Animation<double>? animation) builder, Duration duration = Durations.short4}) async {
    state.removeItem(
      index,
      (context, animation) => DefaultAnimatedListTransition(
        animation: animation,
        builder: builder,
      ),
      duration: duration,
    );
    await Future.delayed(Duration(milliseconds: (duration.inMilliseconds + 50) * timeDilation.toInt()));
  }

  /// Inserts an item into an [AnimatedList] with a sliding and fading animation.
  ///
  /// The [index] is the position at which to insert the item.
  ///
  /// The [state] is the [AnimatedListState] of the list.
  static Future<void> insertItemList({required int index, required AnimatedListState state, Duration duration = Durations.short4}) async {
    state.insertItem(index, duration: duration);
    await Future.delayed(Duration(milliseconds: (duration.inMilliseconds + 50) * timeDilation.toInt()));
  }

  /// Removes an item from an [AnimatedList] with a sliding and fading animation.
  ///
  /// The [index] is the position of the item to remove.
  ///
  /// The [state] is the [AnimatedListState] of the list.
  ///
  /// The [builder] is a function that constructs the transition for the removed item.
  static Future<void> removeItemList({required int index, required AnimatedListState state, required Widget Function(BuildContext context, Animation<double>? animation) builder, Duration duration = Durations.short4}) async {
    state.removeItem(
      index,
      (context, animation) => DefaultAnimatedListTransition(
        animation: animation,
        builder: builder,
      ),
      duration: duration,
    );
    await Future.delayed(Duration(milliseconds: (duration.inMilliseconds + 50) * timeDilation.toInt()));
  }

  @override
  Widget build(BuildContext context) => animation != null
      ? FadeTransition(
          opacity: animation!,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-0.25, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation!),
            child: builder(context, animation),
          ),
        )
      : builder(
          context,
          animation,
        );
}
