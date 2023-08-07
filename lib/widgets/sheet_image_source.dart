part of 'widgets.dart';

/// A widget that displays image source options in a bottom sheet.
///
/// The `SheetImageSource` widget provides a user interface to select image sources, such as the gallery or camera.
/// It is typically used to allow users to choose from where they want to pick an image.
///
/// The widget supports both the gallery and camera options by default. Additionally, you can enable the delete option
/// by setting [showDelete] to `true`, which allows users to delete an existing image.
///
/// The [title] parameter is optional and can be used to display a title above the image source options.
///
/// Example usage:
/// ```dart
/// SheetImageSource(
///   showDelete: true,
///   title: Text('Select Image Source'),
/// )
/// ```
class SheetImageSource extends StatelessWidget {
  /// Creates a widget to display image source options in a bottom sheet.
  ///
  /// The [showDelete] parameter determines whether to show the delete option in addition to the gallery and camera options.
  /// Set [showDelete] to `true` to enable the delete option, or `false` to display only the gallery and camera options.
  ///
  /// The [title] parameter is optional and can be used to display a title above the image source options.
  ///
  /// Example usage:
  /// ```dart
  /// SheetImageSource(
  ///   showDelete: true,
  ///   title: Text('Select Image Source'),
  /// )
  /// ```
  const SheetImageSource({
    super.key,
    this.showDelete = false,
    this.title,
  });

  final bool showDelete;
  final Widget? title;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Language.getInstance().languageNotifier,
        builder: (context, language, child) => Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyLarge!,
                    child: title!,
                  ),
                ),
                const SizedBox(height: 8.0),
              ],
              Row(
                children: List.generate(
                  showDelete && (Platform.isAndroid || Platform.isIOS)
                      ? 3
                      : (!showDelete && (Platform.isAndroid || Platform.isIOS)) || showDelete
                          ? 2
                          : 1,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(kShapeLarge),
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(kShapeLarge),
                        onTap: () => NavigationHelper.back((Platform.isAndroid || Platform.isIOS ? ImageSourceResult.values : [ImageSourceResult.gallery, ImageSourceResult.delete])[index]),
                        child: SizedBox(
                          width: 68.0,
                          height: 68.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon((Platform.isAndroid || Platform.isIOS ? [Icons.photo, Icons.camera, Icons.delete] : [Icons.folder, Icons.delete])[index]),
                                const SizedBox(height: 8.0),
                                Text(language[(Platform.isAndroid || Platform.isIOS ? ['Gallery', 'Camera', 'Delete'] : ['File', 'Delete'])[index]]!),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

enum ImageSourceResult {
  gallery,
  camera,
  delete,
}
