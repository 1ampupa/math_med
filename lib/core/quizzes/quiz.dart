import 'dart:math';

import 'package:math_med/core/enums/operator.dart';

class Quiz {
  final int operandA, operandB;
  final Operator operator;
  final List<int> choices;

  static const int maxChoiceAmount = 3; // Temporary hardcoded

  Quiz({
    required this.operandA,
    required this.operandB,
    required this.operator,
    Random? random,
  }) : choices = generateChoices(
         calculateAnswer(operandA, operandB, operator),
         operator,
         random ?? Random(),
       );

  // Answer generator

  static int calculateAnswer(int operandA, int operandB, Operator operator) {
    // Assume the given numbers are sanitised by NumberRandomiser
    return switch (operator) {
      Operator.addition => operandA + operandB,
      Operator.subtraction => operandA - operandB,
      Operator.multiplication => operandA * operandB,
      Operator.division => operandA ~/ operandB,
    };
  }

  int get answer => calculateAnswer(operandA, operandB, operator);

  // Choice generator

  static int _generateAdditiveDistractor(int answer, Random random) {
    int range = max(2, (answer / 3).round());
    int fakeAnswer =
        answer +
        random.nextInt(range * 2) -
        range; // [answer - range, answer + range - 1]

    // Avoid negative number and same
    if (fakeAnswer < 0) fakeAnswer = fakeAnswer.abs();

    return fakeAnswer; // Return as-is
  }

  static int _generateMultiplicativeDistractor(
    int answer,
    (double, double) deviationRange,
    Random random,
  ) {
    double deviation =
        deviationRange.$1 +
        (random.nextDouble() * (deviationRange.$2 - deviationRange.$1));
    int offset = max(1, (answer * deviation).round());

    if (random.nextBool()) {
      return answer + offset;
    } else {
      int fakeAnswer = answer - offset;

      return fakeAnswer > 0 ? fakeAnswer : answer + offset;
    }
  }

  static List<int> generateChoices(
    int answer,
    Operator operator,
    Random? random,
  ) {
    final rand = random ?? Random();

    Set<int> choices = {answer};
    int attempt = 0;

    while (choices.length < maxChoiceAmount) {
      attempt++;

      // Fallback
      if (attempt > 100) {
        int fallback = answer + choices.length;
        choices.add(fallback);
        continue;
      }

      int fakeAnswer = switch (operator) {
        Operator.addition ||
        Operator.subtraction => _generateAdditiveDistractor(answer, rand),
        Operator.multiplication || Operator.division =>
          _generateMultiplicativeDistractor(answer, (0.1, 0.5), rand),
      };

      // Add the choice
      choices.add(fakeAnswer);
    }

    return choices.toList()..sort();
  }

  // User answer
  bool submit(int choice) {
    return choice == answer;
  }

  // Readable equation
  String get equation => "$operandA ${operator.symbol} $operandB = ?";
}
