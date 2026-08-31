import 'dart:math';

import 'package:math_med/core/enums/operator.dart';

class Quiz {
  final int operandA, operandB;
  final Operator operator;
  final List<int> choices;

  static const int maxChoiceAmount = 3; // Temporary hardcoded

  static final Random _randomiser = Random();

  Quiz({
    required this.operandA,
    required this.operandB,
    required this.operator
  })
    : choices = generateChoices(calculateAnswer(operandA, operandB, operator), operator);

  // Answer generator

  static int calculateAnswer(int operandA, int operandB, Operator operator) {
    // Assume the given numbers are sanitised by NumberRandomiser
    return switch (operator) {
      Operator.addition => operandA + operandB,
      Operator.subtraction => operandA - operandB,
      Operator.multiplication => operandA * operandB,
      Operator.division => operandA ~/ operandB
    };
  }

  int get answer => calculateAnswer(operandA, operandB, operator);

  // Choice generator

  static int _generateAdditiveDistractor(int answer, int range) {
    int fakeAnswer = answer + _randomiser.nextInt(range * 2) - range; // [answer - range, answer + range - 1]

    // Avoid negative number and same
    if (fakeAnswer < 0) fakeAnswer = fakeAnswer.abs();

    return fakeAnswer; // Return as-is
  }

  static List<int> generateChoices(int answer, Operator operator) {
    Set<int> choices = {answer};

    while (choices.length < maxChoiceAmount) {
      int range = max(2, (answer / 2).round()); // Set the choice bound from half of the answer or 2 if too low.
      int fakeAnswer;
      switch (operator) {
        case Operator.addition:
          // Fall through Subtraction
        case Operator.subtraction:
          fakeAnswer = _generateAdditiveDistractor(answer, range);
          break;
        case Operator.multiplication: // TODO Multiplicative and Divisive Distractors
          // Fall through Division
        case Operator.division:
          // Protect against nextInt(0) or small answers
          int maxBound = max(2, answer);
          fakeAnswer = _randomiser.nextInt((maxBound * 1.5).round()) + 1;
          break;
      }

      // Add the choice
      choices.add(fakeAnswer);
    }

    return choices.toList()..shuffle();
  }

  // Readable equation
  String get equation => "$operandA ${operator.symbol} $operandB = ?";
}
