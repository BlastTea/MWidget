part of 'widgets.dart';

/// A widget that displays a retry button along with an error message.
///
/// The `ErrorOccuredButton` widget provides a convenient way to present an error message along with a retry button.
/// It can be used to handle error scenarios and guide the user toward retrying a failed action.
///
/// Example usage:
///
/// ```dart
/// ErrorOccuredButton(
///   onRetryPressed: _fetchDataAgain,
///   errorMessage: 'Failed to load data from the server.',
/// )
/// ```
class ErrorOccuredButton extends StatelessWidget {
  /// Creates an `ErrorOccuredButton` widget.
  ///
  /// The [onRetryPressed] callback function is triggered when the retry button is pressed.
  ///
  /// The [errorMessage] is the text that describes the error or issue that occurred.
  const ErrorOccuredButton({
    super.key,
    this.onRetryPressed,
    this.errorMessage,
  });

  /// Callback function triggered when the retry button is pressed.
  final void Function()? onRetryPressed;

  /// The text that describes the error or issue that occurred.
  final String? errorMessage;

  @override
  Widget build(BuildContext context) => RetryButton(
        titleText: 'An error occured!'.tr,
        additionalMessage: errorMessage,
        onRetryPressed: onRetryPressed,
      );
}
