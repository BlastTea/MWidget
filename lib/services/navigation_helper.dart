part of 'services.dart';

final material.GlobalKey<material.NavigatorState> navigatorKey = material.GlobalKey<material.NavigatorState>();
final material.GlobalKey<material.ScaffoldMessengerState> scaffoldMessengerKey = material.GlobalKey<material.ScaffoldMessengerState>();

class NavigationHelper {
  static Future<T?> to<T extends Object?>(material.Route<T> route) => navigatorKey.currentState!.push<T>(route);

  static Future<T?> toReplacement<T extends Object?, TO extends Object?>(
    material.Route<T> newRoute, {
    TO? result,
  }) =>
      navigatorKey.currentState!.pushReplacement<T, TO>(
        newRoute,
        result: result,
      );

  static void back<T extends Object?>([T? result]) => navigatorKey.currentState!.pop<T>(result);

  static bool canBack() => navigatorKey.currentState!.canPop();

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

  static material.PersistentBottomSheetController<T> showBottomSheet<T>({
    required material.Widget Function(material.BuildContext) builder,
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

  static Future<DateTime?> showDatePicker({
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? currentDate,
    material.DatePickerEntryMode initialEntryMode = material.DatePickerEntryMode.calendar,
    bool Function(DateTime)? selectableDayPredicate,
    String? helpText,
    String? cancelText,
    String? confirmText,
    material.Locale? locale,
    bool useRootNavigator = true,
    material.RouteSettings? routeSettings,
    material.TextDirection? textDirection,
    material.Widget Function(material.BuildContext, material.Widget?)? builder,
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
    material.Widget Function(material.BuildContext, material.Widget?)? builder,
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

  static Future<T?> showDialog<T>({
    required material.Widget Function(material.BuildContext) builder,
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

  static Future<T?> showGeneralDialog<T extends Object?>({
    required material.Widget Function(material.BuildContext, material.Animation<double>, material.Animation<double>) pageBuilder,
    bool barrierDismissible = false,
    String? barrierLabel,
    material.Color barrierColor = const material.Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    material.Widget Function(material.BuildContext, material.Animation<double>, material.Animation<double>, material.Widget)? transitionBuilder,
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

  static Future<T?> showModalBottomSheet<T>({
    required material.Widget Function(material.BuildContext) builder,
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

  static Future<material.TimeOfDay?> showTimePicker({
    required material.TimeOfDay initialTime,
    material.Widget Function(material.BuildContext, material.Widget?)? builder,
    bool useRootNavigator = true,
    material.TimePickerEntryMode initialEntryMode = material.TimePickerEntryMode.dial,
    String? cancelText,
    String? confirmText,
    String? helpText,
    String? errorInvalidText,
    String? hourLabelText,
    String? minuteLabelText,
    material.RouteSettings? routeSettings,
    void Function(material.TimePickerEntryMode)? onEntryModeChanged,
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

  static material.ScaffoldFeatureController<material.SnackBar, material.SnackBarClosedReason> showSnackBar(material.SnackBar snackBar) => scaffoldMessengerKey.currentState!.showSnackBar(snackBar);

  static void hideCurrentSnackBar({material.SnackBarClosedReason reason = material.SnackBarClosedReason.hide}) => scaffoldMessengerKey.currentState!.hideCurrentSnackBar(reason: reason);

  static void removeCurrentSnackBar({material.SnackBarClosedReason reason = material.SnackBarClosedReason.remove}) => scaffoldMessengerKey.currentState!.removeCurrentSnackBar(reason: reason);

  static void clearSnackBars() => scaffoldMessengerKey.currentState!.clearSnackBars();

  static material.ScaffoldFeatureController<material.MaterialBanner, material.MaterialBannerClosedReason> showMaterialBanner(material.MaterialBanner materialBanner) => scaffoldMessengerKey.currentState!.showMaterialBanner(materialBanner);

  static void hideCurrentMaterialBanner({material.MaterialBannerClosedReason reason = material.MaterialBannerClosedReason.hide}) => scaffoldMessengerKey.currentState!.hideCurrentMaterialBanner(reason: reason);

  static void removeCurrentMaterialBanner({material.MaterialBannerClosedReason reason = material.MaterialBannerClosedReason.remove}) => scaffoldMessengerKey.currentState!.removeCurrentMaterialBanner(reason: reason);

  static void clearMaterialBanners() => scaffoldMessengerKey.currentState!.clearMaterialBanners();
}
