Package for flutter project
# Getting started

Go to pubspec.yaml file, and add this dependencies:
```yaml
dependencies:
  ...
  m_widget:
    git:
      url: https://github.com/BlastTea/MWidget.git
      ref: #last commit
```
then, import it
```dart
import 'pakcage:m_widget/m_widget.dart';
```

# Features
- ## Language
  A template for adding multiple language into your App.
  ### Supported Languages:
  - English
  - Indonesia
  ### Usage
  Use ValueListenableBuilder to get the value
  ```dart
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: Language.languageListenable,
      builder: (context, language, child) => Scaffold(
          body: Center(
              child: Text(language['January']!),
          ),
      ),
  );
  ```
  Or
  ```dart
  Language.getValue('January');
  ```
  to get the value directly.
  #### Change the language
  To change into another language, use
  ```dart
  Language.languageTypeListenable.value = LanguageType.indonesian;
  ```
  #### add additional language
  To add the text into it use
  ```dart
  Language.addData({
    'Hello': {
      LanguageType.english: 'Hello',
      LanguageType.indonesian: 'Halo',
    }
  };
  ```
- ## DateTime Format
  Extension for converting DateTime class into formatted date and depend on language
  ### Usage
  To convert DateTime into formatted one, use
  ```dart
  DateTime now = DateTime.now();
  now.toFormattedDate(withWeekday: true, withMonthName: true); // Tuesday, July 04, 2023
  ```
- ## Thousand Separator on number
  Extension for converting Num class into thousand format
  ### Usage
  ```dart
  int number = 10000;
  number.toThousandFormat() // 10,000
  ```
  Or on double
  ```dart
  double number = 10000.05
  number.toThousandFormat() // 10,000.05
  ```
- ## TextEditingControllerThousandFormat
  Extends TextEditingController, and used for a thousand format on TextEditingController
  ### Usage
  ```dart
  final TextEditingControllerThousandFormat _textController = TextEditingController();

  TextField(
    controller: _textController,
  );
  ```
- ## NavigationHelper
  Go to another page without context
  ### Usage
  first, add the key in MaterialApp
  ```dart
  MaterialApp(
    navigatorKey: navigatorKey,
    scaffoldMessengerKey: scaffoldMessengerKey,
  );
  ```
  To go to another page, use
  ```dart
  NavigationHelper.to(MaterialPageRoute(builder: (context) => AnotherPage()));
  ```
  To go back from another page, use
  ```dart
  NavigationHelper.back();
  ```
  To open a dialog, use
  ```dart
  NavigationHelper.showDialog((context) => AlertDialog());
  ```
- ## AdaptiveRouteDialog
  Same as MaterialPageRoute, but its for Dialog.
  Because when use
  ```dart
  showDialog();
  ```
  the transition is not look like a MaterialPageRoute
  ### Usage
  ```dart
  NavigationHelper.to(
    AdaptiveRouteDialog(
      context: context,
      builder: (context) => AdaptiveFullScreenDialog(),
    ),
  );
  ```
- ## AdaptiveFullScreenDialog
  A dialog, when the screen size is less than 600.0 px, it will return Scaffold, otherwise AlertDialog.
  ### Usage
  ```dart
  NavigationHelper.to(
    AdaptiveRouteDialog(
      context: context,
      builder: (context) => AdaptiveFullScreenDialog(
        title: Text('Hello World'),
        body: Center(
          child: Text('Hello World'),
        ),
        actions: [
          TextButton(
            onPressed: () => NavigationHelper.back(),
            child: Text('Go Back'),
          ),
        ],
      ),
    ),
  );
  ```
- ## ChooseDialog
  A dialog to choose multiple or single list
  ### Usage
  ```dart
  NavigationHelper.to(
    AdaptiveRouteDialog(
      context: context,
      builder: (context) => ChooseDialog(
        multiple: true,
        title: Text('Select Animals'),
        data: List.generate(
          3,
          (index) => ChooseData<String>(
            value: ['Cow', 'Lion', 'Cat'][index],
            title: Text(['Cow', 'Lion', 'Cat'][index]),
            searchValue: ['Cow', 'Lion', 'Cat'][index],
          ),
        ),
      ),
    ),
  ).then((value) => print(value));
  ```
