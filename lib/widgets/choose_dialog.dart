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
///   data: () async => [
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
  /// The [useFullScreenFab] parameter determines whether to use a full-screen floating action button in full-screen mode.
  ///
  /// The [alwaysFullScreen] parameter forces the dialog to be displayed in full-screen mode regardless of the screen size.
  ///
  /// The [alwaysDialog] parameter forces the dialog to be displayed as a dialog regardless of the screen size.
  ///
  /// The [hideSearchBar] parameter hides the search bar when set to `true`.
  ///
  /// The [multiple] parameter allows multiple selection when set to `true`, otherwise, it allows single selection (default is `false`).
  ///
  /// [onDataEmpty] is a callback function that provides a widget to display when there is no data to show.
  /// The [onDataEmpty] callback takes a function [retry] as a parameter, which can be invoked to retry fetching data.
  ///
  /// The [onDataNotFound] parameter is a widget to display when the searched data is not found.
  ///
  /// The [data] parameter is a function that returns a [FutureOr] of [List<ChooseData<T>>] representing the items to be displayed and selected.
  ///
  /// The [onSnapshotErrorBuilder] parameter is a callback that takes an error and a retry function. It returns a widget to display when there is an error while loading data.
  /// The retry function can be invoked to retry fetching data.
  ///
  /// The [onSnapshotErrorListener] parameter is a callback that takes an error and a retry function. It performs an action when there is an error while loading data.
  /// The retry function can be invoked to retry fetching data.
  ///
  /// Example usage:
  /// ```dart
  /// ChooseDialog<String>(
  ///   title: Text('Select Item'),
  ///   labelTextSearch: 'Search',
  ///   hintTextSearch: 'Type to search...',
  ///   useFullScreenFab: true,
  ///   data: () async => [
  ///     ChooseData(value: 'item1', searchValue: 'item one', title: Text('Item 1')),
  ///     // Add more ChooseData objects for other items
  ///   ],
  ///   onDataEmpty: (retry) {
  ///     return Center(
  ///       child: Column(
  ///         children: [
  ///           Text('No data found.'),
  ///           ElevatedButton(
  ///             onPressed: retry,
  ///             child: Text('Retry'),
  ///           ),
  ///         ],
  ///       ),
  ///     );
  ///   },
  /// )
  /// ```
  const ChooseDialog({
    super.key,
    this.title,
    this.labelTextSearch,
    this.hintTextSearch,
    this.useFullScreenFab = false,
    this.alwaysFullScreen = false,
    this.alwaysDialog = false,
    this.hideSearchBar = false,
    this.multiple = false,
    this.onDataEmpty,
    this.onDataNotFound,
    required this.data,
    this.onSnapshotErrorBuilder,
    this.onSnapshotErrorListener,
  });

  final Widget? title;
  final String? labelTextSearch;
  final String? hintTextSearch;
  final bool useFullScreenFab;
  final bool alwaysFullScreen;
  final bool alwaysDialog;
  final bool hideSearchBar;
  final bool multiple;
  final Widget? Function(void Function() retry)? onDataEmpty;
  final Widget? onDataNotFound;
  final FutureOr<List<ChooseData<T>>> Function() data;
  final Widget Function(Object? e, void Function() retry)? onSnapshotErrorBuilder;
  final void Function(Object? e, void Function() retry)? onSnapshotErrorListener;

  @override
  State<ChooseDialog<T>> createState() => _ChooseDialogState<T>();
}

class _ChooseDialogState<T extends Object?> extends State<ChooseDialog<T>> {
  final TextEditingController _textControllerSearch = TextEditingController();

  List<ChooseData<T>> _originalData = [];
  List<ChooseData<T>> _searchedData = [];

  Completer<List<ChooseData<T>>> _completer = Completer();

  @override
  void initState() {
    super.initState();

    _getData();
  }

  @override
  void dispose() {
    _textControllerSearch.dispose();
    super.dispose();
  }

  Future<void> _getData() async {
    List<ChooseData<T>> data;
    try {
      data = await widget.data();
    } catch (e) {
      widget.onSnapshotErrorListener?.call(e, _retry);
      _completer.completeError(e);
      return;
    }
    assert(widget.hideSearchBar || data.every((element) => (element.searchValue?.trim().isNotEmpty ?? false)), 'searchValue must not be null or empty');

    _originalData = List.generate(data.length, (index) => data[index]);
    _searchedData = List.of(_originalData);

    _completer.complete(data);
  }

  void _retry() {
    setState(() {
      _completer = Completer();
      _getData();
    });
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
        valueListenable: Language.getInstance().languageNotifier,
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

  Widget get _body => FutureBuilder(
        future: _completer.future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
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
                  child: _chooseData.isEmpty
                      ? _textControllerSearch.text.trim().isEmpty
                          ? DefaultTextStyle(
                              style: Theme.of(context).textTheme.bodyLarge!,
                              child: Center(
                                child: widget.onDataEmpty?.call(_retry) ?? Text(Language.getInstance().getValue('No data')!),
                              ),
                            )
                          : DefaultTextStyle(
                              style: Theme.of(context).textTheme.bodyLarge!,
                              child: Center(
                                child: widget.onDataNotFound ?? Text(Language.getInstance().getValue('Data not found')!),
                              ),
                            )
                      : ListView.builder(
                          itemBuilder: (context, index) => ListTile(
                            leading: _chooseData[index].leading,
                            title: _chooseData[index].title,
                            subtitle: _chooseData[index].subtitle,
                            isThreeLine: _chooseData[index].isThreeLine,
                            selected: !widget.multiple ? _chooseData[index].isSelected : false,
                            trailing: widget.multiple ? Checkbox(value: _chooseData[index].isSelected, onChanged: (value) => _setIsSelected(index, value!)) : _chooseData[index].trailing,
                            onTap: () => !widget.multiple ? NavigationHelper.back<T>(_chooseData[index].value) : _setIsSelected(index, !_chooseData[index].isSelected),
                          ),
                          itemCount: _chooseData.length,
                        ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: widget.onSnapshotErrorBuilder?.call(snapshot.error, _retry) ??
                  Text(
                    'Error',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
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
