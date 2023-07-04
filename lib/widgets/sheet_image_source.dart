part of 'widgets.dart';

class SheetImageSource extends StatelessWidget {
  const SheetImageSource({
    super.key,
    this.showDelete = false,
    this.title,
  });

  final bool showDelete;
  final Widget? title;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Language.languageListenable,
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
                  showDelete ? 3 : 2,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(kShapeLarge),
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(kShapeLarge),
                        onTap: () => NavigationHelper.back(ImageSourceResult.values[index]),
                        child: SizedBox(
                          width: 68.0,
                          height: 68.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon([Icons.photo, Icons.camera, Icons.delete][index]),
                                const SizedBox(height: 8.0),
                                Text(language[['Gallery', 'Camera', 'Delete'][index]]!),
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
