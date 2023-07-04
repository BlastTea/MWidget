part of 'widgets.dart';

class ChooseDialog<T extends Object?> extends StatefulWidget {
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
                  onPressed: () => NavigationHelper.back<Iterable<T?>>(_originalData.where((element) => element.isSelected).map((e) => e.value)),
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
                    onPressed: () => NavigationHelper.back<Iterable<T?>>(_originalData.where((element) => element.isSelected).map((e) => e.value)),
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
                    onPressed: () => NavigationHelper.back<Iterable<T?>>(_originalData.where((element) => element.isSelected).map((e) => e.value)),
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

class ChooseData<T extends Object?> {
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
