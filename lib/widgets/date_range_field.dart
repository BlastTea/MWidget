part of 'widgets.dart';

class DateRangeField extends StatelessWidget {
  const DateRangeField({
    super.key,
    this.focusNode,
    required this.firstDate,
    required this.lastDate,
    this.value,
    this.onDateChanged,
    this.onDateFormat,
    this.decoration,
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
    this.enableDropdown = true,
  });

  final FocusNode? focusNode;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTimeRange? value;
  final void Function(DateTimeRange? value)? onDateChanged;
  final String Function(DateTimeRange? value)? onDateFormat;
  final InputDecoration? decoration;
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
  final bool enableDropdown;

  Future<void> _handleOnPressed(BuildContext context) async {
    // final RenderBox overlay = context.findRenderObject() as RenderBox;
    // final Offset offset = overlay.localToGlobal(Offset.zero);

    // final position = RelativeRect.fromLTRB(
    //   offset.dx,
    //   offset.dy + overlay.size.height,
    //   offset.dx,
    //   offset.dy,
    // );

    // showMenu(
    //   context: context,
    //   position: position,
    //   items: [
    //     PopupMenuItem(
    //       child: CalendarDatePicker(
    //         initialDate: initialDate,
    //         firstDate: firstDate,
    //         lastDate: lastDate,
    //         onDateChanged: (value) {
    //           onDateChanged?.call(value);
    //         },
    //       ),
    //     ),
    //   ],
    //   constraints: BoxConstraints.tightFor(
    //     width: overlay.constraints.minWidth,
    //   ),
    // );

    Language language = Language.getInstance();

    showDateRangePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDateRange: value,
      builder: (context, child) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400.0,
          ),
          child: child,
        ),
      ),
      // TODO: localize this text
      cancelText: null,
      confirmText: null,
      errorFormatText: null,
      errorInvalidRangeText: null,
      errorInvalidText: null,
      fieldEndHintText: null,
      fieldEndLabelText: null,
      fieldStartHintText: null,
      fieldStartLabelText: null,
      helpText: null,
      saveText: language.getValue('Save'),
    ).then((value) => onDateChanged?.call(value));
  }

  @override
  Widget build(BuildContext context) => TextField(
        focusNode: focusNode,
        controller: TextEditingController(text: onDateFormat?.call(value) ?? (value != null ? '${value!.start.toFormattedDate(withMonthName: true)} - ${value!.end.toFormattedDate(withMonthName: true)}' : '')),
        decoration: (decoration ?? const InputDecoration()).applyDefaults(Theme.of(context).inputDecorationTheme).copyWith(
              suffixIcon: decoration?.suffixIcon ??
                  IconButton(
                    onPressed: !enableDropdown ? null : () => _handleOnPressed(context),
                    icon: const Icon(Icons.date_range),
                  ),
            ),
        autocorrect: autocorrect,
        autofillHints: autoFillHints,
        autofocus: autofocus,
        buildCounter: buildCounter,
        canRequestFocus: canRequestFocus,
        clipBehavior: clipBehavior,
        contentInsertionConfiguration: contentInsertionConfiguration,
        contextMenuBuilder: contextMenuBuilder,
        cursorColor: cursorColor,
        cursorHeight: cursorHeight,
        cursorOpacityAnimates: cursorOpacityAnimates,
        cursorRadius: cursorRadius,
        cursorWidth: cursorWidth,
        dragStartBehavior: dragStartBehavior,
        enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
        enableInteractiveSelection: enableInteractiveSelection,
        enableSuggestions: enableSuggestions,
        enabled: enabled,
        expands: expands,
        inputFormatters: inputFormatters,
        keyboardAppearance: keyboardAppearance,
        keyboardType: keyboardType,
        magnifierConfiguration: magnifierConfiguration,
        maxLength: maxLength,
        maxLengthEnforcement: maxLengthEnforcement,
        maxLines: maxLines,
        minLines: minLines,
        mouseCursor: mouseCursor,
        obscureText: obscureText,
        obscuringCharacter: obscuringCharacter,
        onAppPrivateCommand: onAppPrivateCommand,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        onTap: onTap,
        onTapOutside: onTapOutside,
        readOnly: readOnly,
        restorationId: restorationId,
        scribbleEnabled: scribbleEnabled,
        scrollController: scrollController,
        scrollPadding: scrollPadding,
        scrollPhysics: scrollPhysics,
        selectionControls: selectionControls,
        selectionHeightStyle: selectionHeightStyle,
        selectionWidthStyle: selectionWidthStyle,
        showCursor: showCursor,
        smartDashesType: smartDashesType,
        smartQuotesType: smartQuotesType,
        spellCheckConfiguration: spellCheckConfiguration,
        strutStyle: strutStyle,
        style: style,
        textAlign: textAlign,
        textAlignVertical: textAlignVertical,
        textCapitalization: textCapitalization,
        textDirection: textDirection,
        textInputAction: textInputAction,
        undoController: undoController,
      );
}
