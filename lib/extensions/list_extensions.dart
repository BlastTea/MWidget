part of 'extensions.dart';

extension ListExtension<T> on List<T> {
  /// Compares this list with another list to check if they have the same elements, regardless of order.
  ///
  /// Returns `true` if both lists have the same set of elements, otherwise returns `false`.
  ///
  /// Example:
  /// ```dart
  /// List<String> list1 = ['apple', 'banana', 'cherry'];
  /// List<String> list2 = ['cherry', 'banana', 'apple'];
  /// print(list1.areEqualTo(list2)); // Should print true
  /// ```
  bool areEqualTo(
    List<T> other, {
    int Function(T a, T b)? compare,
    dynamic Function(int index, T element)? a,
    dynamic Function(int index, T element)? b,
  }) {
    if (length != other.length) return false;

    sort(compare);
    other.sort(compare);

    for (int i = 0; i < length; i++) {
      if ((a?.call(i, this[i]) ?? this[i]) != (b?.call(i, other[i]) ?? other[i])) return false;
    }

    return true;
  }

  /// Checks if all elements within this list are the same.
  ///
  /// Returns `true` if all elements in the list are the same, otherwise returns `false`.
  ///
  /// Example:
  /// ```dart
  /// List<String> list1 = ['apple', 'apple', 'apple'];
  /// List<String> list2 = ['apple', 'banana', 'apple'];
  /// List<String> list3 = ['apple', 'banana', 'cherry'];
  /// print(list1.areAllElementsSame());   // Should print true
  /// print(list2.areAllElementsSame());   // Should print true
  /// print(list3.areAllElementsSame());   // Should print false
  /// ```
  bool containSameElement({int Function(T a, T b)? compare}) {
    if (isEmpty) return false;

    sort(compare);

    for (int i = 0; i < length; i++) {
      for (int j = 0; j < length; j++) {
        if (this[i] == this[j] && i != j) {
          return true;
        }
      }
    }

    return false;
  }
}
