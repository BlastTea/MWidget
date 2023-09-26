part of 'extensions.dart';

/// An extension on `Iterable<E>` providing utility methods to work with collections.
extension IterableExtension<E> on Iterable<E> {
  /// Returns a new list containing all elements of this iterable, sorted according to the [compare] function.
  ///
  /// The [compare] function is optional and defines the sorting order of the elements.
  /// If the [compare] function is omitted, the elements are sorted in their natural order.
  /// If the [compare] function returns a negative value, the first element is ordered before the second element.
  /// If the [compare] function returns zero, the order of the elements remains unchanged.
  /// If the [compare] function returns a positive value, the second element is ordered before the first element.
  ///
  /// Example usage:
  /// ```dart
  /// List<int> numbers = [5, 2, 10, 7];
  /// List<int> sortedNumbers = numbers.sorted((a, b) => a.compareTo(b));
  /// print(sortedNumbers); // Output: [2, 5, 7, 10]
  /// ```
  List<E> sorted([int Function(E, E)? compare]) {
    List<E> list = toList();
    list.sort(compare);
    return list;
  }

  /// Returns the single element that satisfies the given [test] or `null` if none or more than one element matches.
  ///
  /// The [test] function is used to test elements for a condition. It should return `true` for the desired element.
  /// If there is exactly one element in the iterable that satisfies the [test], that element is returned.
  /// If there are no elements that satisfy the [test], or if there is more than one matching element,
  /// the [orElse] function, if provided, is executed and its result is returned.
  /// If [orElse] is not provided, or if it returns `null`, the method returns `null`.
  ///
  /// Example usage:
  /// ```dart
  /// List<int> numbers = [1, 3, 5, 7];
  /// int? singleEven = numbers.trySingleWhere((element) => element.isEven);
  /// print(singleEven); // Output: null (no even numbers in the list)
  ///
  /// int? result = numbers.trySingleWhere((element) => element.isOdd, orElse: () => 0);
  /// print(result); // Output: 1 (the only odd number in the list)
  /// ```
  E? trySingleWhere(bool Function(E element) test, {E Function()? orElse}) {
    try {
      return singleWhere(test, orElse: orElse);
    } on StateError {
      return null;
    }
  }

  E? get tryFirst {
    try {
      return first;
    } on StateError {
      return null;
    }
  }
}
