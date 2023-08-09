part of 'widgets.dart';

/// A Material Design widget that provides a draggable handle for interacting with a `DraggableScrollableSheet`.
///
/// The `DragHandle` widget displays a horizontal bar that serves as a visual indicator for grabbing and dragging
/// with a `DraggableScrollableSheet`. It's commonly used to
/// enhance the user experience by providing a tactile and recognizable way to initiate dragging actions.
///
/// Example usage within a `DraggableScrollableSheet`:
///
/// ```dart
/// DraggableScrollableSheet(
///   initialChildSize: 0.6,
///   minChildSize: 0.2,
///   maxChildSize: 0.9,
///   builder: (context, scrollController) {
///     return Container(
///       color: Colors.white,
///       child: Column(
///         children: [
///           DragHandle(),
///           // Additional content...
///         ],
///       ),
///     );
///   },
/// )
/// ```
class DragHandle extends StatelessWidget {
  const DragHandle({
    super.key,
    this.topMargin,
    this.bottomMargin,
  });

  final double? topMargin;
  final double? bottomMargin;

  @override
  Widget build(BuildContext context) => Align(
        child: Container(
          width: 32.0,
          height: 4.0,
          margin: EdgeInsets.only(top: topMargin ?? 22.0, bottom: bottomMargin ?? 22.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.4),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      );
}
