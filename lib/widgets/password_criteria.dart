part of 'widgets.dart';

class PasswordCriteriaInfo extends StatelessWidget {
  const PasswordCriteriaInfo({
    super.key,
    required this.criterias,
    required this.text,
  });

  final List<PasswordCriteria> criterias;
  final String text;

  static List<PasswordCriteria> checkCriteria({
    required List<PasswordCriteria> criterias,
    required String text,
  }) {
    List<PasswordCriteria> results = [];

    for (PasswordCriteria criteria in criterias) {
      switch (criteria) {
        case _PasswordCriteriaMinimunChacater value:
          if (text.length >= value.minLength) results.add(value);
        case _PasswordCriteriaContainsLowerCaseLetters value:
          if (text.contains(RegExp(r'[a-z]'))) results.add(value);
        case _PasswordCriteriaContainsUpperCaseLetters value:
          if (text.contains(RegExp(r'[A-Z]'))) results.add(value);
        case _PasswordCriteriaContainsNumber value:
          if (text.contains(RegExp(r'[0-9]'))) results.add(value);
        case _PasswordCriteriaContainsSpecialCharacters value:
          if (text.contains(RegExp(r'[!@#\$%^&*()_+{}[\]:;<>,.?~\\-]'))) results.add(value);
        case _PasswordCriteriaNotInOrder value:
          if (text.containsSequential()) results.add(value);
      }
    }

    return results;
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: criterias
            .map(
              (e) => Text(
                '• \t ${e.text}',
                style: TextStyle(
                  color: checkCriteria(criterias: criterias, text: text).contains(e) ? const Color(0xFF3FCC6A) : Theme.of(context).colorScheme.error,
                ),
              ),
            )
            .toList(),
      );
}

sealed class PasswordCriteria {
  PasswordCriteria();

  factory PasswordCriteria.minimumCharacters({required int minLength}) => _PasswordCriteriaMinimunChacater(minLength: minLength);

  factory PasswordCriteria.containsLowerCaseLetters() = _PasswordCriteriaContainsLowerCaseLetters;

  factory PasswordCriteria.containsUpperCaseLetters() = _PasswordCriteriaContainsUpperCaseLetters;

  factory PasswordCriteria.containsNumber() = _PasswordCriteriaContainsNumber;

  factory PasswordCriteria.containsSpecialCharacters() = _PasswordCriteriaContainsSpecialCharacters;

  factory PasswordCriteria.notInOrder() = _PasswordCriteriaNotInOrder;

  static List<PasswordCriteria> getAllvalues({required int minLength}) => [
        PasswordCriteria.minimumCharacters(minLength: minLength),
        PasswordCriteria.containsLowerCaseLetters(),
        PasswordCriteria.containsUpperCaseLetters(),
        PasswordCriteria.containsNumber(),
        PasswordCriteria.containsSpecialCharacters(),
        PasswordCriteria.notInOrder(),
      ];

  String get text;
}

class _PasswordCriteriaMinimunChacater extends PasswordCriteria {
  _PasswordCriteriaMinimunChacater({required this.minLength});

  final int minLength;

  @override
  String get text => 'Minimum %s characters'.trArgs([minLength.toString()]);
}

class _PasswordCriteriaContainsLowerCaseLetters extends PasswordCriteria {
  @override
  String get text => 'Contains lowercase letters'.tr;
}

class _PasswordCriteriaContainsUpperCaseLetters extends PasswordCriteria {
  @override
  String get text => 'Contains uppercase letters'.tr;
}

class _PasswordCriteriaContainsNumber extends PasswordCriteria {
  @override
  String get text => 'Contains numbers'.tr;
}

class _PasswordCriteriaContainsSpecialCharacters extends PasswordCriteria {
  @override
  String get text => 'Contains special characters'.tr;
}

class _PasswordCriteriaNotInOrder extends PasswordCriteria {
  @override
  String get text => 'Not in order (123, abc, ABC)'.tr;
}
