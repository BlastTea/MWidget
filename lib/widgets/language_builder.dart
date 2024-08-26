part of 'widgets.dart';

typedef LanguageWidgetBuilder = Widget Function(BuildContext context, Map<String, String?> language);

class LanguageBuilder extends StatelessWidget {
  const LanguageBuilder({
    super.key,
    this.instance,
    required this.builder,
  });

  final Language? instance;
  final LanguageWidgetBuilder builder;

  @override
  Widget build(BuildContext context) => builder(context, (instance ?? Language.getInstance()).getData());
}
