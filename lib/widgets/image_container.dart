part of 'widgets.dart';

/// A widget that provides a customizable container for displaying images, along with optional interactions.
///
/// The `ImageContainer` widget allows you to display an image within a container and provides various customization options
/// such as dimensions, margins, border, and more. It also supports optional user interactions like changing the image and
/// deleting it.
///
/// This widget can be used with or without the hero animation for smooth transitions between images.
///
/// Example usage:
///
/// ```dart
/// ImageContainer(
///   tag: 'my_image_tag',
///   width: 200,
///   height: 200,
///   image: AssetImage('assets/my_image.png'),
///   onImageChanged: (result) {
///     if (result.isDelete) {
///       // Handle image deletion
///     } else if (result.image != null) {
///       // Handle image change
///     }
///   },
/// )
/// ```
class ImageContainer extends StatefulWidget {
  /// Creates an `ImageContainer` widget.
  ///
  /// The [tag] is a unique identifier for the hero animation when transitioning between images.
  ///
  /// The [width] and [height] parameters determine the dimensions of the image container.
  ///
  /// The [margin] is the empty space surrounding the container.
  ///
  /// The [borderRadius] determines the roundedness of the container's corners.
  ///
  /// The [border] is the border decoration around the container.
  ///
  /// The [image] is the image to be displayed in the container.
  ///
  /// The [sheetTitleText] is the title text to be displayed in the image selection bottom sheet.
  ///
  /// The [icon] is the icon to be displayed in the container if no image is present.
  ///
  /// The [iconSize] determines the size of the icon when displayed in the container.
  ///
  /// The [enabled] callback determines whether the container's interaction is enabled.
  ///
  /// The [onImageChanged] callback is triggered when the image is changed or deleted.
  const ImageContainer({
    super.key,
    required this.tag,
    this.width,
    this.height,
    this.margin,
    this.borderRadius,
    this.border,
    this.image,
    this.sheetTitleText,
    this.icon,
    this.iconSize,
    this.enabled,
    this.onImageChanged,
  }) : isHero = false;

  /// Creates an `ImageContainer` widget with a hero animation.
  ///
  /// The [tag] is a unique identifier for the hero animation when transitioning between images.
  ///
  /// The [width] and [height] parameters determine the dimensions of the image container.
  ///
  /// The [margin] is the empty space surrounding the container.
  ///
  /// The [borderRadius] determines the roundedness of the container's corners.
  ///
  /// The [border] is the border decoration around the container.
  ///
  /// The [image] is the image to be displayed in the container.
  ///
  /// The [sheetTitleText] is the title text to be displayed in the image selection bottom sheet.
  ///
  /// The [icon] is the icon to be displayed in the container if no image is present.
  ///
  /// The [iconSize] determines the size of the icon when displayed in the container.
  ///
  /// The [enabled] callback determines whether the container's interaction is enabled.
  const ImageContainer.hero({
    super.key,
    required this.tag,
    this.width,
    this.height,
    this.margin,
    this.borderRadius,
    this.border,
    this.image,
    this.sheetTitleText,
    this.icon,
    this.iconSize,
    this.enabled,
  })  : onImageChanged = null,
        isHero = true;

  /// A unique identifier for hero animations when transitioning between images.
  final Object tag;

  /// The width of the image container.
  final double? width;

  /// The height of the image container.
  final double? height;

  /// The empty space surrounding the image container.
  final EdgeInsetsGeometry? margin;

  /// The roundedness of the corners of the image container.
  final BorderRadiusGeometry? borderRadius;

  /// The border decoration around the image container.
  final BoxBorder? border;

  /// The image to be displayed in the container.
  final ImageProvider? image;

  /// The title text to be displayed in the image selection bottom sheet.
  final String? sheetTitleText;

  /// The icon to be displayed in the container if no image is present.
  final IconData? icon;

  /// The size of the icon when displayed in the container.
  final double? iconSize;

  /// Callback function to determine whether the container's interaction is enabled.
  final bool Function()? enabled;

  /// Callback function triggered when the image is changed or deleted.
  final void Function(ChangeImageResult result)? onImageChanged;

  /// Indicates whether hero animations are enabled for image transitions.
  final bool isHero;

  /// Displays a bottom sheet to handle image selection and returns the result.
  ///
  /// The [showDelete] parameter determines whether the delete option should be shown in the bottom sheet.
  ///
  /// The [forceUsingSheet] parameter enforces using the bottom sheet even on non-mobile platforms.
  ///
  /// The [sheetTitleText] is the title text to be displayed in the image selection bottom sheet.
  ///
  /// Returns a [ChangeImageResult] indicating the result of the image selection process.
  static Future<ChangeImageResult> handleChangeImage({required bool showDelete, bool forceUsingSheet = false, String? sheetTitleText}) async {
    ImageSourceResult imageSourceResult = ImageSourceResult.gallery;
    if (Platform.isAndroid || Platform.isIOS || forceUsingSheet && (!(Platform.isAndroid || Platform.isIOS) && showDelete)) {
      imageSourceResult = await NavigationHelper.showModalBottomSheet(
        builder: (context) => SheetImageSource(
          showDelete: showDelete,
          title: Text(sheetTitleText ?? Language.getInstance().getValue('Change logo')!),
        ),
      ).then((value) => value ?? ImageSourceResult.gallery);
    }

    ImagePicker picker = ImagePicker();
    switch (imageSourceResult) {
      case ImageSourceResult.gallery:
        return ChangeImageResult(image: await picker.pickImage(source: ImageSource.gallery));
      case ImageSourceResult.camera:
        return ChangeImageResult(image: await picker.pickImage(source: ImageSource.camera));
      case ImageSourceResult.delete:
        return ChangeImageResult(isDelete: true);
    }
  }

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  bool _onHover = false;

