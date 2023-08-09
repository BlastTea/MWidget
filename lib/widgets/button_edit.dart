part of 'widgets.dart';

/// A custom button widget designed for editing actions.
///
/// This widget displays a row of buttons commonly used for editing purposes.
/// It consists of a primary button on the left side and a set of secondary
/// buttons on the right side.
///
/// The primary button can be customized using the [trailing] parameter,
/// which allows you to place any widget on the left side of the button row.
///
/// The secondary buttons include icons for actions such as clearing the input,
/// deleting content, and saving changes. You can specify callback functions
/// for each of these actions using the [onClearPressed], [onDeletePressed],
/// and [onSavePressed] parameters.
///
/// Example usage:
///
/// ```dart
/// ButtonEdit(
///   trailing: Icon(Icons.info),
///   onClearPressed: () {
///     // Perform clear action
///   },
///   onDeletePressed: () {
///     // Perform delete action
///   },
///   onSavePressed: () {
///     // Perform save action
///   },
/// )
/// ```
class ButtonEdit extends StatelessWidget {
  /// Creates a [ButtonEdit] widget.
  ///
  /// The [trailing] parameter allows you to place a widget on the left side
  /// of the button row. If not specified, an empty container is used.
  ///
  /// The [onClearPressed], [onDeletePressed], and [onSavePressed] parameters
  /// are callback functions that get triggered when the respective buttons
  /// are pressed.
  const ButtonEdit({
    super.key,
    this.trailing,
    this.onClearPresssed,
    this.onDeletePressed,
    this.onSavePressed,
  });

  /// The widget to be displayed on the left side of the button row.
  final Widget? trailing;

  /// Callback function for the clear action button.
  final void Function()? onClearPresssed;

  /// Callback function for the delete action button.
  final void Function()? onDeletePressed;

  /// Callback function for the save action button.
  final void Function()? onSavePressed;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: trailing ?? Container(),
          ),
          const SizedBox(width: 8.0),
          Row(
            children: [
              IconButton.outlined(
                onPressed: onClearPresssed,
                icon: const Icon(Icons.clear),
                tooltip: Language.getInstance().getValue('Cancel'),
              ),
              IconButton.outlined(
                onPressed: onDeletePressed,
                icon: const Icon(Icons.delete),
                tooltip: Language.getInstance().getValue('Delete'),
              ),
              IconButton.outlined(
                onPressed: onSavePressed,
                icon: const Icon(Icons.save),
                tooltip: Language.getInstance().getValue('Save'),
              ),
            ],
          ),
        ],
      );
}
