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
    NavigationHelper.showDialog(
      builder: (context) => AlertDialog(
        title: Text(titleText ?? MWidgetTheme.of(context)?.dialogTheme.errorTitleText ?? Language.getInstance().getValue('Error')!),
        titleTextStyle: titleTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.titleTextStyle,
        content: SelectableText(messageText),
        contentTextStyle: messageTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.messageTextStyle,
        actions: [
          (primaryFilledButton ?? MWidgetTheme.of(context)?.dialogTheme.primaryFilledButton ?? false)
              ? FilledButton(
                  autofocus: true,
                  onPressed: () => NavigationHelper.back(),
                  child: Text(Language.getInstance().getValue('Ok')!),
                )
              : TextButton(
                  autofocus: true,
                  onPressed: () => NavigationHelper.back(),
                  child: Text(Language.getInstance().getValue('Ok')!),
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
    NavigationHelper.showDialog(
      builder: (context) => AlertDialog(
        title: Text(titleText ?? MWidgetTheme.of(context)?.dialogTheme.warningTitleText ?? Language.getInstance().getValue('Warning')!),
        titleTextStyle: titleTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.titleTextStyle,
        content: SelectableText(messageText),
        contentTextStyle: messageTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.messageTextStyle,
        actions: [
          (primaryFilledButton ?? MWidgetTheme.of(context)?.dialogTheme.primaryFilledButton ?? false)
              ? FilledButton(
                  autofocus: true,
                  onPressed: () => NavigationHelper.back(),
                  child: Text(Language.getInstance().getValue('Ok')!),
                )
              : TextButton(
                  autofocus: true,
                  onPressed: () => NavigationHelper.back(),
                  child: Text(Language.getInstance().getValue('Ok')!),
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
    NavigationHelper.showDialog(
      builder: (context) => AlertDialog(
        title: Text(titleText ?? MWidgetTheme.of(context)?.dialogTheme.informationTitleText ?? Language.getInstance().getValue('Information')!),
        titleTextStyle: titleTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.titleTextStyle,
        content: SelectableText(messageText),
        contentTextStyle: messageTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.messageTextStyle,
        actions: [
          (primaryFilledButton ?? MWidgetTheme.of(context)?.dialogTheme.primaryFilledButton ?? false)
              ? FilledButton(
                  autofocus: true,
                  onPressed: () => NavigationHelper.back(),
                  child: Text(Language.getInstance().getValue('Ok')!),
                )
              : TextButton(
                  autofocus: true,
                  onPressed: () => NavigationHelper.back(),
                  child: Text(Language.getInstance().getValue('Ok')!),
                ),
        ],
      ),
    );

/// Displays a loading dialog with a progress indicator.
Future<void> showLoadingDialog() => NavigationHelper.showDialog(
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
    NavigationHelper.showDialog(
      builder: (context) => AlertDialog(
        title: Text(titleText ?? MWidgetTheme.of(context)?.dialogTheme.saveChangesTitleText ?? Language.getInstance().getValue('Save changes?')!),
        actions: [
          TextButton(
            onPressed: () => NavigationHelper.back(false),
            child: Text(Language.getInstance().getValue('Don\'t save')!),
          ),
          (primaryFilledButton ?? MWidgetTheme.of(context)?.dialogTheme.primaryFilledButton ?? false)
              ? FilledButton(
                  onPressed: () => NavigationHelper.back(true),
                  child: Text(Language.getInstance().getValue('Save')!),
                )
              : TextButton(
                  onPressed: () => NavigationHelper.back(true),
                  child: Text(Language.getInstance().getValue('Save')!),
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
    NavigationHelper.showDialog(
      builder: (context) => AlertDialog(
        title: titleText != null ? Text(titleText) : null,
        titleTextStyle: titleTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.titleTextStyle,
        content: messageText != null ? Text(messageText) : null,
        contentTextStyle: messageTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.messageTextStyle,
        actions: [
          TextButton(
            onPressed: () => NavigationHelper.back(false),
            child: Text(Language.getInstance().getValue('No')!),
          ),
          (primaryFilledButton ?? MWidgetTheme.of(context)?.dialogTheme.primaryFilledButton ?? false)
              ? FilledButton(
                  onPressed: () => NavigationHelper.back(true),
                  child: Text(Language.getInstance().getValue('Yes')!),
                )
              : TextButton(
                  onPressed: () => NavigationHelper.back(true),
                  child: Text(Language.getInstance().getValue('Yes')!),
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
    NavigationHelper.showDialog(
      builder: (context) => AlertDialog(
        title: titleText != null ? Text(titleText) : null,
        titleTextStyle: titleTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.titleTextStyle,
        content: messageText != null ? Text(messageText) : null,
        contentTextStyle: messageTextStyle ?? MWidgetTheme.of(context)?.dialogTheme.messageTextStyle,
        actions: [
          TextButton(
            onPressed: () => NavigationHelper.back(false),
            child: Text(Language.getInstance().getValue('Cancel')!),
          ),
          (primaryFilledButton ?? MWidgetTheme.of(context)?.dialogTheme.primaryFilledButton ?? false)
              ? FilledButton(
                  onPressed: () => NavigationHelper.back(true),
                  child: Text(Language.getInstance().getValue('Delete')!),
                )
              : TextButton(
                  onPressed: () => NavigationHelper.back(true),
                  child: Text(Language.getInstance().getValue('Delete')!),
                ),
        ],
      ),
    );
