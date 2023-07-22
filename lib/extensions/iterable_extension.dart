part of 'extensions.dart';

extension IterableExtension<E> on Iterable<E> {
  List<E> sorted([int Function(E, E)? compare]) {
    List<E> list = toList();
    list.sort(compare);
    return list;
  }
}
