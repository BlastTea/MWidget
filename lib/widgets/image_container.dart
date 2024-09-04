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
    this.containerIconSize,
    this.containerIconColor,
    this.enabled,
    this.onImageChanged,
    this.containerGradient,
    this.containerFit,
    this.containerBackgroundColor,
    this.allowPickImageFromGallery = true,
    this.cachedNetworkImageError,
    this.child,
  })  : _isHero = false,
        extendedAppBar = null,
        useDynamicColor = false,
        disuseDynamicColor = false,
        dialogBackgroundColor = null,
        dialogGradient = null,
        dialogFit = null,
        skipDialog = false,
        dialogIconSize = null,
        dialogIconColor = null;

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
    this.containerIconSize,
    this.dialogIconSize,
    this.containerIconColor,
    this.dialogIconColor,
    this.enabled,
    this.extendedAppBar,
    this.useDynamicColor = false,
    this.disuseDynamicColor = false,
    this.containerBackgroundColor,
    this.dialogBackgroundColor,
    this.containerGradient,
    this.dialogGradient,
    this.containerFit,
    this.dialogFit,
    this.skipDialog = false,
    this.cachedNetworkImageError,
    this.child,
  })  : assert((containerGradient == null && dialogGradient == null) || (containerGradient != null && dialogGradient != null)),
        assert((containerIconColor == null && dialogIconColor == null) || (containerIconColor != null && dialogIconColor != null)),
        assert((skipDialog && extendedAppBar != null) || (!skipDialog)),
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
  final double? containerIconSize;

  final double? dialogIconSize;

  final Color? containerIconColor;

  final Color? dialogIconColor;

  /// Callback function to determine whether the container's interaction is enabled.
  final bool Function()? enabled;

  /// Callback function triggered when the image is changed or deleted.
  final void Function(ChangeImageResult result)? onImageChanged;

  /// Indicates whether hero animations are enabled for image transitions.
  final bool _isHero;

  /// An optional [AppBar] that, when provided, enables full-screen mode and zooming for the image.
  final AppBar? extendedAppBar;

  final bool useDynamicColor;

  final bool disuseDynamicColor;

  /// Indicates whether the user is allowed to pick images from the gallery when changing the image.
  ///
  /// When set to `true`, the user can choose an image from the device's gallery
  /// to set as the new image in the container. If set to `false`, the gallery option
  /// won't be available, and only the camera option (if applicable) and delete option
  /// will be shown in the image selection bottom sheet.
  ///
  /// By default, this value is set to `true`.
  final bool allowPickImageFromGallery;

  final Color? containerBackgroundColor;

  final Color? dialogBackgroundColor;

  final Gradient? containerGradient;

  final Gradient? dialogGradient;

  final BoxFit? containerFit;

  final BoxFit? dialogFit;

  final bool skipDialog;

  // TODO: remove this attribute
  final ImageProvider? Function(dynamic e)? cachedNetworkImageError;

  final Widget? child;

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
  static Future<ChangeImageResult> handleChangeImage({
    required bool showDelete,
    bool forceUsingSheet = false,
    String? sheetTitleText,
    bool allowPickImageFromGallery = true,
    double? sheetImageItemWidth,
  }) async {
    ImageSourceResult? imageSourceResult = !(Platform.isAndroid || Platform.isIOS) ? ImageSourceResult.gallery : (!allowPickImageFromGallery && !showDelete ? ImageSourceResult.camera : null);
    if (((Platform.isAndroid || Platform.isIOS) && (allowPickImageFromGallery || showDelete)) || forceUsingSheet && (!(Platform.isAndroid || Platform.isIOS) && showDelete)) {
      imageSourceResult = await showModalBottomSheet(
        context: Get.context!,
        builder: (context) => SheetImageSource(
          showGallery: allowPickImageFromGallery,
          showDelete: showDelete,
          title: Text('Change logo'.tr),
          itemWidth: sheetImageItemWidth,
        ),
      ).then((value) => value ?? (!(Platform.isAndroid || Platform.isIOS) ? (showDelete ? null : ImageSourceResult.gallery) : null));
    }

    ImagePicker picker = ImagePicker();
    switch (imageSourceResult) {
      case ImageSourceResult.gallery:
        return ChangeImageResult(image: await picker.pickImage(source: ImageSource.gallery), imagePicker: picker);
      case ImageSourceResult.camera:
        return ChangeImageResult(image: await picker.pickImage(source: ImageSource.camera), imagePicker: picker);
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
  Key _imageKey = UniqueKey();

  // ignore: unused_field
  bool _isError = false;
  bool _onHover = false;

  static Color? _toBackgroundColor;
  static Gradient? _toGradient;
  static late BorderRadiusGeometry _toBorderRadius;
  static late double _toIconSize;
  static Color? _toIconColor;
  static BoxFit? _toFit;

  ImageProvider? _image;

  Object? e;

  ImageProvider? get image => _image;

  @override
  void initState() {
    super.initState();

    _toGradient = widget.dialogGradient;
    _toBorderRadius = widget.borderRadius ?? BorderRadius.circular(kShapeLarge);
    _toIconSize = widget.dialogIconSize ?? 24.0;
    _toFit = widget.dialogFit;

    // TODO: remove below code, and implements a cache using https://pub.dev/packages/flutter_cache_manager using https://pub.dev/packages/cached_network_image as reference
    if (widget.image != null && widget.image is cached.CachedNetworkImageProvider) {
      cached.CachedNetworkImageProvider widgetImage = (widget.image as cached.CachedNetworkImageProvider);
      _image = cached.CachedNetworkImageProvider(
        widgetImage.url,
        cacheKey: widgetImage.cacheKey,
        cacheManager: widgetImage.cacheManager,
        errorListener: (e) {
          _imageKey = UniqueKey();
          setState(() {
            _image = widget.cachedNetworkImageError?.call(e);
            this.e = e;
            _isError = true;
          });
        },
        headers: widgetImage.headers,
        imageRenderMethodForWeb: widgetImage.imageRenderMethodForWeb,
        maxHeight: widgetImage.maxHeight,
        maxWidth: widgetImage.maxWidth,
        scale: widgetImage.scale,
      );
    } else {
      _image = widget.image;
    }
  }

  Future<void>? _goToDialog() => navigator!.push(
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
                    _toBackgroundColor = widget.dialogBackgroundColor ?? Theme.of(context).colorScheme.surface;
                    _toBorderRadius = BorderRadius.circular(kShapeExtraLarge);
                    _toIconSize = widget.dialogIconSize ?? 24.0;
                    _toIconColor = widget.dialogIconColor;
                    _toFit = widget.dialogFit;
                    return _container(
                      context: context,
                      width: responsiveDialogWidth(MediaQuery.sizeOf(context)),
                      height: responsiveDialogWidth(MediaQuery.sizeOf(context)),
                      borderRadius: BorderRadiusGeometry.lerp(widget.borderRadius ?? BorderRadius.circular(kShapeLarge), BorderRadius.circular(kShapeExtraLarge), animation.value),
                      gradient: Gradient.lerp(widget.containerGradient, widget.dialogGradient, animation.value),
                      image: image != null
                          ? DecorationImage.lerp(
                              DecorationImage(image: image!, fit: widget.containerFit ?? BoxFit.cover),
                              DecorationImage(image: image!, fit: widget.dialogFit ?? BoxFit.cover),
                              animation.value,
                            )
                          : null,
                      color: Color.lerp(widget.containerBackgroundColor ?? Colors.transparent, widget.dialogBackgroundColor ?? Theme.of(context).colorScheme.surface, animation.value),
                      child: _icon(
                        context: context,
                        iconSize: Tween(begin: widget.containerIconSize ?? 24.0, end: widget.dialogIconSize ?? 24.0).animate(animation).value,
                        iconColor: Color.lerp(widget.containerIconColor, widget.dialogIconColor, animation.value),
                      ),
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
                  image: image != null
                      ? DecorationImage(
                          image: image!,
                          fit: widget.dialogFit ?? BoxFit.cover,
                        )
                      : null,
                  color: widget.dialogBackgroundColor ?? Theme.of(context).colorScheme.surface,
                  child: Material(
                    borderRadius: BorderRadius.circular(kShapeExtraLarge),
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(kShapeExtraLarge),
                      onTap: widget.extendedAppBar != null ? () => _goToFullScreen() : null,
                      child: _icon(
                        context: context,
                        iconSize: widget.dialogIconSize,
                        iconColor: widget.dialogIconColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Future<void>? _goToFullScreen({bool replaceCurrentScreen = true}) {
    if (widget.useDynamicColor) MWidget.themeValue.fromImageProvider(image);

    handleAfterRoute(dynamic value) => widget.disuseDynamicColor ? MWidget.themeValue.fromImageProvider(null) : null;

    Route route = MaterialPageRoute(
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
                  _toGradient = widget.dialogGradient ?? const RadialGradient(colors: [Colors.transparent, Colors.transparent]);
                  _toBackgroundColor = widget.containerBackgroundColor;
                  _toBorderRadius = BorderRadius.zero;
                  _toIconSize = widget.dialogIconSize ?? 24.0;
                  _toIconColor = widget.dialogIconColor;
                  _toFit = widget.dialogFit;
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
                      animation.value,
                    ),
                    image: image != null
                        ? DecorationImage.lerp(
                            DecorationImage(
                              image: image!,
                              fit: (widget.skipDialog ? widget.containerFit : widget.dialogFit) ?? BoxFit.cover,
                            ),
                            DecorationImage(
                              image: image!,
                              fit: BoxFit.contain,
                            ),
                            animation.value,
                          )
                        : null,
                    color: Color.lerp(widget.dialogBackgroundColor ?? Theme.of(context).colorScheme.surface, Colors.transparent, animation.value),
                    child: _icon(
                      context: context,
                      iconSize: widget.dialogIconSize,
                      iconColor: widget.dialogIconColor,
                    ),
                  );
                },
              ),
              tag: widget.tag,
              child: image != null
                  ? ExtendedImage(
                      image: image!,
                      fit: BoxFit.contain,
                      // enableLoadState: false,
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
                        iconSize: widget.dialogIconSize,
                        iconColor: widget.dialogIconColor,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );

    if (replaceCurrentScreen) return navigator!.pushReplacement(route).then(handleAfterRoute);

    return navigator!.push(route).then(handleAfterRoute);
  }

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
                    image: image != null
                        ? DecorationImage.lerp(
                            DecorationImage(
                              image: image!,
                              fit: widget.containerFit ?? BoxFit.cover,
                            ),
                            DecorationImage(
                              image: image!,
                              fit: _toFit ?? BoxFit.cover,
                            ),
                            animation.value,
                          )
                        : null,
                    borderRadius: BorderRadiusGeometry.lerp(widget.borderRadius ?? BorderRadius.circular(kShapeLarge), _toBorderRadius, animation.value),
                    color: Color.lerp(_toBackgroundColor ?? Theme.of(context).colorScheme.surface, Colors.transparent, animation.value),
                    child: _icon(
                      context: context,
                      iconSize: Tween(begin: widget.containerIconSize ?? 24.0, end: _toIconSize).animate(animation).value,
                      iconColor: Color.lerp(widget.containerIconColor, _toIconColor, animation.value),
                    ),
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
                  image: image != null
                      ? DecorationImage(
                          image: image!,
                          fit: widget.containerFit ?? BoxFit.cover,
                        )
                      : null,
                  child: Material(
                    borderRadius: widget.borderRadius ?? BorderRadius.circular(kShapeLarge),
                    color: image == null ? (widget.containerBackgroundColor ?? Colors.transparent) : Colors.transparent,
                    child: InkWell(
                      borderRadius: widget.borderRadius as BorderRadius? ?? BorderRadius.circular(kShapeLarge),
                      onTap: () async {
                        if (widget._isHero && widget.skipDialog) return _goToFullScreen(replaceCurrentScreen: false);

                        if (widget._isHero) return _goToDialog();

                        if (!(widget.enabled?.call() ?? true)) return;

                        widget.onImageChanged?.call(
                          await ImageContainer.handleChangeImage(
                            showDelete: image != null,
                            sheetTitleText: widget.sheetTitleText,
                            allowPickImageFromGallery: widget.allowPickImageFromGallery,
                          ),
                        );
                      },
                      child: _icon(
                        context: context,
                        iconSize: widget.containerIconSize,
                        iconColor: widget.containerIconColor,
                      ),
                    ),
                  ),
                ),
              ),
              if (_onHover && image != null && !widget._isHero)
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
        key: _imageKey,
        fit: StackFit.expand,
        children: [
          Container(
            width: width,
            height: height,
            margin: margin,
            decoration: BoxDecoration(
              border: widget.border,
              color: image == null ? color : null,
              borderRadius: borderRadius ?? BorderRadius.circular(kShapeLarge),
              image: image,
              // image: widget.child == null ? image : null,
            ),
          ),
          Container(
            width: width,
            height: height,
            margin: margin,
            decoration: BoxDecoration(
              border: widget.border,
              gradient: gradient,
              borderRadius: borderRadius ?? BorderRadius.circular(kShapeLarge),
            ),
            child: child,
          ),
        ],
      );

  Widget? _icon({required BuildContext context, double? iconSize, Color? iconColor}) => (image != null
      ? null
      : widget.child ??
          Icon(
            widget.icon ?? Icons.business,
            size: iconSize ?? 24.0,
            color: iconColor,
          ));
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
    this.imagePicker,
    this.isDelete = false,
  });

  /// The selected image.
  final XFile? image;

  final ImagePicker? imagePicker;

  /// Indicates whether the image was deleted.
  final bool isDelete;
}
