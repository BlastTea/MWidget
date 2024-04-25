part of 'widgets.dart';

/// A flexible and adaptive scaffold widget that supports varying layouts based on screen size.
///
/// The [AdaptiveScaffold] widget is designed to provide different layouts and behavior for different
/// screen sizes. It offers support for navigation rail and drawer based on the available screen width.
/// For screens with a width less than [kMediumSize], a navigation drawer is displayed, and for larger
/// screens, a navigation rail is used.
///
/// The [scaffoldKey] is an optional [GlobalKey] that can be used to control the scaffold's behavior,
/// particularly for opening and closing the drawer. The [destinations] list contains the navigation
/// rail destinations along with their icons and labels. The [selectedIndex] represents the index of
/// the currently selected navigation rail destination. The [onDestinationSelected] callback is invoked
/// when a new destination is selected.
///
/// The [smallPages] and [pages] lists hold the page widgets that correspond to each navigation destination.
/// The [smallPages] are displayed on screens with width less than [kMediumSize], and [pages] are used on
/// larger screens. It is important to note that the lengths of [smallPages] and [pages] should be equal,
/// and they should also match the length of the [destinations] list.
///
/// Example usage:
/// ```dart
/// AdaptiveScaffold(
///   scaffoldKey: _scaffoldKey,
///   destinations: [
///     NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
///     NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
///   ],
///   selectedIndex: _selectedIndex,
///   onDestinationSelected: (index) {
///     // Handle destination selection
///   },
///   smallPages: [
///     HomePage(),
///     SettingsPage(),
///   ],
///   pages: [
///     HomePageLarge(),
///     SettingsPageLarge(),
///   ],
/// )
/// ```
class AdaptiveScaffold extends StatelessWidget {
  /// Creates an [AdaptiveScaffold] widget.
  ///
  /// The [scaffoldKey] is an optional [GlobalKey] that can be used to control the scaffold's behavior,
  /// particularly for opening and closing the drawer. The [destinations] list contains the navigation
  /// rail destinations along with their icons and labels. The [selectedIndex] represents the index of
  /// the currently selected navigation rail destination. The [onDestinationSelected] callback is invoked
  /// when a new destination is selected. The lengths of [smallPages] and [pages] should be equal, and
  /// they should also match the length of the [destinations] list.
  const AdaptiveScaffold({
    super.key,
    this.scaffoldKey,
    required this.destinations,
    this.selectedIndex = 0,
    this.onDestinationSelected,
    required this.smallPages,
    required this.pages,
  })  : assert(smallPages.length == pages.length, 'smallPages.length must be equal to pages.length'),
        assert(destinations.length == pages.length);

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final List<NavigationRailDestination> destinations;
  final int selectedIndex;
  final void Function(int index)? onDestinationSelected;
  final List<Widget> smallPages;
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) => Scaffold(
        key: scaffoldKey,
        drawer: MediaQuery.sizeOf(context).width < kMediumSize
            ? Drawer(
                child: SafeArea(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                    children: List.generate(
                      destinations.length,
                      (index) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kShapeLarge),
                          color: index == selectedIndex ? Theme.of(context).colorScheme.secondaryContainer : null,
                        ),
                        child: ListTile(
                          leading: destinations[index].icon,
                          title: destinations[index].label,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kShapeLarge),
                          ),
                          onTap: () {
                            scaffoldKey?.currentState?.closeDrawer();
                            onDestinationSelected?.call(index);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : null,
        body: MediaQuery.sizeOf(context).width < kMediumSize
            ? smallPages[selectedIndex]
            : Row(
                children: [
                  NavigationRail(
                    key: ValueKey(Language.getInstance().languageType),
                    destinations: destinations,
                    selectedIndex: selectedIndex,
                    labelType: NavigationRailLabelType.all,
                    onDestinationSelected: onDestinationSelected,
                  ),
                  Expanded(
                    child: pages[selectedIndex],
                  ),
                ],
              ),
      );
}
