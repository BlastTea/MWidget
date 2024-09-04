part of 'widgets.dart';

/// A customized [AppBar] widget that adapts its behavior based on screen size.
///
/// The [AdaptiveAppBar] widget extends the functionality of [AppBar] by providing an adaptive
/// behavior for the leading widget. The leading widget (typically a menu icon) will only be
/// displayed as an icon button if the screen width is less than [kMediumSize], otherwise, it
/// will be omitted. This helps optimize the user experience on different screen sizes.
///
/// The [scaffoldKey] parameter is used to control the drawer when the leading widget is displayed
/// as a menu icon. The [leading] widget, [title], and [actions] parameters are the same as in the
/// parent [AppBar] class.
///
/// Example usage:
/// ```dart
/// AdaptiveAppBar(
///   scaffoldKey: _scaffoldKey,
///   title: Text('My App'),
///   actions: [
///     IconButton(
///       onPressed: () {
///         // Add action functionality here
///       },
///       icon: Icon(Icons.search),
///     ),
///   ],
/// )
/// ```
class AdaptiveAppBar extends AppBar {
  /// Creates an [AdaptiveAppBar] widget.
  ///
  /// The `scaffoldKey` parameter is used to control the drawer when the leading widget is displayed
  /// as a menu icon. The `leading`, `title`, and `actions` parameters are the same as in the parent
  /// [AppBar] class. The leading widget will only be displayed as an icon button if the screen width
  /// is less than [kMediumSize], otherwise, it will be omitted.
  AdaptiveAppBar({
    super.key,
    GlobalKey<ScaffoldState>? scaffoldKey,
    Widget? leading,
    super.title,
    super.actions,
    super.actionsIconTheme,
    super.backgroundColor,
    super.bottom,
    super.bottomOpacity,
    super.centerTitle,
    super.clipBehavior,
    super.elevation,
    super.excludeHeaderSemantics,
    super.flexibleSpace,
    super.forceMaterialTransparency,
    super.foregroundColor,
    super.iconTheme,
    super.leadingWidth,
    ScrollNotificationPredicate? notificationPredicate,
    super.primary,
    super.scrolledUnderElevation,
    super.shadowColor,
    super.shape,
    super.surfaceTintColor,
    super.systemOverlayStyle,
    super.titleSpacing,
    super.titleTextStyle,
    super.toolbarHeight,
    super.toolbarOpacity,
    super.toolbarTextStyle,
  }) : super(
          leading: leading ?? (MediaQuery.sizeOf(Get.context!).width < kMediumSize ? IconButton(onPressed: () => scaffoldKey?.currentState?.openDrawer(), icon: const Icon(Icons.menu)) : null),
          notificationPredicate: notificationPredicate ?? defaultScrollNotificationPredicate,
        );
}
