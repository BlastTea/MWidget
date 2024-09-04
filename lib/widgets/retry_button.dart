part of 'widgets.dart';

/// A widget that displays a retry button along with an optional additional message.
///
/// The `RetryButton` widget provides a convenient way to display a retry button for retrying failed actions or
/// fetching data. It can be used to enhance the user experience when dealing with errors or network issues.
///
/// Example usage:
///
/// ```dart
/// RetryButton(
///   onRetryPressed: _fetchDataAgain,
///   titleText: 'Error fetching data',
///   additionalMessage: 'Please check your internet connection and try again.',
/// )
/// ```
class RetryButton extends StatelessWidget {
  /// Creates a `RetryButton` widget.
  ///
  /// The [onRetryPressed] callback function is triggered when the retry button is pressed.
  ///
  /// The [titleText] is the main title of the retry screen, describing the issue or error.
  ///
  /// The [additionalMessage] is an optional secondary message that provides more information about the error or issue.
  const RetryButton({
    super.key,
    this.onRetryPressed,
    required this.titleText,
    this.additionalMessage,
  });

  /// Callback function triggered when the retry button is pressed.
  final void Function()? onRetryPressed;

  /// The main title of the retry screen, describing the issue or error.
  final String titleText;

  /// An optional secondary message that provides more information about the error or issue.
  final String? additionalMessage;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titleText,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (additionalMessage != null) ...[
              const SizedBox(height: 8.0),
              Text(
                additionalMessage!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
            const SizedBox(height: 8.0),
            FilledButton.icon(
              onPressed: onRetryPressed,
              label: Text('Retry'.tr),
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      );
}
