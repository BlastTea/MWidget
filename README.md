Package for flutter project

## Features

- Language
- DateTime Format
- Thousand Separator on number
- NavigationHelper
- AdaptiveRouteDialog
- AdaptiveFullScreenDialog
- ChooseDialog

## Getting started

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

## Usage
# Language
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
# NavigationHelper
```dart
NavigationHelper.to(MaterialPageRoute(builder: (context) => AnotherPage()));
```
```dart
NavigationHelper.back();
```
