import 'dart:math';

import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/numbers/number_randomiser.dart';
import 'package:math_med/core/quizzes/quiz_modifier.dart';

class Quiz {
  final int operandA, operandB;
  final Operator operator;
  final List<int> choices;
  final QuizModifier quizModifier;
  final int maxChoiceAmount;

  /// [Quiz] is one of the most important element in MathMed, which provide a question to the [Session].
  /// 
  /// Provide [operandA], [operandB], [Operator], [QuizModifier] and [maxChoiceAmount] to generate a quiz.
  /// Although, you should use [generateQuiz] function more, which is optimised for [Session] usage.
  /// This constructor can be use if you have certain operands and operator.
  /// 
  /// Additionally, you can provide [Random] with [seed] to ensure the same result for testing purpose.

  Quiz({
    required this.operandA,
    required this.operandB,
    required this.operator,
    required this.quizModifier,
    required this.maxChoiceAmount,
    Random? random, // this can be set as seed
  }) : choices = generateChoices(
         calculateAnswer(operandA, operandB, operator),
         maxChoiceAmount,
         operator,
         quizModifier,
         random ?? Random(),
       );

  /// Create a new random [Quiz] using [Operator], [QuizModifier], [operandsHistory] and [maxChoiceAmount]
  /// 
  /// #### Warning
  /// If the provided [QuizModifier] is too strict, it might result in [StateError] which result null and
  /// cause the [Session] to be destroyed.

  static Quiz? generateQuiz(Operator operator, QuizModifier quizModifier, List<(int, int)> operandsHistory, int maxChoiceAmount) {
    final (int, int) operands;

    try {
      operands = NumberRandomiser(
      rangeMin: 1, // hardcoded
      rangeMax: 5, // hardcoded
      operator: operator,
      quizModifier: quizModifier,
      operandsHistory: operandsHistory,
      ).operands;
    } on StateError {
      return null;
    }

    return Quiz(
      operandA: operands.$1,
      operandB: operands.$2,
      operator: operator,
      quizModifier: quizModifier,
      maxChoiceAmount: maxChoiceAmount,
    );
  }

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

    int offset = max(1, (answer.abs() * deviation).round());

    if (random.nextBool()) {
      return answer + offset;
    } else {
      int fakeAnswer = answer - offset;
      return fakeAnswer > 0 ? fakeAnswer : answer + offset;
    }
  }

  static List<int> generateChoices(
    int answer,
    int maxChoiceAmount,
    Operator operator,
    QuizModifier quizModifier,
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

    return quizModifier.shuffleChoices ? (choices.toList()..shuffle()) : (choices.toList()..sort());
  }

  // User answer
  bool submit(int choice) {
    return choice == answer;
  }

  // Readable equation
  String get equation => "$operandA ${operator.symbol} $operandB";
}
