part of 'widgets.dart';

/// A widget that provides a customizable container for displaying images, along with optional interactions.
///
/// The `ImageContainer` widget allows you to display an image within a container and provides various customization options
/// such as dimensions, margins, border, and more. It also supports optional user interactions like changing the image and
/// deleting it. If an [extendedAppBar] is provided, the widget supports entering full-screen mode and zooming in on the image.
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
///   extendedAppBar: AppBar(title: Text('Full Screen Image')),
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
  ///
  /// The [allowPickImageFromGallery] parameter determines whether the user can pick images
  /// from the gallery when changing the image. Set it to `true` to allow gallery selection,
  /// and `false` to restrict it.
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
    this.containerGradient,
    this.allowPickImageFromGallery = true,
  })  : _isHero = false,
        extendedAppBar = null,
        dialogGradient = null;

  /// Creates an `ImageContainer` widget with a hero animation and support for full-screen mode.
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
  /// The [extendedAppBar] is an optional app bar that, when provided, enables full-screen mode and zooming for the image.
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
    this.extendedAppBar,
    this.containerGradient,
    this.dialogGradient,
  })  : assert((containerGradient == null && dialogGradient == null) || (containerGradient != null && dialogGradient != null)),
        onImageChanged = null,
        _isHero = true,
        allowPickImageFromGallery = false;

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
  final bool _isHero;

  /// An optional [AppBar] that, when provided, enables full-screen mode and zooming for the image.
  final AppBar? extendedAppBar;

  /// Indicates whether the user is allowed to pick images from the gallery when changing the image.
  ///
  /// When set to `true`, the user can choose an image from the device's gallery
  /// to set as the new image in the container. If set to `false`, the gallery option
  /// won't be available, and only the camera option (if applicable) and delete option
  /// will be shown in the image selection bottom sheet.
  ///
  /// By default, this value is set to `true`.
  final bool allowPickImageFromGallery;

  final Gradient? containerGradient;

  final Gradient? dialogGradient;

  /// Displays a bottom sheet to handle image selection and returns the result.
  ///
  /// The [showDelete] parameter determines whether the delete option should be shown in the bottom sheet.
  ///
  /// The [forceUsingSheet] parameter enforces using the bottom sheet even on non-mobile platforms.
  ///
  /// The [sheetTitleText] is the title text to be displayed in the image selection bottom sheet.
  ///
  /// The [allowPickImageFromGallery] parameter specifies whether the user can pick images
  /// from the gallery when changing the image. If set to `true`, the gallery option is available.
  /// If set to `false`, only the camera option (if applicable) and delete option will be shown.
  ///
  /// Returns a [ChangeImageResult] indicating the result of the image selection process.
  static Future<ChangeImageResult> handleChangeImage({required bool showDelete, bool forceUsingSheet = false, String? sheetTitleText, bool allowPickImageFromGallery = true}) async {
    ImageSourceResult? imageSourceResult = !(Platform.isAndroid || Platform.isIOS) ? ImageSourceResult.gallery : (!allowPickImageFromGallery && !showDelete ? ImageSourceResult.camera : null);
    if (((Platform.isAndroid || Platform.isIOS) && (allowPickImageFromGallery || showDelete)) || forceUsingSheet && (!(Platform.isAndroid || Platform.isIOS) && showDelete)) {
      imageSourceResult = await NavigationHelper.showModalBottomSheet(
        builder: (context) => SheetImageSource(
          showGallery: allowPickImageFromGallery,
          showDelete: showDelete,
          title: Text(sheetTitleText ?? Language.getInstance().getValue('Change logo')!),
        ),
      ).then((value) => value ?? (!(Platform.isAndroid || Platform.isIOS) ? (showDelete ? null : ImageSourceResult.gallery) : null));
    }

    ImagePicker picker = ImagePicker();
    switch (imageSourceResult) {
      case ImageSourceResult.gallery:
        return ChangeImageResult(image: await picker.pickImage(source: ImageSource.gallery));
      case ImageSourceResult.camera:
        return ChangeImageResult(image: await picker.pickImage(source: ImageSource.camera));
      case ImageSourceResult.delete:
        return ChangeImageResult(isDelete: true);
      default:
        return ChangeImageResult();
    }
  }

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> with SingleTickerProviderStateMixin {
  bool _onHover = false;

  static Gradient? _toGradient;
  static late BorderRadiusGeometry _toBorderRadius;
  static late double _toIconSize;

  @override
  void initState() {
    super.initState();

    _toGradient = widget.dialogGradient;
    _toBorderRadius = widget.borderRadius ?? BorderRadius.circular(kShapeLarge);
    _toIconSize = widget.iconSize ?? 96.0;
  }

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
                  builder: (context, child) {
                    _toGradient = widget.dialogGradient;
                    _toBorderRadius = BorderRadius.circular(kShapeExtraLarge);
                    _toIconSize = 96.0;
                    return _container(
                      context: context,
                      width: responsiveDialogWidth(MediaQuery.sizeOf(context)),
                      height: responsiveDialogWidth(MediaQuery.sizeOf(context)),
                      borderRadius: BorderRadiusGeometry.lerp(widget.borderRadius ?? BorderRadius.circular(kShapeLarge), BorderRadius.circular(kShapeExtraLarge), animation.value),
                      gradient: Gradient.lerp(widget.containerGradient, widget.dialogGradient, animation.value),
                      image: widget.image != null
                          ? DecorationImage(
                              image: widget.image!,
                              fit: BoxFit.cover,
                            )
                          : null,
                      color: Color.lerp(Colors.transparent, Theme.of(context).colorScheme.surface, animation.value),
                      child: _icon(context: context, iconSize: Tween(begin: widget.iconSize ?? 96.0, end: 96.0).animate(animation).value),
                    );
                  },
                ),
                tag: widget.tag,
                child: _container(
                  width: responsiveDialogWidth(MediaQuery.sizeOf(context)),
                  height: responsiveDialogWidth(MediaQuery.sizeOf(context)),
                  context: context,
                  borderRadius: BorderRadius.circular(kShapeExtraLarge),
                  gradient: widget.dialogGradient,
                  image: widget.image != null
                      ? DecorationImage(
                          image: widget.image!,
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: Theme.of(context).colorScheme.surface,
                  child: Material(
                    borderRadius: BorderRadius.circular(kShapeExtraLarge),
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(kShapeExtraLarge),
                      onTap: widget.extendedAppBar != null
                          ? () => NavigationHelper.toReplacement(
                                MaterialPageRoute(
                                  builder: (context) => Theme(
                                    data: Theme.of(context).copyWith(
                                      appBarTheme: const AppBarTheme(
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    child: Scaffold(
                                      appBar: widget.extendedAppBar,
                                      body: Center(
                                        child: Hero(
                                          createRectTween: (begin, end) => RectTween(begin: begin, end: end),
                                          flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) => AnimatedBuilder(
                                            animation: animation,
                                            builder: (context, child) {
                                              _toGradient = const RadialGradient(colors: [Colors.transparent, Colors.transparent]);
                                              _toBorderRadius = BorderRadius.zero;
                                              _toIconSize = 96.0;
                                              return _container(
                                                context: context,
                                                width: double.infinity,
                                                height: null,
                                                borderRadius: BorderRadiusGeometry.lerp(BorderRadius.circular(kShapeExtraLarge), BorderRadius.zero, animation.value),
                                                gradient: Gradient.lerp(
                                                    widget.dialogGradient,
                                                    const RadialGradient(
                                                      colors: [
                                                        Colors.transparent,
                                                        Colors.transparent,
                                                      ],
                                                    ),
                                                    animation.value),
                                                image: widget.image != null
                                                    ? DecorationImage(
                                                        image: widget.image!,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : null,
                                                color: Color.lerp(Colors.transparent, Theme.of(context).colorScheme.surface, animation.value),
                                                child: _icon(context: context, iconSize: Tween(begin: 96.0, end: 96.0).animate(animation).value),
                                              );
                                            },
                                          ),
                                          tag: widget.tag,
                                          child: widget.image != null
                                              ? ExtendedImage(
                                                  image: widget.image!,
                                                  fit: BoxFit.contain,
                                                  //enableLoadState: false,
                                                  mode: ExtendedImageMode.gesture,
                                                  initGestureConfigHandler: (state) => GestureConfig(
                                                    minScale: 0.9,
                                                    animationMinScale: 0.7,
                                                    maxScale: 3.0,
                                                    animationMaxScale: 3.5,
                                                    speed: 1.0,
                                                    inertialSpeed: 100.0,
                                                    initialScale: 1.0,
                                                    inPageView: false,
                                                    initialAlignment: InitialAlignment.center,
                                                  ),
                                                )
                                              : _container(
                                                  context: context,
                                                  width: MediaQuery.sizeOf(context).width,
                                                  height: 400.0,
                                                  child: _icon(
                                                    context: context,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          : null,
                      child: _icon(
                        context: context,
                      ),
                    ),
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
                    gradient: Gradient.lerp(widget.containerGradient, _toGradient, animation.value),
                    image: widget.image != null
                        ? DecorationImage(
                            image: widget.image!,
                            fit: BoxFit.cover,
                          )
                        : null,
                    borderRadius: BorderRadiusGeometry.lerp(widget.borderRadius ?? BorderRadius.circular(kShapeLarge), _toBorderRadius, animation.value),
                    color: Color.lerp(Colors.transparent, Theme.of(context).colorScheme.surface, animation.value),
                    child: _icon(context: context, iconSize: Tween(begin: widget.iconSize ?? 96.0, end: _toIconSize).animate(animation).value),
                  ),
                ),
                tag: widget.tag,
                child: _container(
                  context: context,
                  width: widget.width,
                  height: widget.height,
                  borderRadius: widget.borderRadius,
                  gradient: widget.containerGradient,
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
                        if (widget._isHero) {
                          _fullScreenDialog();
                          return;
                        }
                        if (!(widget.enabled?.call() ?? true)) {
                          return;
                        }

                        widget.onImageChanged?.call(
                          await ImageContainer.handleChangeImage(
                            showDelete: widget.image != null,
                            sheetTitleText: widget.sheetTitleText,
                            allowPickImageFromGallery: widget.allowPickImageFromGallery,
                          ),
                        );
                      },
                      child: _icon(
                        context: context,
                        iconSize: widget.iconSize,
                      ),
                    ),
                  ),
                ),
              ),
              if (_onHover && widget.image != null && !widget._isHero)
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
    Gradient? gradient,
    DecorationImage? image,
    Color? color,
    required Widget? child,
  }) =>
      Stack(
        fit: StackFit.expand,
        children: [
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
          ),
          Container(
            width: width,
            height: height,
            margin: margin,
            decoration: BoxDecoration(
              border: widget.border ??
                  Border.all(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              gradient: gradient,
              borderRadius: borderRadius ?? BorderRadius.circular(kShapeLarge),
            ),
            child: child,
          ),
        ],
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
