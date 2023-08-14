part of 'widgets.dart';

/// A widget that displays image source options in a bottom sheet.
///
/// The `SheetImageSource` widget provides a user interface to select image sources, such as the gallery or camera.
/// It is typically used to allow users to choose from where they want to pick an image.
///
/// The widget supports both the gallery and camera options by default. Additionally, you can enable the delete option
/// by setting [showDelete] to `true`, which allows users to delete an existing image.
///
/// The [showGallery] and [showDelete] parameters control whether the gallery and delete options are shown, respectively.
///
/// The [title] parameter is optional and can be used to display a title above the image source options.
///
/// Example usage:
/// ```dart
/// SheetImageSource(
///   showGallery: true,
///   showDelete: true,
///   title: Text('Select Image Source'),
/// )
/// ```
class SheetImageSource extends StatelessWidget {
  /// Creates a widget to display image source options in a bottom sheet.
  ///
  /// The [showGallery] parameter determines whether to show the gallery option.
  /// Set [showGallery] to `true` to enable the gallery option, or `false` to hide it.
  ///
  /// The [showDelete] parameter determines whether to show the delete option.
  /// Set [showDelete] to `true` to enable the delete option, or `false` to hide it.
  ///
  /// The [title] parameter is optional and can be used to display a title above the image source options.
  ///
  /// Example usage:
  /// ```dart
  /// SheetImageSource(
  ///   showGallery: true,
  ///   showDelete: true,
  ///   title: Text('Select Image Source'),
  /// )
  /// ```
  const SheetImageSource({
    super.key,
    this.showGallery = true,
    this.showDelete = false,
    this.title,
  });

  /// Determines whether the gallery option should be shown.
  final bool showGallery;

  /// Determines whether the delete option should be shown.
  final bool showDelete;

  /// An optional title to display above the image source options.
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
                  _index,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(kShapeLarge),
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(kShapeLarge),
                        onTap: () => NavigationHelper.back((Platform.isAndroid || Platform.isIOS ? [if (showGallery) ImageSourceResult.gallery, ImageSourceResult.camera, ImageSourceResult.delete] : [ImageSourceResult.gallery, ImageSourceResult.delete])[index]),
                        child: SizedBox(
                          width: 68.0,
                          height: 68.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon((Platform.isAndroid || Platform.isIOS ? [if (showGallery) Icons.photo, Icons.camera, Icons.delete] : [Icons.folder, Icons.delete])[index]),
                                const SizedBox(height: 8.0),
                                Text(language[(Platform.isAndroid || Platform.isIOS ? [if (showGallery) 'Gallery', 'Camera', 'Delete'] : ['File', 'Delete'])[index]]!),
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

  int get _index {
    if (showGallery && showDelete && (Platform.isAndroid || Platform.isIOS)) {
      return 3;
    } else if (((!showDelete && showGallery) || (showDelete && !showGallery)) && (Platform.isAndroid || Platform.isIOS) || (showDelete || showGallery)) {
      return 2;
    }

    return 1;
  }
}

enum ImageSourceResult {
  gallery,
  camera,
  delete,
}
