part of 'widgets.dart';

/// A dialog for selecting items from a list of data.
///
/// The `ChooseDialog` widget provides a dialog that allows users to select items from a list of data.
/// It includes an optional search bar to filter the items, and supports both single and multiple selection modes.
///
/// Example usage:
/// ```dart
/// ChooseDialog<String>(
///   title: Text('Select Item'),
///   labelTextSearch: 'Search',
///   hintTextSearch: 'Type to search...',
///   useFullScreenFab: true,
///   data: [
///     ChooseData(value: 'item1', searchValue: 'item one', title: Text('Item 1')),
///     ChooseData(value: 'item2', searchValue: 'item two', title: Text('Item 2')),
///     // Add more ChooseData objects for other items
///   ],
/// )
/// ```
class ChooseDialog<T extends Object?> extends StatefulWidget {
  /// Creates a dialog for selecting items from a list of data.
  ///
  /// The [title] parameter sets the title of the dialog.
  ///
  /// The [labelTextSearch] parameter sets the label for the search bar.
  ///
  /// The [hintTextSearch] parameter sets the hint text for the search bar.
  ///
  /// The [useFullScreenFab] parameter determines whether to use a full-screen floating action button for multiple selection mode.
  ///
  /// The [alwaysFullScreen] parameter forces the dialog to be displayed in full-screen mode regardless of the screen size.
  ///
  /// The [alwaysDialog] parameter forces the dialog to be displayed as a dialog regardless of the screen size.
  ///
  /// The [hideSearchBar] parameter hides the search bar when set to `true`.
  ///
  /// The [multiple] parameter allows multiple selection when set to `true`, otherwise, it allows single selection (default is `false`).
  ///
  /// The [data] parameter is a list of [ChooseData] objects representing the items to be displayed and selected.
  ///
  /// Example usage:
  /// ```dart
  /// ChooseDialog<String>(
  ///   title: Text('Select Item'),
  ///   labelTextSearch: 'Search',
  ///   hintTextSearch: 'Type to search...',
  ///   useFullScreenFab: true,
  ///   data: [
  ///     ChooseData(value: 'item1', searchValue: 'item one', title: Text('Item 1')),
  ///     // Add more ChooseData objects for other items
  ///   ],
  /// )
  /// ```
  ChooseDialog({
    super.key,
    this.title,
    this.labelTextSearch,
    this.hintTextSearch,
    this.useFullScreenFab = false,
    this.alwaysFullScreen = false,
    this.alwaysDialog = false,
    this.hideSearchBar = false,
    this.multiple = false,
    required this.data,
  }) : assert(hideSearchBar || data.every((element) => (element.searchValue?.trim().isNotEmpty ?? false)), 'searchValue must not be null or empty');

  final Widget? title;
  final String? labelTextSearch;
  final String? hintTextSearch;
  final bool useFullScreenFab;
  final bool alwaysFullScreen;
  final bool alwaysDialog;
  final bool hideSearchBar;
  final bool multiple;
  final List<ChooseData<T>> data;

  @override
  State<ChooseDialog<T>> createState() => _ChooseDialogState<T>();
}

class _ChooseDialogState<T extends Object?> extends State<ChooseDialog<T>> {
  final TextEditingController _textControllerSearch = TextEditingController();

  List<ChooseData<T>> _originalData = [];
  List<ChooseData<T>> _searchedData = [];

  @override
  void initState() {
    super.initState();

    _originalData = List.generate(widget.data.length, (index) => widget.data[index]);
    _searchedData = List.of(_originalData);
  }

  @override
  void dispose() {
    _textControllerSearch.dispose();
    super.dispose();
  }

  void _handleOnChanged(String value) {
    if (mounted) {
      setState(() {
        _searchedData = List.of(_originalData);
        _searchedData.removeWhere((element) => !element.searchValue!.trim().toLowerCase().contains(value.trim().toLowerCase()));
      });
    }
  }

  List<ChooseData<T>> get _chooseData => _textControllerSearch.text.trim().isEmpty ? _originalData : _searchedData;

