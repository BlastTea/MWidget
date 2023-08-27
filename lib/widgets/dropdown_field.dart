part of 'widgets.dart';

class DropdownField extends StatefulWidget {
  const DropdownField({
    super.key,
    this.focusNode,
    this.controller,
    required this.items,
    this.decoration,
    this.onValueSelected,
    this.autocorrect = true,
    this.autoFillHints,
    this.autofocus = false,
    this.buildCounter,
    this.canRequestFocus = true,
    this.clipBehavior = Clip.hardEdge,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder,
    this.cursorColor,
    this.cursorHeight,
    this.cursorOpacityAnimates,
    this.cursorRadius,
    this.cursorWidth = 2.0,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableIMEPersonalizedLearning = true,
    this.enableInteractiveSelection,
    this.enableSuggestions = true,
    this.enabled,
    this.expands = false,
    this.inputFormatters,
    this.keyboardAppearance,
    this.keyboardType,
    this.magnifierConfiguration,
    this.maxLength,
    this.maxLengthEnforcement,
    this.maxLines = 1,
    this.minLines,
    this.mouseCursor,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.onAppPrivateCommand,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onTap,
    this.onTapOutside,
    this.readOnly = false,
    this.restorationId,
    this.scribbleEnabled = true,
    this.scrollController,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.scrollPhysics,
    this.selectionControls,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.showCursor,
    this.smartDashesType,
    this.smartQuotesType,
    this.spellCheckConfiguration,
    this.strutStyle,
    this.style,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textCapitalization = TextCapitalization.none,
    this.textDirection,
    this.textInputAction,
    this.undoController,
  });

  final FocusNode? focusNode;
  final TextEditingController? controller;
  final List<PopupMenuItem<String>> items;
  final InputDecoration? decoration;
  final void Function(String value)? onValueSelected;
  final bool autocorrect;
  final Iterable<String>? autoFillHints;
  final bool autofocus;
  final InputCounterWidgetBuilder? buildCounter;
  final bool canRequestFocus;
  final Clip clipBehavior;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final Color? cursorColor;
  final double? cursorHeight;
  final bool? cursorOpacityAnimates;
  final Radius? cursorRadius;
  final double cursorWidth;
  final DragStartBehavior dragStartBehavior;
  final bool enableIMEPersonalizedLearning;
  final bool? enableInteractiveSelection;
  final bool enableSuggestions;
  final bool? enabled;
  final bool expands;
  final List<TextInputFormatter>? inputFormatters;
  final Brightness? keyboardAppearance;
  final TextInputType? keyboardType;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final MouseCursor? mouseCursor;
  final bool obscureText;
  final String obscuringCharacter;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final bool readOnly;
  final String? restorationId;
  final bool scribbleEnabled;
  final ScrollController? scrollController;
  final EdgeInsets scrollPadding;
  final ScrollPhysics? scrollPhysics;
  final TextSelectionControls? selectionControls;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final bool? showCursor;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final StrutStyle? strutStyle;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextCapitalization textCapitalization;
  final TextDirection? textDirection;
  final TextInputAction? textInputAction;
  final UndoHistoryController? undoController;

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = widget.controller ?? TextEditingController();
  }

  Future<void> _handleShowDropdownMenu(BuildContext context) async {
    final RenderBox overlay = context.findRenderObject() as RenderBox;
    final Offset offset = overlay.localToGlobal(Offset.zero);

    final position = RelativeRect.fromLTRB(
      offset.dx,
      offset.dy + overlay.size.height,
      offset.dx,
      offset.dy,
    );

    showMenu<String>(
      context: context,
      position: position,
      items: widget.items,
      constraints: BoxConstraints.tightFor(
        width: overlay.constraints.minWidth,
      ),
    ).then((value) {
      if (value == null) {
        return;
      }

      _textController.text = value;

      widget.onValueSelected?.call(value);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
        focusNode: widget.focusNode,
        controller: _textController,
        decoration: widget.decoration?.copyWith(
          suffixIcon: widget.decoration?.suffixIcon ??
              IconButton(
                onPressed: () => _handleShowDropdownMenu(context),
                icon: const Icon(Icons.arrow_drop_down),
              ),
        ),
        autocorrect: widget.autocorrect,
        autofillHints: widget.autoFillHints ?? widget.items.map((e) => e.value ?? ''),
        autofocus: widget.autofocus,
        buildCounter: widget.buildCounter,
        canRequestFocus: widget.canRequestFocus,
        clipBehavior: widget.clipBehavior,
        contentInsertionConfiguration: widget.contentInsertionConfiguration,
        contextMenuBuilder: widget.contextMenuBuilder,
        cursorColor: widget.cursorColor,
        cursorHeight: widget.cursorHeight,
        cursorOpacityAnimates: widget.cursorOpacityAnimates,
        cursorRadius: widget.cursorRadius,
        cursorWidth: widget.cursorWidth,
        dragStartBehavior: widget.dragStartBehavior,
        enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        enableSuggestions: widget.enableSuggestions,
        enabled: widget.enabled,
        expands: widget.expands,
        inputFormatters: widget.inputFormatters,
        keyboardAppearance: widget.keyboardAppearance,
        keyboardType: widget.keyboardType,
        magnifierConfiguration: widget.magnifierConfiguration,
        maxLength: widget.maxLength,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        mouseCursor: widget.mouseCursor,
        obscureText: widget.obscureText,
        obscuringCharacter: widget.obscuringCharacter,
        onAppPrivateCommand: widget.onAppPrivateCommand,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        onSubmitted: widget.onSubmitted,
        onTap: widget.onTap,
        onTapOutside: widget.onTapOutside,
        readOnly: widget.readOnly,
        restorationId: widget.restorationId,
        scribbleEnabled: widget.scribbleEnabled,
        scrollController: widget.scrollController,
        scrollPadding: widget.scrollPadding,
        scrollPhysics: widget.scrollPhysics,
        selectionControls: widget.selectionControls,
        selectionHeightStyle: widget.selectionHeightStyle,
        selectionWidthStyle: widget.selectionWidthStyle,
        showCursor: widget.showCursor,
        smartDashesType: widget.smartDashesType,
        smartQuotesType: widget.smartQuotesType,
        spellCheckConfiguration: widget.spellCheckConfiguration,
        strutStyle: widget.strutStyle,
        style: widget.style,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textCapitalization: widget.textCapitalization,
        textDirection: widget.textDirection,
        textInputAction: widget.textInputAction,
        undoController: widget.undoController,
      );
}
