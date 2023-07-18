part of 'utils.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {
  const CustomScrollBehavior({required this.pointerDeviceKinds});

  static CustomScrollBehavior get all => CustomScrollBehavior(pointerDeviceKinds: PointerDeviceKind.values.toSet());

  final Set<PointerDeviceKind> pointerDeviceKinds;

  @override
  Set<PointerDeviceKind> get dragDevices => pointerDeviceKinds;
}
