Package for Flutter project
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
  The `Language` class provides localization support for different languages in the application.
  
  ### Usage
  First, initialize the instance
  ```dart
  Language.initialize();
  ```
  Then, use `ValueListenableBuilder` to get the value
  
  ```dart
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: Language.getInstance().languageNotifier,
    builder: (context, language, child) => Scaffold(
      body: Center(
        child: Text(language['January']!),
      ),
    ),
  );
  ```
  Or use `Language.getInstance().getValue()` to get the value directly.\
  #### Create another instance
  You can create another instances with name
  ```dart
  Language.initialize(name: 'secondLanguange');
  Language.getInstance(name: 'secondLanguage');
  ```

  #### Change the language
  To change to another language, use
  ```dart
  Language.languageType = LanguageType.indonesiaIndonesian;
  ```
  #### Add additional language
  To add a translation, use
  ```dart
  Language.addData({
    'Hello': {
      LanguageType.unitedStatesEnglish: 'Hello',
      LanguageType.indonesiaIndonesian: 'Halo',
    },
  });
  ```
- ## DateTime Extension
  Extension for converting DateTime class into a formatted date.
  ### Usage
  To convert DateTime into a formatted string, use
  ```dart
  DateTime now = DateTime.now();
  now.toFormattedDate(withWeekday: true, withMonthName: true); // Tuesday, July 04, 2023
  ```
- ## TimeOfDay extension
  Extension for converting a string into TimeOfDay or vice versa.
  ### Usage
  #### String to TimeOfDay
  ```dart
  TimeOfDay timeOfDay = TimeOfDayExtension.fromFormattedString('10:00');
  ```
  #### TimeOfDay to String
  ```dart
  String formattedString = TimeOfDay(hour: 10, minute: 0).toFormattedString(); // 10:00
  formattedString = TimeOfDay(hour: 10, minute: 0).toFormattedString(isPeriod = true); // 10:00 AM
  ```
- ## String Extension
  An extension for additional string manipulation methods.
  ### Usage
  ```dart
  String value = '0...';
  value.count('.'); // 3

  String input = '034sasdf';
  input.extractNumberString(); // 034

  String input = '034asdf';
  input.extractNumber(); // 34
  ```
- ## Thousand Separator on number
  Extension for converting the Num class into a thousand format.
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
  Extends TextEditingController and used for a thousand format on TextEditingController.
  ### Usage
  ```dart
  final TextEditingControllerThousandFormat _textController = TextEditingController();
    TextField(
    controller: _textController,
  );
  ```
- ## NavigationHelper
  Go to another page without context.
  ### Usage
  First, add the key in MaterialApp
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
- ## AdaptiveDialogRoute
  A custom PageRoute that implements a dialog-style route with adaptive behavior.\
  This route is designed to be used as a dialog, appearing on top of the current screen.
  It is intended to work seamlessly across different platforms with adaptive transitions.
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
    AdaptiveDialogRoute(
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
  A dialog to choose multiple or single list.
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
- ## AnimatedDraggableScrollableSheet
  A class representing a draggable scrollable sheet with animated transitions.
  ### Usage
  ```dart
  AnimatedDraggableScrollableSheet(
    minChildSize: 90 / MediaQuery.sizeOf(context).height,
    snap: true,
    snapAnimationDuration: const Duration(milliseconds: 150),
    transitions: [
      SingleChildSheetDraggableTransition(
        tag: 'top',
        startTransition: 0.7,
        endTransition: 1.0,
        transitionCurve: SheetDraggableTransitionCurves.end,
        child: Text(
          'Hello',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        transitionBuilder: (context, animation, curvedAnimation, child) => FadeTransition(
          opacity: curvedAnimation,
          child: Align(
            child: SizedBox(
              height: ((MediaQuery.sizeOf(context).height - imageHeight) / 2 - 24.0) * animation.value,
              child: child,
            ),
          ),
        ),
      ),
      SingleChildSheetDraggableTransition(
        tag: 'bottom',
        startTransition: 0.7,
        endTransition: 1.0,
        transitionCurve: SheetDraggableTransitionCurves.end,
        child: Text(
          'World',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        transitionBuilder: (context, animation, curvedAnimation, child) => FadeTransition(
          opacity: curvedAnimation,
          child: Align(
            child: SizedBox(
              height: ((MediaQuery.sizeOf(context).height - imageHeight) / 2 - 24.0) * animation.value,
              child: child,
            ),
          ),
        ),
      ),
      SingleChildSheetDraggableTransition(
        tag: 'beside image',
        startTransition: 0.0,
        endTransition: 0.3,
        transitionCurve: SheetDraggableTransitionCurves.start,
        child: Text(
          'Hello There',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        transitionBuilder: (context, animation, curvedAnimation, child) => FadeTransition(
          opacity: curvedAnimation,
          child: Positioned(
            left: 32.0 + 48.0,
            child: child,
          ),
        ),
      ),
    ],
    builder: (context, scrollController, animation, children) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.lerp(
          BorderRadius.zero,
          const BorderRadius.vertical(
            top: Radius.circular(kShapeExtraLarge),
          ),
          animation.value,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: ScrollConfiguration(
          behavior: CustomScrollBehavior.all,
          child: Stack(
            children: [
              ListView(
                controller: scrollController,
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
                  ...children?.where((element) => element.tag == 'top').map((e) => e.child) ?? [],
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: Tween(begin: 48.0, end: MediaQuery.sizeOf(context).width).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)).value,
                      height: Tween(begin: 48.0, end: imageHeight).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)).value,
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      color: Colors.blue[50],
                      child: const FlutterLogo(),
                    ),
                  ),
                  ...children?.where((element) => element.tag == 'bottom').map((e) => e.child) ?? [],
                ],
              ),
              ...children?.where((element) => element.tag == 'beside image').map((e) => e.child) ?? [],
            ],
          ),
        ),
      ),
    ),
  );
  ```
- ## NumberPicker
  A number picker widget that allows users to input a numeric value within a specific range.
  ### Usage
  ```dart
  NumberPicker(
    controller: NumberPickerController(initialValue: 10),
    minValue: 0,
    maxValue: 100,
    step: 5,
    onChanged: (value) {
      // Handle the updated value
      print('New value: $value');
    },
  )
  ```
- ## SheetImageSource
  A modal bottom sheet to select an image from the camera or gallery.
  ### Usage
  ```dart
  NavigationHelper.showModalBottomSheet(
    builder: (context) => SheetImageSource(
      showDelete: true,
      title: Text('Select Image Source'),
    ),
  );
  ```
- ## FirestoreAutoIdGenerator
  A utility class for generating Firestore document IDs automatically.
  ### Usage
  ```dart
  String autoId = FirestoreAutoIdGenerator.autoId();
  ```
- ## CustomScrollBehavior
  A custom scroll behavior that allows defining specific pointer devices for dragging.
  ### Usage
  ```dart
  SingleChildScrollView(
    scrollBehavior: CustomScrollBehavior(pointerDeviceKinds: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
    // Other properties and children of SingleChildScrollView
  )
  ```