  Future<void> _fullScreenDialog() => NavigationHelper.to(
        PageRouteBuilder(
          barrierColor: Colors.black54,
          barrierDismissible: true,
          opaque: false,
          pageBuilder: (context, animation, secondaryAnimation) => Align(
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                width: responsiveDialogWidth(MediaQuery.sizeOf(context)),
                height: responsiveDialogWidth(MediaQuery.sizeOf(context)),
              ),
              child: Hero(
                createRectTween: (begin, end) => RectTween(begin: begin, end: end),
                flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) => AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) => _container(
                    context: context,
                    width: responsiveDialogWidth(MediaQuery.sizeOf(context)),
                    height: responsiveDialogWidth(MediaQuery.sizeOf(context)),
                    borderRadius: BorderRadiusGeometry.lerp(widget.borderRadius ?? BorderRadius.circular(kShapeExtraLarge), BorderRadius.circular(kShapeExtraLarge), animation.value),
                    image: widget.image != null
                        ? DecorationImage(
                            image: widget.image!,
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: Color.lerp(Colors.transparent, Theme.of(context).colorScheme.surface, animation.value),
                    child: _icon(context: context, iconSize: Tween(begin: widget.iconSize ?? 96.0, end: 96.0).animate(animation).value),
                  ),
                ),
                tag: widget.tag,
                child: _container(
                  width: responsiveDialogWidth(MediaQuery.sizeOf(context)),
                  height: responsiveDialogWidth(MediaQuery.sizeOf(context)),
                  context: context,
                  borderRadius: BorderRadius.circular(kShapeExtraLarge),
                  image: widget.image != null
                      ? DecorationImage(
                          image: widget.image!,
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: Theme.of(context).colorScheme.surface,
                  child: _icon(
                    context: context,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          width: widget.width,
          height: widget.height,
        ),
        // context: context,
        // width: widget.width,
        // height: widget.height,
        // borderRadius: widget.borderRadius,
        // margin: widget.margin,
        child: MouseRegion(
          onEnter: (event) => setState(() => _onHover = true),
          onExit: (event) => setState(() => _onHover = false),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                createRectTween: (begin, end) => RectTween(begin: begin, end: end),
                flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) => AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) => _container(
                    context: context,
                    width: widget.width,
                    height: widget.height,
                    image: widget.image != null
                        ? DecorationImage(
                            image: widget.image!,
                            fit: BoxFit.cover,
                          )
                        : null,
                    borderRadius: BorderRadiusGeometry.lerp(widget.borderRadius ?? BorderRadius.circular(kShapeExtraLarge), BorderRadius.circular(kShapeExtraLarge), animation.value),
                    color: Color.lerp(Colors.transparent, Theme.of(context).colorScheme.surface, animation.value),
                    child: _icon(context: context, iconSize: Tween(begin: widget.iconSize ?? 96.0, end: 96.0).animate(animation).value),
                  ),
                ),
                tag: widget.tag,
                child: _container(
                  context: context,
                  width: widget.width,
                  height: widget.height,
                  borderRadius: widget.borderRadius,
                  margin: widget.margin,
                  image: widget.image != null
                      ? DecorationImage(
                          image: widget.image!,
                          fit: BoxFit.cover,
                        )
                      : null,
                  child: Material(
                    borderRadius: widget.borderRadius ?? BorderRadius.circular(kShapeLarge),
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: widget.borderRadius as BorderRadius? ?? BorderRadius.circular(kShapeLarge),
                      onTap: () async {
                        if (widget.isHero) {
                          _fullScreenDialog();
                          return;
                        }
                        if (!(widget.enabled?.call() ?? true)) {
                          return;
                        }

                        widget.onImageChanged?.call(await ImageContainer.handleChangeImage(showDelete: widget.image != null, sheetTitleText: widget.sheetTitleText));
                      },
                      child: _icon(
                        context: context,
                        iconSize: widget.iconSize,
                      ),
                    ),
                  ),
                ),
              ),
              if (_onHover && widget.image != null && !widget.isHero)
                Positioned(
                  top: 16.0,
                  right: 16.0,
                  child: FloatingActionButton.small(
                    backgroundColor: Theme.of(context).colorScheme.onError,
                    onPressed: () => widget.onImageChanged?.call(ChangeImageResult(isDelete: true)),
                    child: const Icon(Icons.delete),
                  ),
                ),
            ],
          ),
        ),
      );

  Widget _container({
    required BuildContext context,
    required double? width,
    required double? height,
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry? borderRadius,
    DecorationImage? image,
    Color? color,
    required Widget? child,
  }) =>
      Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          border: widget.border ??
              Border.all(
                color: Theme.of(context).colorScheme.onSurface,
              ),
          color: color,
          borderRadius: borderRadius ?? BorderRadius.circular(kShapeLarge),
          image: image,
        ),
        child: child,
      );

  Widget? _icon({required BuildContext context, double? iconSize}) => widget.image != null
      ? null
      : Icon(
          widget.icon ?? Icons.business,
          size: iconSize ?? 96.0,
        );
}

/// Represents the result of changing the image in the `ImageContainer`.
class ChangeImageResult {
  /// Creates a `ChangeImageResult` instance.
  ///
  /// The [image] represents the selected image.
  ///
  /// The [isDelete] flag indicates whether the image was deleted.
  ChangeImageResult({
    this.image,
    this.isDelete = false,
  });

  /// The selected image.
  final XFile? image;

  /// Indicates whether the image was deleted.
  final bool isDelete;
}
