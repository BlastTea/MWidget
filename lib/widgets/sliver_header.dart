part of 'widgets.dart';

/// A custom implementation of a sliver persistent header delegate.
///
/// The `SliverHeader` class allows you to create a custom sliver header that can adapt its appearance based on the
/// shrinking offset and whether it overlaps with content. It's typically used in conjunction with `CustomScrollView`
/// to create advanced scroll effects in your app.
///
/// Example usage:
///
/// ```dart
/// SliverHeader(
///   builder: (context, shrinkOffset, overlapsContent) {
///     return Container(
///       height: 200.0,
///       color: Colors.blue,
///       child: Center(
///         child: Text(
///           'Header',
///           style: TextStyle(fontSize: 24.0, color: Colors.white),
///         ),
///       ),
///     );
///   },
///   maxExtent: 200.0,
///   minExtent: 100.0,
///   rebuild: (oldDelegate, newDelegate) => true,
/// )
/// ```
class SliverHeader extends SliverPersistentHeaderDelegate {
  /// Creates a `SliverHeader` instance.
  ///
  /// The [builder] function constructs the content of the sliver header based on the provided parameters.
  ///
  /// The [maxExtent] sets the maximum extent of the header when expanded.
  ///
  /// The [minExtent] sets the minimum extent of the header when collapsed.
  ///
  /// The [rebuild] function determines whether the header should be rebuilt when the delegate is updated.
  SliverHeader({
    required this.builder,
    required this.maxExtent,
    required this.minExtent,
    required this.rebuild,
  });

  /// The function that constructs the content of the sliver header.
  final Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent) builder;

  /// The maximum extent of the header when expanded.
  @override
  double maxExtent;

  /// The minimum extent of the header when collapsed.
  @override
  double minExtent;

  /// The function that determines whether the header should be rebuilt.
  final bool Function(SliverHeader oldDelegate, SliverHeader newDelegate) rebuild;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => builder(context, shrinkOffset, overlapsContent);

  @override
  bool shouldRebuild(SliverHeader oldDelegate) => rebuild(oldDelegate, this);
}
