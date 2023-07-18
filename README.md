Package for flutter project
# Getting started

Go to pubspec.yaml file, and add this dependencies:
```yaml
dependencies:
  ...
  m_widget:
    git:
      url: https://github.com/BlastTea/MWidget.git
      ref: #last_commit_hash
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
  To add the translation into it, use
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
- ## Timeofday extension
  Extension for converting string into TimeOfDay or vice versa
  ### Usage
  #### String to TimeOfDay
  ```dart
  TimeOfDay timeOfDay = TimeOfDayExtension.fromFormattedString('10:00');
  ```
  #### TimeOfDay to String
  ```dart
  TimeOfDay(hour: 10, minute: 0).toFormattedString(); // 10:00
  TimeOfDay(hour: 10, minute: 0).toFormattedString(isPeriod = true); // 10:00 AM
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
  Same as MaterialPageRoute, but this route will be adaptive.
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
- ## DraggableScrollableSwitcher
  A DraggableScrollableSheet with transition
  ### Usage
  ```dart
  DraggableScrollableSwitcher(
    minChildSize: 90 / MediaQuery.sizeOf(context), // the minimum child size will be 90 pixel
    children: [
      DraggableScrollableTransition(
        startTransition: 0.0,
        endTransition: 0.3,
        visibility: DraggableScrollableTransitionVisibility.start,
        children: [
          FilledButton(
            onPressed: () {},
            child: Text('Start'),
          ),
        ]
      ),
      DraggableScrollableTransition(
        startTransition: 0.4,
        endTransition: 0.6,
        visibility: DraggableScrollableTransitionVisibility.mid, // in mid, I still working on it, so better not to use it
        children: [
          FilledButton(
            onPressed: () {},
            child: Text('Mid'),
          ),
        ]
      ),
      DraggableScrollableTransition(
        startTransition: 0.7,
        endTransition: 1.0,
        visibility: DraggableScrollableTransitionVisibility.end,
        children: [
          FilledButton(
            onPressed: () {},
            child: Text('End'),
          ),
        ]
      ),
    ],
    transitionBuilder: (context, animation, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    builder: (context, scrollController, children, animation) => Container(
      child: ListView( // You can use ListView or CustomScrollView
        controller: scrollController
        children: [
          Align(
            child: Container(
              width: 32.0,
              height: 4.0,
              margin: const EdgeInsets.only(top: 8.0, bottom: 22.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.4), 
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
          ...children,
        ]
      )
    ),
  );
  ```
- ## MNumberPicker
  It just a number picker
  ### Usage
  ```dart
  MNumberPicker(
    initialValue: 0,
    minValue: 0,
    maxValue: 10,
    onChanged: (value) {},
    step: 2,
  );
  ```