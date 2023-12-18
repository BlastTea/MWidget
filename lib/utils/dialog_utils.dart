part of 'utils.dart';

/// Displays an error dialog with the provided message.
///
/// The [message] parameter is the error message to display.
Future<void> showErrorDialog(String message, String? titleText, bool? useFilledButton) => NavigationHelper.showDialog(
      builder: (context) => AlertDialog(
        title: Text(titleText ?? MWidgetTheme.of(context)?.errorDialogTheme.titleText ?? Language.getInstance().getValue('Error')!),
        content: SelectableText(message),
        actions: [
          (useFilledButton ?? MWidgetTheme.of(context)?.errorDialogTheme.useFilledButton ?? false)
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
/// The [message] parameter is the warning message to display.
Future<void> showWarningDialog(String message) => NavigationHelper.showDialog(
      builder: (context) => AlertDialog(
        title: Text(Language.getInstance().getValue('Warning')!),
        content: SelectableText(message),
        actions: [
          TextButton(
            autofocus: true,
            onPressed: () => NavigationHelper.back(),
            child: Text(Language.getInstance().getValue('Ok')!),
          ),
        ],
      ),
    );

Future<void> showInformationDialog(String message) => NavigationHelper.showDialog(
      builder: (context) => AlertDialog(
        title: Text(Language.getInstance().getValue('Information')!),
        content: SelectableText(message),
        actions: [
          TextButton(
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
Future<bool?> showSaveChangesDialog() => NavigationHelper.showDialog(
      builder: (context) => AlertDialog(
        title: Text(Language.getInstance().getValue('Save changes?')!),
        actions: [
          TextButton(
            onPressed: () => NavigationHelper.back(false),
            child: Text(Language.getInstance().getValue('Don\'t save')!),
          ),
          TextButton(
            onPressed: () => NavigationHelper.back(true),
            child: Text(Language.getInstance().getValue('Save')!),
          ),
        ],
      ),
    );

Future<bool?> showYesOrNoDialog({
  String? titleText,
  String? contentText,
}) =>
    NavigationHelper.showDialog(
      builder: (context) => AlertDialog(
        title: titleText != null ? Text(titleText) : null,
        content: contentText != null ? Text(contentText) : null,
        actions: [
          TextButton(
            onPressed: () => NavigationHelper.back(false),
            child: Text(Language.getInstance().getValue('No')!),
          ),
          TextButton(
            onPressed: () => NavigationHelper.back(true),
            child: Text(Language.getInstance().getValue('Yes')!),
          ),
        ],
      ),
    );
