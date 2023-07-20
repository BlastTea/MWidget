part of 'utils.dart';

/// A custom scroll behavior that allows defining specific pointer devices for dragging.
///
/// The `CustomScrollBehavior` class extends the default [MaterialScrollBehavior] and allows you to specify a set of
/// [PointerDeviceKind]s that should be considered for dragging in scrollable widgets. By default, all pointer device kinds
/// are included in the scroll behavior.
///
/// You can create instances of this class by providing the required `pointerDeviceKinds` parameter in the constructor.
/// The [pointerDeviceKinds] parameter is a set of [PointerDeviceKind]s that will be allowed for dragging.
///
/// Example usage:
/// ```dart
/// // Create a custom scroll behavior that allows only touch and mouse dragging.
/// CustomScrollBehavior customScrollBehavior = CustomScrollBehavior(pointerDeviceKinds: {PointerDeviceKind.touch, PointerDeviceKind.mouse});
///
/// // Use the custom scroll behavior in a scrollable widget.
/// ListView.builder(
///   itemCount: 100,
///   itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
///   scrollBehavior: customScrollBehavior,
/// )
/// ```
class CustomScrollBehavior extends MaterialScrollBehavior {
  /// Creates a custom scroll behavior with the specified [pointerDeviceKinds] for dragging.
  ///
  /// The [pointerDeviceKinds] parameter should be a set of [PointerDeviceKind]s that will be allowed for dragging.
  const CustomScrollBehavior({required this.pointerDeviceKinds});

  /// A custom scroll behavior that allows dragging with all pointer device kinds.
  ///
  /// This factory constructor creates a [CustomScrollBehavior] instance that allows dragging with all available
  /// [PointerDeviceKind]s, which includes touch, mouse, stylus, etc.
  ///
  /// Example usage:
  /// ```dart
  /// // Create a custom scroll behavior that allows all pointer device kinds for dragging.
  /// CustomScrollBehavior customScrollBehavior = CustomScrollBehavior.all;
  ///
  /// // Use the custom scroll behavior in a scrollable widget.
  /// SingleChildScrollView(
  ///   child: Text('Scrollable content'),
  ///   scrollBehavior: customScrollBehavior,
  /// )
  /// ```
  static CustomScrollBehavior get all => CustomScrollBehavior(pointerDeviceKinds: PointerDeviceKind.values.toSet());

  final Set<PointerDeviceKind> pointerDeviceKinds;

  @override
  Set<PointerDeviceKind> get dragDevices => pointerDeviceKinds;
}
