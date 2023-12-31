part of 'widgets.dart';

/// A widget that provides a draggable scrollable body with customizable visual properties.
///
/// The `DraggableScrollableBody` widget offers a container for the content that can be scrolled vertically.
/// It allows you to customize the background color, border radius, and theme mode of the body,
/// enhancing the appearance and interaction experience of the draggable content.
///
/// Example usage:
///
/// ```dart
/// DraggableScrollableBody(
///   child: ListView.builder(
///     itemCount: 20,
///     itemBuilder: (context, index) => ListTile(
///       title: Text('Item $index'),
///     ),
///   ),
///   themeMode: ThemeMode.light,
///   color: Colors.blueGrey,
///   borderRadius: BorderRadius.circular(16.0),
/// )
/// ```
class DraggableScrollableBody extends StatelessWidget {
  /// Creates a `DraggableScrollableBody` widget.
  ///
  /// The [child] is the content to be displayed and scrolled.
  ///
  /// The [themeMode] specifies the theme mode to determine the default background color.
  ///
  /// The [color] sets the background color of the body. If not provided, the default color
  /// based on the [themeMode] will be used.
  ///
  /// The [borderRadius] determines the roundedness of the body's corners.
  const DraggableScrollableBody({
    super.key,
    required this.child,
    required this.themeMode,
    this.color,
    this.borderRadius,
  });

  /// The content to be displayed and scrolled.
  final Widget child;

  /// The theme mode to determine the default background color.
  final ThemeMode themeMode;

  /// The background color of the body.
  final Color? color;

  /// The roundedness of the body's corners.
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: color ?? (themeMode == ThemeMode.dark ? kColorSurfaceContainerHighestDark : kColorSurfaceContainerHighestLight),
          borderRadius: borderRadius,
        ),
        child: Material(
          color: Colors.transparent,
          child: child,
        ),
      );
}
