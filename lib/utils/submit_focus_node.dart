part of 'utils.dart';

/// A custom [FocusNode] that handles submission on `ENTER` and other key events.
///
/// This [FocusNode] subclass allows capturing key events and performing custom
/// actions when the user presses the `ENTER` key without the `SHIFT` modifier.
/// Additionally, it can be configured with an optional onKey callback to handle
/// other key events as needed. Furthermore, you can provide an onEnterPressed
/// callback to be invoked when the user presses the `ENTER` key without `SHIFT`.
///
/// This class provides extended functionality for handling the `ENTER` key and
/// simplifies the handling of submission actions and other custom key events.
class SubmitFocusNode extends FocusNode {
  /// Creates a [SubmitFocusNode] with optional configurations.
  ///
  /// - [debugLabel] is an optional description of the focus node for debugging purposes.
  /// - [onKey] is an optional callback that allows handling custom key events.
  /// - [onEnterPressed] is an optional callback to be invoked when the `ENTER` key is pressed.
  /// - [skipTraversal] determines whether the focus node should skip focus traversal.
  /// - [canRequestFocus] determines whether the focus node can request focus.
  /// - [descendantsAreFocusable] determines whether the focus node's descendants are focusable.
  /// - [descendantsAreTraversable] determines whether the focus node's descendants are traversable.
  SubmitFocusNode({
    super.debugLabel,
    KeyEventResult Function(FocusNode node, KeyEvent event)? onKeyEvent,
    @Deprecated('Use onKeyEvent instead') KeyEventResult Function(FocusNode, RawKeyEvent)? onKey,
    VoidCallback? onEnterPressed,
    super.skipTraversal = false,
    super.canRequestFocus = true,
    super.descendantsAreFocusable = true,
    super.descendantsAreTraversable = true,
  }) : super(
          onKeyEvent: (node, event) {
            if (!HardwareKeyboard.instance.isShiftPressed && HardwareKeyboard.instance.isLogicalKeyPressed(LogicalKeyboardKey.enter)) {
              if (event is KeyDownEvent) {
                onEnterPressed?.call();
              }
              return KeyEventResult.handled;
            }

            return onKeyEvent?.call(node, event) ?? KeyEventResult.ignored;
          },
        );
}
