part of 'services.dart';

final material.GlobalKey<material.NavigatorState> navigatorKey = material.GlobalKey<material.NavigatorState>();
final material.GlobalKey<material.ScaffoldMessengerState> scaffoldMessengerKey = material.GlobalKey<material.ScaffoldMessengerState>();

/// The `NavigationHelper` class provides a set of static methods to facilitate navigation
/// and display various UI components such as dialogs, snack bars, and material banners
/// without requiring access to the `BuildContext` directly. It centralizes the handling of
/// navigation-related functionalities within the Flutter app, making it easier to manage
/// and reuse navigation and UI interactions across different parts of the application.
abstract class NavigationHelper {
  /// Navigates to a new route and returns a result when the route is popped.
  ///
  /// The `route` parameter specifies the route to navigate to, and the method
  /// returns a [Future] that resolves to the result returned by the popped route.
  ///
  /// Example:
  /// ```dart
  /// NavigatorRoute<String> route = MaterialPageRoute<String>(
  ///   builder: (context) => MyWidget(),
  /// );
  /// String? result = await NavigationHelper.to<String>(route);
  /// ```
  ///
  /// See also:
  ///   * [toReplacement], [back], and [canBack]
  static Future<T?> to<T extends Object?>(material.Route<T> route) => navigatorKey.currentState!.push<T>(route);

  /// Navigates to a new route and replaces the current route with the new route.
  ///
  /// The `newRoute` parameter specifies the route to navigate to, and the
  /// `result` parameter is used to set the result that will be returned when
  /// the new route is popped. The method returns a [Future] that resolves to
  /// the result returned by the popped route.
  ///
  /// Example:
  /// ```dart
  /// NavigatorRoute<String> newRoute = MaterialPageRoute<String>(
  ///   builder: (context) => MyNewWidget(),
  /// );
  /// String? result = await NavigationHelper.toReplacement<String, String>(
  ///   newRoute,
  ///   result: 'Replacement route result',
  /// );
  /// ```
  ///
  /// See also:
  ///   * [to], [back], and [canBack]
  static Future<T?> toReplacement<T extends Object?, TO extends Object?>(
    material.Route<T> newRoute, {
    TO? result,
  }) =>
      navigatorKey.currentState!.pushReplacement<T, TO>(
        newRoute,
        result: result,
      );

  /// Navigates back to the previous route, optionally passing a result.
  ///
  /// The `result` parameter can be used to pass a result back to the previous route.
  /// If the previous route expects a result, it can be accessed using the `await`
  /// keyword when calling this method.
  ///
  /// Example:
  /// ```dart
  /// String? result = await NavigationHelper.back<String>('Result from second screen');
  /// ```
  ///
  /// See also:
  ///   * [to], [toReplacement], and [canBack]
  static void back<T extends Object?>([T? result]) => navigatorKey.currentState!.pop<T>(result);

  /// Navigates back until a specific condition is met.
  ///
  /// The `predicate` parameter is a function that determines when the navigation
  /// should stop. It should return `true` for the routes that need to be popped.
  ///
  /// Example:
  /// ```dart
  /// NavigationHelper.backUntil((route) => route.settings.name == 'desired_route');
  /// ```
  ///
  /// See also:
  ///   * [to], [toReplacement], [back], and [canBack]
  static void backUntil(bool Function(Route<dynamic> route) predicate) => navigatorKey.currentState!.popUntil(predicate);

