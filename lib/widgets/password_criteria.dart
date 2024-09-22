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
        case PasswordCriteriaMinimunCharacters value:
          if (text.length >= value.minLength) results.add(value);
        case PasswordCriteriaContainsLowerCaseLetters value:
          if (text.contains(RegExp(r'[a-z]'))) results.add(value);
        case PasswordCriteriaContainsUpperCaseLetters value:
          if (text.contains(RegExp(r'[A-Z]'))) results.add(value);
        case PasswordCriteriaContainsNumber value:
          if (text.contains(RegExp(r'[0-9]'))) results.add(value);
        case PasswordCriteriaContainsSpecialCharacters value:
          if (text.contains(RegExp(r'[!@#\$%^&*()_+{}[\]:;<>,.?~\\-]'))) results.add(value);
        case PasswordCriteriaNotInOrder value:
          if (!text.containsSequential()) results.add(value);
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
  const PasswordCriteria();

  const factory PasswordCriteria.minimumCharacters({required int minLength}) = PasswordCriteriaMinimunCharacters;

  const factory PasswordCriteria.containsLowerCaseLetters() = PasswordCriteriaContainsLowerCaseLetters;

  const factory PasswordCriteria.containsUpperCaseLetters() = PasswordCriteriaContainsUpperCaseLetters;

  const factory PasswordCriteria.containsNumber() = PasswordCriteriaContainsNumber;

  const factory PasswordCriteria.containsSpecialCharacters() = PasswordCriteriaContainsSpecialCharacters;

  const factory PasswordCriteria.notInOrder() = PasswordCriteriaNotInOrder;

  static List<PasswordCriteria> getAllvalues({required int minLength}) => [
        PasswordCriteria.minimumCharacters(minLength: minLength),
        const PasswordCriteria.containsLowerCaseLetters(),
        const PasswordCriteria.containsUpperCaseLetters(),
        const PasswordCriteria.containsNumber(),
        const PasswordCriteria.containsSpecialCharacters(),
        const PasswordCriteria.notInOrder(),
      ];

  String get text;
}

class PasswordCriteriaMinimunCharacters extends PasswordCriteria {
  const PasswordCriteriaMinimunCharacters({required this.minLength});

  final int minLength;

  @override
  String get text => 'Minimum %s characters'.trArgs([minLength.toString()]);
}

class PasswordCriteriaContainsLowerCaseLetters extends PasswordCriteria {
  const PasswordCriteriaContainsLowerCaseLetters();

  @override
  String get text => 'Contains lowercase letters'.tr;
}

class PasswordCriteriaContainsUpperCaseLetters extends PasswordCriteria {
  const PasswordCriteriaContainsUpperCaseLetters();

  @override
  String get text => 'Contains uppercase letters'.tr;
}

class PasswordCriteriaContainsNumber extends PasswordCriteria {
  const PasswordCriteriaContainsNumber();

  @override
  String get text => 'Contains numbers'.tr;
}

class PasswordCriteriaContainsSpecialCharacters extends PasswordCriteria {
  const PasswordCriteriaContainsSpecialCharacters();

  @override
  String get text => 'Contains special characters'.tr;
}

class PasswordCriteriaNotInOrder extends PasswordCriteria {
  const PasswordCriteriaNotInOrder();

  @override
  String get text => 'Not in order (123, abc, ABC)'.tr;
}
