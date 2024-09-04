part of 'utils.dart';

/// Displays an error dialog with the provided message.
///
/// The [messageText] parameter is the error message to display.
Future<void> showErrorDialog(
  String messageText, {
  String? titleText,
  TextStyle? titleTextStyle,
  TextStyle? messageTextStyle,
  bool? primaryFilledButton,
}) =>
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Text(titleText ?? MWidgetTheme.of(context)?.dialogTheme.errorTitleText ?? 'Error'.tr),
        titleTextStyle: titleTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.titleTextStyle,
        content: MWidgetTheme.of(context)?.dialogTheme.onRenderMessage?.call(context, messageText) ?? SelectableText(messageText),
        contentTextStyle: messageTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.messageTextStyle,
        actions: [
          (primaryFilledButton ?? MWidgetTheme.of(context)?.dialogTheme.primaryFilledButton ?? false)
              ? FilledButton(
                  autofocus: true,
                  onPressed: () => Get.back(),
                  child: Text('Ok'.tr),
                )
              : TextButton(
                  autofocus: true,
                  onPressed: () => Get.back(),
                  child: Text('Ok'.tr),
                ),
        ],
      ),
    );

/// Displays a warning dialog with the provided message.
///
/// The [messageText] parameter is the warning message to display.
Future<void> showWarningDialog(
  String messageText, {
  String? titleText,
  TextStyle? titleTextStyle,
  TextStyle? messageTextStyle,
  bool? primaryFilledButton,
}) =>
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Text(titleText ?? MWidgetTheme.of(context)?.dialogTheme.warningTitleText ?? 'Warning'.tr),
        titleTextStyle: titleTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.titleTextStyle,
        content: MWidgetTheme.of(context)?.dialogTheme.onRenderMessage?.call(Get.context!, messageText) ?? SelectableText(messageText),
        contentTextStyle: messageTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.messageTextStyle,
        actions: [
          (primaryFilledButton ?? MWidgetTheme.of(context)?.dialogTheme.primaryFilledButton ?? false)
              ? FilledButton(
                  autofocus: true,
                  onPressed: () => Get.back(),
                  child: Text('Ok'.tr),
                )
              : TextButton(
                  autofocus: true,
                  onPressed: () => Get.back(),
                  child: Text('Ok'.tr),
                ),
        ],
      ),
    );

Future<void> showInformationDialog(
  String messageText, {
  String? titleText,
  TextStyle? titleTextStyle,
  TextStyle? messageTextStyle,
  bool? primaryFilledButton,
}) =>
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Text(titleText ?? MWidgetTheme.of(context)?.dialogTheme.informationTitleText ?? 'Information'.tr),
        titleTextStyle: titleTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.titleTextStyle,
        content: MWidgetTheme.of(context)?.dialogTheme.onRenderMessage?.call(context, messageText) ?? SelectableText(messageText),
        contentTextStyle: messageTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.messageTextStyle,
        actions: [
          (primaryFilledButton ?? MWidgetTheme.of(context)?.dialogTheme.primaryFilledButton ?? false)
              ? FilledButton(
                  autofocus: true,
                  onPressed: () => Get.back(),
                  child: Text('Ok'.tr),
                )
              : TextButton(
                  autofocus: true,
                  onPressed: () => Get.back(),
                  child: Text('Ok'.tr),
                ),
        ],
      ),
    );

/// Displays a loading dialog with a progress indicator.
Future<void> showLoadingDialog() => showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

/// Displays a dialog asking whether to save changes.
///
/// Returns the user's decision (true for Save, false for Don't Save, null if the user close the dialog).
Future<bool?> showSaveChangesDialog({
  String? titleText,
  TextStyle? titleTextStyle,
  bool? primaryFilledButton,
}) =>
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Text(titleText ?? MWidgetTheme.of(context)?.dialogTheme.saveChangesTitleText ?? 'Save changes?'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('Don\'t save'.tr),
          ),
          (primaryFilledButton ?? MWidgetTheme.of(context)?.dialogTheme.primaryFilledButton ?? false)
              ? FilledButton(
                  onPressed: () => Get.back(result: true),
                  child: Text('Save'.tr),
                )
              : TextButton(
                  onPressed: () => Get.back(result: true),
                  child: Text('Save'.tr),
                ),
        ],
      ),
    );

Future<bool?> showYesOrNoDialog({
  String? titleText,
  String? messageText,
  TextStyle? titleTextStyle,
  TextStyle? messageTextStyle,
  bool? primaryFilledButton,
}) =>
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: titleText != null ? Text(titleText) : null,
        titleTextStyle: titleTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.titleTextStyle,
        content: messageText != null ? MWidgetTheme.of(context)?.dialogTheme.onRenderMessage?.call(context, messageText) ?? Text(messageText) : null,
        contentTextStyle: messageTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.messageTextStyle,
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('No'.tr),
          ),
          (primaryFilledButton ?? MWidgetTheme.of(context)?.dialogTheme.primaryFilledButton ?? false)
              ? FilledButton(
                  onPressed: () => Get.back(result: true),
                  child: Text('Yes'.tr),
                )
              : TextButton(
                  onPressed: () => Get.back(result: true),
                  child: Text('Yes'.tr),
                ),
        ],
      ),
    );

Future<bool?> showDeleteDialog({
  String? titleText,
  String? messageText,
  TextStyle? titleTextStyle,
  TextStyle? messageTextStyle,
  bool? primaryFilledButton,
}) =>
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: titleText != null ? Text(titleText) : null,
        titleTextStyle: titleTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.titleTextStyle,
        content: messageText != null ? MWidgetTheme.of(context)?.dialogTheme.onRenderMessage?.call(context, messageText) ?? Text(messageText) : null,
        contentTextStyle: messageTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.messageTextStyle,
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('Cancel'.tr),
          ),
          (primaryFilledButton ?? MWidgetTheme.of(context)?.dialogTheme.primaryFilledButton ?? false)
              ? FilledButton(
                  onPressed: () => Get.back(result: true),
                  child: Text('Delete'.tr),
                )
              : TextButton(
                  onPressed: () => Get.back(result: true),
                  child: Text('Delete'.tr),
                ),
        ],
      ),
    );

Future<bool?> showContinueOrCancelDialog({
  String? titleText,
  String? messageText,
  TextStyle? titleTextStyle,
  TextStyle? messageTextStyle,
  bool? primaryFilledButton,
}) =>
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: titleText != null ? Text(titleText) : null,
        titleTextStyle: titleTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.titleTextStyle,
        content: messageText != null ? MWidgetTheme.of(context)?.dialogTheme.onRenderMessage?.call(context, messageText) ?? Text(messageText) : null,
        contentTextStyle: messageTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.messageTextStyle,
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('Cancel'.tr),
          ),
          (primaryFilledButton ?? MWidgetTheme.of(context)?.dialogTheme.primaryFilledButton ?? false)
              ? FilledButton(
                  onPressed: () => Get.back(result: true),
                  child: Text('Continue'.tr),
                )
              : TextButton(
                  onPressed: () => Get.back(result: true),
                  child: Text('Continue'.tr),
                ),
        ],
      ),
    );