  /// Navigates back to the previous route and pushes a new named route.
  ///
  /// The `routeName` parameter specifies the name of the route to push, and the
  /// optional `result` parameter can be used to pass a result back to the previous route.
  /// The `arguments` parameter is used to pass arguments to the pushed route.
  ///
  /// Example:
  /// ```dart
  /// Future<int?> result = NavigationHelper.backAndPushNamed<int, String>(
  ///   'new_route',
  ///   result: 'Result from new route',
  ///   arguments: {'key': 'value'},
  /// );
  /// ```
  ///
  /// See also:
  ///   * [to], [toReplacement], [toNamedAndRemoveUntil], [back], and [canBack]
  static Future<T?> backAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) =>
      navigatorKey.currentState!.popAndPushNamed<T, TO>(
        routeName,
        result: result,
        arguments: arguments,
      );

  /// Navigates to a named route and returns a result when the route is popped.
  ///
  /// The `routeName` parameter specifies the name of the route to navigate to, and
  /// the optional `arguments` parameter is used to pass arguments to the pushed route.
  /// The method returns a [Future] that resolves to the result returned by the popped route.
  ///
  /// Example:
  /// ```dart
  /// String? result = await NavigationHelper.toNamed<String>(
  ///   'new_route',
  ///   arguments: {'key': 'value'},
  /// );
  /// ```
  ///
  /// See also:
  ///   * [to], [toReplacement], [back], and [canBack]
  static Future<T?> toNamed<T>(String routeName, {Object? arguments}) => navigatorKey.currentState!.pushNamed<T>(routeName, arguments: arguments);

  /// Navigates to a new route and removes routes until a specific condition is met.
  ///
  /// The `newRoute` parameter specifies the route to navigate to, and the `predicate`
  /// parameter is a function that determines when the navigation should stop. It should
  /// return `true` for the routes that need to be removed. The optional `arguments` parameter
  /// is used to pass arguments to the pushed route.
  ///
  /// Example:
  /// ```dart
  /// Future<int?> result = NavigationHelper.toAndRemoveUntil<int>(
  ///   newRoute,
  ///   (route) => route.settings.name == 'desired_route',
  /// );
  /// ```
  ///
  /// See also:
  ///   * [to], [toReplacement], [back], [backUntil], and [canBack]
  static Future<T?> toAndRemoveUntil<T>(Route<T> newRoute, bool Function(Route<dynamic> route) predicate) => navigatorKey.currentState!.pushAndRemoveUntil<T>(newRoute, predicate);

  /// Navigates to a named route and removes routes until a specific condition is met.
  ///
  /// The `newRouteName` parameter specifies the name of the route to navigate to, and
  /// the `predicate` parameter is a function that determines when the navigation should
  /// stop. It should return `true` for the routes that need to be removed. The optional
  /// `arguments` parameter is used to pass arguments to the pushed route.
  ///
  /// Example:
  /// ```dart
  /// Future<int?> result = NavigationHelper.toNamedAndRemoveUntil<int>(
  ///   'new_route',
  ///   (route) => route.settings.name == 'desired_route',
  ///   arguments: {'key': 'value'},
  /// );
  /// ```
  ///
  /// See also:
  ///   * [to], [toReplacement], [back], [backUntil], and [canBack]
  static Future<T?> toNamedAndRemoveUntil<T>(String newRouteName, bool Function(Route<dynamic> route) predicate, Object? arguments) => navigatorKey.currentState!.pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);

  /// Checks if there is at least one route that can be popped from the navigation stack.
  ///
  /// Returns `true` if there is a route that can be popped, otherwise `false`.
  ///
  /// Example:
  /// ```dart
  /// if (NavigationHelper.canBack()) {
  ///   NavigationHelper.back();
  /// } else {
  ///   // Handle the situation when there is no route to pop.
  /// }
  /// ```
  ///
  /// See also:
  ///   * [to], [toReplacement], and [back]
  static bool canBack() => navigatorKey.currentState!.canPop();

  /// Displays an AboutDialog to show information about the application.
  ///
  /// The `showAboutDialog` method displays an [AboutDialog], which shows information
  /// about the application, including the application name, version, icon, and
  /// legal text. Additional custom widgets can also be added to the dialog using
  /// the `children` parameter. The method can be used to display the dialog on the
  /// root navigator or not, depending on the value of the `useRootNavigator` parameter.
  ///
  /// Example:
  /// ```dart
  /// NavigationHelper.showAboutDialog(
  ///   applicationName: 'MyApp',
  ///   applicationVersion: '1.0.0',
  ///   applicationIcon: Icon(Icons.info),
  ///   applicationLegalese: '© 2023 MyCompany, Inc.',
  ///   useRootNavigator: true,
  /// );
  /// ```
  ///
  /// See also:
  ///   * [showLicensePage], [showDialog], and [showGeneralDialog]
  static void showAboutDialog({
    String? applicationName,
    String? applicationVersion,
    material.Widget? applicationIcon,
    String? applicationLegalese,
    List<material.Widget>? children,
    bool useRootNavigator = true,
    material.RouteSettings? routeSettings,
    material.Offset? anchorPoint,
  }) =>
      material.showAboutDialog(
        context: navigatorKey.currentContext!,
        applicationName: applicationName,
        applicationVersion: applicationVersion,
        applicationIcon: applicationIcon,
        applicationLegalese: applicationLegalese,
        children: children,
        useRootNavigator: useRootNavigator,
        routeSettings: routeSettings,
        anchorPoint: anchorPoint,
      );

  /// Displays a license page with information about the licenses used by the application.
  ///
  /// The `showLicensePage` method displays a [LicensePage], which shows information
  /// about the licenses used by the application. The method can be used to display
  /// the license page on the root navigator or not, depending on the value of the
  /// `useRootNavigator` parameter.
  ///
  /// Example:
  /// ```dart
  /// NavigationHelper.showLicensePage(
  ///   applicationName: 'MyApp',
  ///   applicationVersion: '1.0.0',
  ///   applicationIcon: Icon(Icons.info),
  ///   applicationLegalese: '© 2023 MyCompany, Inc.',
  ///   useRootNavigator: false,
  /// );
  /// ```
  ///
  /// See also:
  ///   * [showAboutDialog], [showDialog], and [showGeneralDialog]
  static void showLicensePage({
    String? applicationName,
    String? applicationVersion,
    material.Widget? applicationIcon,
    String? applicationLegalese,
    bool useRootNavigator = false,
  }) =>
      material.showLicensePage(
        context: navigatorKey.currentContext!,
        applicationName: applicationName,
        applicationVersion: applicationVersion,
        applicationIcon: applicationIcon,
        applicationLegalese: applicationLegalese,
        useRootNavigator: useRootNavigator,
      );

  /// Shows a bottom sheet and returns a controller to manipulate the bottom sheet.
  ///
  /// The `showBottomSheet` method displays a bottom sheet with the content provided
  /// by the `builder` parameter. It returns a [PersistentBottomSheetController] that
  /// can be used to close, hide, or update the bottom sheet programmatically.
  ///
  /// Example:
  /// ```dart
  /// PersistentBottomSheetController<int> controller = NavigationHelper.showBottomSheet<int>(
  ///   builder: (context) => Container(
  ///     height: 200,
  ///     child: Center(child: Text('This is a bottom sheet')),
  ///   ),
  /// );
  /// ```
  ///
  /// See also:
  ///   * [showModalBottomSheet], [showDialog], and [showGeneralDialog]
  static material.PersistentBottomSheetController<T> showBottomSheet<T>({
    required material.Widget Function(material.BuildContext context) builder,
    material.Color? backgroundColor,
    double? elevation,
    material.ShapeBorder? shape,
    material.Clip? clipBehavior,
    material.BoxConstraints? constraints,
    bool? enableDrag,
    material.AnimationController? transitionAnimationController,
  }) =>
      material.showBottomSheet<T>(
        context: navigatorKey.currentContext!,
        builder: builder,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        constraints: constraints,
        enableDrag: enableDrag,
        transitionAnimationController: transitionAnimationController,
      );

  /// Shows a date picker dialog and returns the selected date.
  ///
  /// The `showDatePicker` method displays a date picker dialog, which allows the user
  /// to select a date from a calendar. The method returns a [Future] that resolves to
  /// the selected [DateTime] when the user confirms the selection.
  ///
  /// Example:
  /// ```dart
  /// DateTime selectedDate = await NavigationHelper.showDatePicker(
  ///   initialDate: DateTime.now(),
  ///   firstDate: DateTime(2023),
  ///   lastDate: DateTime(2024),
  ///   helpText: 'Select a date',
  /// );
  /// ```
  ///
  /// See also:
  ///   * [showDateRangePicker], [showDialog], and [showGeneralDialog]
  static Future<DateTime?> showDatePicker({
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? currentDate,
    material.DatePickerEntryMode initialEntryMode = material.DatePickerEntryMode.calendar,
    bool Function(DateTime day)? selectableDayPredicate,
    String? helpText,
    String? cancelText,
    String? confirmText,
    material.Locale? locale,
    bool useRootNavigator = true,
    material.RouteSettings? routeSettings,
    material.TextDirection? textDirection,
    material.Widget Function(material.BuildContext context, material.Widget? child)? builder,
    material.DatePickerMode initialDatePickerMode = material.DatePickerMode.day,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
    material.TextInputType? keyboardType,
    material.Offset? anchorPoint,
    void Function(material.DatePickerEntryMode)? onDatePickerModeChange,
  }) =>
      material.showDatePicker(
        context: navigatorKey.currentContext!,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        currentDate: currentDate,
        initialEntryMode: initialEntryMode,
        selectableDayPredicate: selectableDayPredicate,
        helpText: helpText,
        cancelText: cancelText,
        confirmText: confirmText,
        locale: locale,
        useRootNavigator: useRootNavigator,
        routeSettings: routeSettings,
        textDirection: textDirection,
        builder: builder,
        initialDatePickerMode: initialDatePickerMode,
        errorFormatText: errorFormatText,
        errorInvalidText: errorInvalidText,
        fieldHintText: fieldHintText,
        fieldLabelText: fieldLabelText,
        keyboardType: keyboardType,
        anchorPoint: anchorPoint,
        onDatePickerModeChange: onDatePickerModeChange,
      );

  /// Shows a date range picker dialog and returns the selected date range.
  ///
  /// The `showDateRangePicker` method displays a date range picker dialog, which allows
  /// the user to select a date range within a specified range of dates. The method returns
  /// a [Future] that resolves to the selected [DateTimeRange] when the user confirms the selection.
  ///
  /// Example:
  /// ```dart
  /// DateTimeRange selectedDateRange = await NavigationHelper.showDateRangePicker(
  ///   initialDateRange: DateTimeRange(
  ///     start: DateTime.now(),
  ///     end: DateTime.now().add(Duration(days: 7)),
  ///   ),
  ///   firstDate: DateTime.now(),
  ///   lastDate: DateTime.now().add(Duration(days: 365)),
  ///   helpText: 'Select a date range',
  /// );
  /// ```
  ///
  /// See also:
  ///   * [showDatePicker], [showDialog], and [showGeneralDialog]
  static Future<material.DateTimeRange?> showDateRangePicker({
    material.DateTimeRange? initialDateRange,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? currentDate,
    material.DatePickerEntryMode initialEntryMode = material.DatePickerEntryMode.calendar,
    String? helpText,
    String? cancelText,
    String? confirmText,
    String? saveText,
    String? errorFormatText,
    String? errorInvalidText,
    String? errorInvalidRangeText,
    String? fieldStartHintText,
    String? fieldEndHintText,
    String? fieldStartLabelText,
    String? fieldEndLabelText,
    material.Locale? locale,
    bool useRootNavigator = true,
    material.RouteSettings? routeSettings,
    material.TextDirection? textDirection,
    material.Widget Function(material.BuildContext context, material.Widget? child)? builder,
    material.Offset? anchorPoint,
    material.TextInputType keyboardType = material.TextInputType.datetime,
  }) =>
      material.showDateRangePicker(
        context: navigatorKey.currentContext!,
        initialDateRange: initialDateRange,
        firstDate: firstDate,
        lastDate: lastDate,
        currentDate: currentDate,
        initialEntryMode: initialEntryMode,
        helpText: helpText,
        cancelText: cancelText,
        confirmText: confirmText,
        saveText: saveText,
        errorFormatText: errorFormatText,
        errorInvalidText: errorInvalidText,
        errorInvalidRangeText: errorInvalidRangeText,
        fieldStartHintText: fieldStartHintText,
        fieldEndHintText: fieldEndHintText,
        fieldStartLabelText: fieldStartLabelText,
        fieldEndLabelText: fieldEndLabelText,
        locale: locale,
        useRootNavigator: useRootNavigator,
        routeSettings: routeSettings,
        textDirection: textDirection,
        builder: builder,
        anchorPoint: anchorPoint,
        keyboardType: keyboardType,
      );

  /// Shows a dialog with the provided content.
  ///
  /// The `showDialog` method displays a dialog box on top of the current context. The dialog
  /// contains the content built by the provided `builder` function. It returns a [Future] that
  /// resolves to the value returned when the dialog is dismissed.
  ///
  /// Example:
  /// ```dart
  /// String? result = await NavigationHelper.showDialog<String>(
  ///   builder: (context) => AlertDialog(
  ///     title: Text('Confirmation'),
  ///     content: Text('Are you sure you want to proceed?'),
  ///     actions: [
  ///       TextButton(
  ///         onPressed: () => NavigationHelper.back('Yes'),
  ///         child: Text('Yes'),
  ///       ),
  ///       TextButton(
  ///         onPressed: () => NavigationHelper.back('No'),
  ///         child: Text('No'),
  ///       ),
  ///     ],
  ///   ),
  /// );
  /// ```
  ///
  /// See also:
  ///   * [AlertDialog], [showGeneralDialog], and [showMaterialBanner]
  static Future<T?> showDialog<T>({
    required material.Widget Function(material.BuildContext context) builder,
    bool barrierDismissible = true,
    material.Color? barrierColor = material.Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    material.RouteSettings? routeSettings,
    material.Offset? anchorPoint,
    material.TraversalEdgeBehavior? traversalEdgeBehavior,
  }) =>
      material.showDialog<T>(
        context: navigatorKey.currentContext!,
        builder: builder,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        barrierLabel: barrierLabel,
        useSafeArea: useSafeArea,
        useRootNavigator: useRootNavigator,
        routeSettings: routeSettings,
        anchorPoint: anchorPoint,
        traversalEdgeBehavior: traversalEdgeBehavior,
      );

  /// Shows a general-purpose dialog.
  ///
  /// The `showGeneralDialog` method displays a dialog created by the `pageBuilder` parameter.
  /// This method provides more control over the appearance and behavior of the dialog compared
  /// to [showDialog]. It returns a [Future] that resolves to a value when the dialog is closed.
  ///
  /// Example:
  /// ```dart
  /// Future<int?> result = NavigationHelper.showGeneralDialog<int>(
  ///   pageBuilder: (context, animation1, animation2) => AlertDialog(
  ///     title: Text('Dialog Title'),
  ///     content: Text('This is a custom dialog'),
  ///     actions: [
  ///       TextButton(
  ///         onPressed: () => NavigationHelper.back(42),
  ///         child: Text('OK'),
  ///       ),
  ///     ],
  ///   ),
  /// );
  /// ```
  ///
  /// See also:
  ///   * [showDialog], [showBottomSheet], and [showDatePicker]
  static Future<T?> showGeneralDialog<T extends Object?>({
    required material.Widget Function(material.BuildContext context, material.Animation<double> animation, material.Animation<double> secondaryAnimation) pageBuilder,
    bool barrierDismissible = false,
    String? barrierLabel,
    material.Color barrierColor = const material.Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    material.Widget Function(material.BuildContext context, material.Animation<double> animation, material.Animation<double> secondaryAnimation, material.Widget child)? transitionBuilder,
    bool useRootNavigator = true,
    material.RouteSettings? routeSettings,
    material.Offset? anchorPoint,
  }) =>
      material.showGeneralDialog<T>(
        context: navigatorKey.currentContext!,
        pageBuilder: pageBuilder,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        barrierColor: barrierColor,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        useRootNavigator: useRootNavigator,
        routeSettings: routeSettings,
        anchorPoint: anchorPoint,
      );

  /// Shows a menu that contains a list of items at a specified position.
  ///
  /// The `showMenu` method displays a popup menu containing a list of items at the specified
  /// [position] in the screen. It returns a [Future] that resolves to the selected value when
  /// the user makes a selection from the menu.
  ///
  /// Example:
  /// ```dart
  /// PopupMenuItem<int> _buildMenuItem(int value, String label) {
  ///   return PopupMenuItem<int>(
  ///     value: value,
  ///     child: Text(label),
  ///   );
  /// }
  ///
  /// int? selectedValue = await NavigationHelper.showMenu<int>(
  ///   position: RelativeRect.fromLTRB(100, 100, 0, 0),
  ///   items: [
  ///     _buildMenuItem(1, 'Option 1'),
  ///     _buildMenuItem(2, 'Option 2'),
  ///     _buildMenuItem(3, 'Option 3'),
  ///   ],
  /// );
  /// ```
  ///
  /// See also:
  ///   * [PopupMenuButton], [showModalBottomSheet], and [showDatePicker]
  static Future<T?> showMenu<T>({
    required material.RelativeRect position,
    required List<material.PopupMenuEntry<T>> items,
    T? initialValue,
    double? elevation,
    material.Color? shadowColor,
    material.Color? surfaceTintColor,
    String? semanticLabel,
    material.ShapeBorder? shape,
    material.Color? color,
    bool useRootNavigator = false,
    material.BoxConstraints? constraints,
    material.Clip clipBehavior = material.Clip.none,
  }) =>
      material.showMenu<T>(
        context: navigatorKey.currentContext!,
        position: position,
        items: items,
        initialValue: initialValue,
        elevation: elevation,
        shadowColor: shadowColor,
        surfaceTintColor: surfaceTintColor,
        semanticLabel: semanticLabel,
        shape: shape,
        color: color,
        useRootNavigator: useRootNavigator,
        constraints: constraints,
        clipBehavior: clipBehavior,
      );

  /// Shows a modal bottom sheet.
  ///
  /// The `showModalBottomSheet` method displays a modal bottom sheet that slides up from the bottom
  /// of the screen. It returns a [Future] that resolves to the value returned when the bottom sheet
  /// is dismissed.
  ///
  /// Example:
  /// ```dart
  /// String? selectedOption = await NavigationHelper.showModalBottomSheet<String>(
  ///   builder: (context) => ListView(
  ///     children: [
  ///       ListTile(
  ///         title: Text('Option 1'),
  ///         onTap: () => NavigationHelper.back('Option 1'),
  ///       ),
  ///       ListTile(
  ///         title: Text('Option 2'),
  ///         onTap: () => NavigationHelper.back('Option 2'),
  ///       ),
  ///     ],
  ///   ),
  /// );
  /// ```
  ///
  /// See also:
  ///   * [showBottomSheet], [showDialog], and [showTimePicker]
  static Future<T?> showModalBottomSheet<T>({
    required material.Widget Function(material.BuildContext context) builder,
    material.Color? backgroundColor,
    double? elevation,
    material.ShapeBorder? shape,
    material.Clip? clipBehavior,
    material.BoxConstraints? constraints,
    material.Color? barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool? showDragHandle,
    bool useSafeArea = false,
    material.RouteSettings? routeSettings,
    material.AnimationController? transitionAnimationController,
    material.Offset? anchorPoint,
  }) =>
      material.showModalBottomSheet<T>(
        context: navigatorKey.currentContext!,
        builder: builder,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        constraints: constraints,
        barrierColor: barrierColor,
        isScrollControlled: isScrollControlled,
        useRootNavigator: useRootNavigator,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
        routeSettings: routeSettings,
        transitionAnimationController: transitionAnimationController,
        anchorPoint: anchorPoint,
      );

  /// Shows a search page that allows the user to search for items.
  ///
  /// The `showSearch` method displays a search page that allows the user to search for items
  /// using the provided [delegate]. It returns a [Future] that resolves to the selected value
  /// when the user confirms the search.
  ///
  /// Example:
  /// ```dart
  /// String? selectedResult = await NavigationHelper.showSearch<String>(
  ///   delegate: MySearchDelegate(),
  /// );
  /// ```
  ///
  /// See also:
  ///   * [SearchDelegate], [showDatePicker], and [showMenu]
  static Future<T?> showSearch<T>({
    required material.SearchDelegate<T> delegate,
    String? query = '',
    bool useRootNavigator = false,
  }) =>
      material.showSearch<T>(
        context: navigatorKey.currentContext!,
        delegate: delegate,
        query: query,
        useRootNavigator: useRootNavigator,
      );

  /// Shows a time picker dialog and returns the selected time.
  ///
  /// The `showTimePicker` method displays a time picker dialog, which allows the user to select
  /// a time. It returns a [Future] that resolves to the selected [TimeOfDay] when the user confirms
  /// the selection.
  ///
  /// Example:
  /// ```dart
  /// TimeOfDay selectedTime = await NavigationHelper.showTimePicker(
  ///   initialTime: TimeOfDay.now(),
  ///   helpText: 'Select a time',
  /// );
  /// ```
  ///
  /// See also:
  ///   * [showDatePicker], [showDialog], and [showTimeRangePicker]
  static Future<material.TimeOfDay?> showTimePicker({
    required material.TimeOfDay initialTime,
    material.Widget Function(material.BuildContext context, material.Widget? child)? builder,
    bool useRootNavigator = true,
    material.TimePickerEntryMode initialEntryMode = material.TimePickerEntryMode.dial,
    String? cancelText,
    String? confirmText,
    String? helpText,
    String? errorInvalidText,
    String? hourLabelText,
    String? minuteLabelText,
    material.RouteSettings? routeSettings,
    void Function(material.TimePickerEntryMode mode)? onEntryModeChanged,
    material.Offset? anchorPoint,
    material.Orientation? orientation,
  }) =>
      material.showTimePicker(
        context: navigatorKey.currentContext!,
        initialTime: initialTime,
        builder: builder,
        useRootNavigator: useRootNavigator,
        initialEntryMode: initialEntryMode,
        cancelText: cancelText,
        confirmText: confirmText,
        helpText: helpText,
        errorInvalidText: errorInvalidText,
        hourLabelText: hourLabelText,
        minuteLabelText: minuteLabelText,
        routeSettings: routeSettings,
        onEntryModeChanged: onEntryModeChanged,
        anchorPoint: anchorPoint,
        orientation: orientation,
      );

  /// Shows a SnackBar using the scaffold messenger key.
  ///
  /// A [SnackBar] is a small widget that appears at the bottom of the screen and
  /// provides a brief message to the user. The `snackBar` parameter specifies the
  /// content and properties of the SnackBar to be shown. The method returns a
  /// [ScaffoldFeatureController] that can be used to manage the SnackBar.
  ///
  /// Example:
  /// ```dart
  /// NavigationHelper.showSnackBar(
  ///   SnackBar(
  ///     content: Text('This is a SnackBar message'),
  ///   ),
  /// );
  /// ```
  ///
  /// See also:
  ///   * [hideCurrentSnackBar], [removeCurrentSnackBar], and [clearSnackBars]
  static material.ScaffoldFeatureController<material.SnackBar, material.SnackBarClosedReason> showSnackBar(material.SnackBar snackBar) => scaffoldMessengerKey.currentState!.showSnackBar(snackBar);

  /// Hides the current snack bar.
  ///
  /// The `hideCurrentSnackBar` method hides the current snack bar if it is visible on the screen.
  /// The optional [reason] parameter specifies the reason for hiding the snack bar.
  ///
  /// Example:
  /// ```dart
  /// NavigationHelper.hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
  /// ```
  ///
  /// See also:
  ///   * [showSnackBar], [removeCurrentSnackBar], and [clearSnackBars]
  static void hideCurrentSnackBar({material.SnackBarClosedReason reason = material.SnackBarClosedReason.hide}) => scaffoldMessengerKey.currentState!.hideCurrentSnackBar(reason: reason);

  /// Removes the current snack bar.
  ///
  /// The `removeCurrentSnackBar` method removes the current snack bar from the screen if it is visible.
  /// The optional [reason] parameter specifies the reason for removing the snack bar.
  ///
  /// Example:
  /// ```dart
  /// NavigationHelper.removeCurrentSnackBar(reason: SnackBarClosedReason.remove);
  /// ```
  ///
  /// See also:
  ///   * [showSnackBar], [hideCurrentSnackBar], and [clearSnackBars]
  static void removeCurrentSnackBar({material.SnackBarClosedReason reason = material.SnackBarClosedReason.remove}) => scaffoldMessengerKey.currentState!.removeCurrentSnackBar(reason: reason);

  /// Clears all currently displayed snack bars.
  ///
  /// The `clearSnackBars` method removes all currently displayed snack bars from the screen.
  ///
  /// Example:
  /// ```dart
  /// NavigationHelper.clearSnackBars();
  /// ```
  ///
  /// See also:
  ///   * [showSnackBar], [hideCurrentSnackBar], and [removeCurrentSnackBar]
  static void clearSnackBars() => scaffoldMessengerKey.currentState!.clearSnackBars();

  /// Shows a material banner at the top of the screen.
  ///
  /// The `showMaterialBanner` method displays a material banner at the top of the screen using
  /// the provided [MaterialBanner] widget. It returns a [ScaffoldFeatureController] that allows
  /// you to manage the material banner, such as hiding or removing it.
  ///
  /// Example:
  /// ```dart
  /// MaterialBanner materialBanner = MaterialBanner(
  ///   content: Text('This is a material banner'),
  ///   leading: Icon(Icons.info),
  ///   actions: [
  ///     TextButton(
  ///       onPressed: () => NavigationHelper.hideCurrentMaterialBanner(),
  ///       child: Text('HIDE'),
  ///     ),
  ///   ],
  /// );
  ///
  /// ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason> controller = NavigationHelper.showMaterialBanner(materialBanner);
  /// ```
  ///
  /// See also:
  ///   * [MaterialBanner], [hideCurrentMaterialBanner], and [removeCurrentMaterialBanner]
  static material.ScaffoldFeatureController<material.MaterialBanner, material.MaterialBannerClosedReason> showMaterialBanner(material.MaterialBanner materialBanner) => scaffoldMessengerKey.currentState!.showMaterialBanner(materialBanner);

  /// Hides the current material banner.
  ///
  /// The `hideCurrentMaterialBanner` method hides the current material banner if it is visible on the screen.
  /// The optional [reason] parameter specifies the reason for hiding the material banner.
  ///
  /// Example:
  /// ```dart
  /// NavigationHelper.hideCurrentMaterialBanner(reason: MaterialBannerClosedReason.hide);
  /// ```
  ///
  /// See also:
  ///   * [showMaterialBanner], [removeCurrentMaterialBanner], and [clearMaterialBanners]
  static void hideCurrentMaterialBanner({material.MaterialBannerClosedReason reason = material.MaterialBannerClosedReason.hide}) => scaffoldMessengerKey.currentState!.hideCurrentMaterialBanner(reason: reason);

  /// Removes the current material banner.
  ///
  /// The `removeCurrentMaterialBanner` method removes the current material banner from the screen if it is visible.
  /// The optional [reason] parameter specifies the reason for removing the material banner.
  ///
  /// Example:
  /// ```dart
  /// NavigationHelper.removeCurrentMaterialBanner(reason: MaterialBannerClosedReason.remove);
  /// ```
  ///
  /// See also:
  ///   * [showMaterialBanner], [hideCurrentMaterialBanner], and [clearMaterialBanners]
  static void removeCurrentMaterialBanner({material.MaterialBannerClosedReason reason = material.MaterialBannerClosedReason.remove}) => scaffoldMessengerKey.currentState!.removeCurrentMaterialBanner(reason: reason);

  /// Clears all currently displayed material banners.
  ///
  /// The `clearMaterialBanners` method removes all currently displayed material banners from the screen.
  ///
  /// Example:
  /// ```dart
  /// NavigationHelper.clearMaterialBanners();
  /// ```
  ///
  /// See also:
  ///   * [showMaterialBanner], [hideCurrentMaterialBanner], and [removeCurrentMaterialBanner]
  static void clearMaterialBanners() => scaffoldMessengerKey.currentState!.clearMaterialBanners();
}
