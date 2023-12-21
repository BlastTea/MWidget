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
          if (text.length >= value.minLength) {
            results.add(value);
          }
          break;
        case _PasswordCriteriaContainsLowerCaseLetters value:
          if (text.contains(RegExp(r'[a-z]'))) {
            results.add(value);
          }
          break;
        case _PasswordCriteriaContainsUpperCaseLetters value:
          if (text.contains(RegExp(r'[A-Z]'))) {
            results.add(value);
          }
          break;
        case _PasswordCriteriaContainsNumber value:
          if (text.contains(RegExp(r'[0-9]'))) {
            results.add(value);
          }
          break;
        case _PasswordCriteriaContainsSpecialCharacters value:
          if (text.contains(RegExp(r'[!@#\$%^&*()_+{}[\]:;<>,.?~\\-]'))) {
            results.add(value);
          }
          break;
      }
    }

    return results;
  }

  @override
  Widget build(BuildContext context) => Column(
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

  static List<PasswordCriteria> getAllvalues({required int minLength}) => [
        PasswordCriteria.minimumCharacters(minLength: minLength),
        PasswordCriteria.containsLowerCaseLetters(),
        PasswordCriteria.containsUpperCaseLetters(),
        PasswordCriteria.containsNumber(),
        PasswordCriteria.containsSpecialCharacters(),
      ];

  String get text;
}

class _PasswordCriteriaMinimunChacater extends PasswordCriteria {
  _PasswordCriteriaMinimunChacater({required this.minLength});

  final int minLength;

  @override
  String get text => Language.getInstance().getValue('Minimum {0} characters', [minLength])!;
}

class _PasswordCriteriaContainsLowerCaseLetters extends PasswordCriteria {
  @override
  String get text => Language.getInstance().getValue('Contains lowercase letters')!;
}

class _PasswordCriteriaContainsUpperCaseLetters extends PasswordCriteria {
  @override
  String get text => Language.getInstance().getValue('Contains uppercase letters')!;
}

class _PasswordCriteriaContainsNumber extends PasswordCriteria {
  @override
  String get text => Language.getInstance().getValue('Contains numbers')!;
}

class _PasswordCriteriaContainsSpecialCharacters extends PasswordCriteria {
  @override
  String get text => Language.getInstance().getValue('Contains special characters')!;
}