  void _setIsSelected(index, bool value) => setState(() => _chooseData[index].isSelected = value);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Language.languageListenable,
        builder: (context, language, child) => AdaptiveFullScreenDialog(
          alwaysFullScreen: widget.alwaysFullScreen,
          alwaysDialog: widget.alwaysDialog,
          fullScreenFab: widget.useFullScreenFab
              ? FloatingActionButton(
                  onPressed: () => NavigationHelper.back<Iterable<T?>>(_originalData.where((element) => element.isSelected).map((e) => e.value).toList()),
                  child: const Icon(Icons.done),
                )
              : null,
          title: widget.title,
          body: _body,
          dialogBody: SizedBox(
            width: kCompactSize,
            height: kCompactSize,
            child: _body,
          ),
          actions: widget.multiple && !widget.useFullScreenFab
              ? [
                  TextButton(
                    onPressed: () => NavigationHelper.back<Iterable<T?>>(_originalData.where((element) => element.isSelected).map((e) => e.value).toList()),
                    child: Text(language['Ok']!),
                  ),
                ]
              : null,
          dialogActions: widget.multiple
              ? [
                  TextButton(
                    onPressed: () => NavigationHelper.back(),
                    child: Text(language['Cancel']!),
                  ),
                  TextButton(
                    onPressed: () => NavigationHelper.back<Iterable<T?>>(_originalData.where((element) => element.isSelected).map((e) => e.value).toList()),
                    child: Text(language['Ok']!),
                  ),
                ]
              : null,
        ),
      );

  Widget get _body => Column(
        children: [
          if (!widget.hideSearchBar)
            Padding(
              padding: widget.alwaysFullScreen || MediaQuery.sizeOf(context).width < kCompactSize ? const EdgeInsets.all(16.0) : const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: _textControllerSearch,
                decoration: InputDecoration(
                  labelText: widget.labelTextSearch,
                  hintText: widget.hintTextSearch,
                ),
                onChanged: _handleOnChanged,
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: _chooseData[index].leading,
                title: _chooseData[index].title,
                subtitle: _chooseData[index].subtitle,
                isThreeLine: _chooseData[index].isThreeLine,
                trailing: widget.multiple ? Checkbox(value: _chooseData[index].isSelected, onChanged: (value) => _setIsSelected(index, value!)) : _chooseData[index].trailing,
                onTap: () => !widget.multiple ? NavigationHelper.back<T>(_chooseData[index].value) : _setIsSelected(index, !_chooseData[index].isSelected),
              ),
              itemCount: _chooseData.length,
            ),
          ),
        ],
      );
}

/// Represents data for an item in the `ChooseDialog` widget.
///
/// The [value] parameter represents the value of the item.
///
/// The [searchValue] parameter is used for filtering the item in the search bar.
///
/// The [leading], [title], [subtitle], and [trailing] parameters represent the widgets to be displayed
/// as leading, title, subtitle, and trailing content of the item, respectively.
///
/// The [isThreeLine] parameter sets whether the item displays three lines (default is `false`).
///
/// The [isSelected] parameter indicates whether the item is selected (only applicable in multiple selection mode).
class ChooseData<T extends Object?> {
  /// Creates data for an item in the `ChooseDialog` widget.
  ///
  /// The [value] parameter represents the value of the item.
  ///
  /// The [searchValue] parameter is used for filtering the item in the search bar.
  ///
  /// The [leading], [title], [subtitle], and [trailing] parameters represent the widgets to be displayed
  /// as leading, title, subtitle, and trailing content of the item, respectively.
  ///
  /// The [isThreeLine] parameter sets whether the item displays three lines (default is `false`).
  ///
  /// The [isSelected] parameter indicates whether the item is selected (only applicable in multiple selection mode).
  ChooseData({
    this.value,
    this.searchValue,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.isSelected = false,
  });

  final T? value;
  final String? searchValue;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final bool isThreeLine;
  bool isSelected;
}
