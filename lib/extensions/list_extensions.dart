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
  bool areEqualTo(List other) {
    if (length != other.length) {
      return false;
    }

    sort();
    other.sort();

    for (int i = 0; i < length; i++) {
      if (this[i] != other[i]) {
        return false;
      }
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
  bool areAllElementsSame() {
    if (isEmpty) {
      return false;
    }

    sort();

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
