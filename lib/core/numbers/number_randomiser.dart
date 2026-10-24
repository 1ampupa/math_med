import 'dart:math';

import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/quizzes/quiz_modifier.dart';

class NumberRandomiser {
  final int maxRandomiserAttempt = 100;

  final Random _randomiser = Random();

  final int rangeMin, rangeMax;
  final Operator operator;
  late final (int, int) operands;
  final QuizModifier quizModifier;

  NumberRandomiser({
    required this.rangeMin,
    required this.rangeMax,
    required this.operator,
    required this.quizModifier,
  }) {
    operands = randomOperands();
  }

  (int, int) randomOperands() {
    int operandA, operandB;
    int attempt = 0;
    while (attempt < maxRandomiserAttempt) {
      switch (operator) {
        case Operator.addition:
        // Fall through
        case Operator.multiplication:
          operandA = getRandomFromRange(
            rangeMin,
            rangeMax,
          ); // [rangeMin, rangeMax]
          operandB = getRandomFromRange(
            rangeMin,
            rangeMax,
          ); // [rangeMin, rangeMax]
          break;
        case Operator.subtraction:
          operandA = getRandomFromRange(
            rangeMin,
            rangeMax,
          ); // [rangeMin, rangeMax]
          operandB = getRandomFromRange(
            rangeMin,
            rangeMax,
          ); // [rangeMin, rangeMax]
          if (operandA < operandB) {
            (operandA, operandB) = (operandB, operandA);
          }
          break;
        case Operator.division:
          int minDivisor = max(1, rangeMin); // Prevent divided by 0
          int divisor = getRandomFromRange(minDivisor, rangeMax);
          int quotient = getRandomFromRange(rangeMin, rangeMax);

          // Produce whole number division
          operandA = quotient * divisor;
          operandB = divisor;
          break;
      }

      // Quiz modifiers masters
      if (!quizModifier.masterAllowDuplicated && operandA == operandB) {
        attempt++;
        continue;
      } else if (!quizModifier.masterAllowZero && (operandA == 0 || operandB == 0)) {
        attempt++;
        continue;
      }

      // Quiz modifiers operands
      switch (operator) {
        case Operator.addition:
          if (!quizModifier.additionAllowDuplicated && operandA == operandB) {
            attempt++;
            continue;
          } else if (!quizModifier.additionAllowZero && (operandA == 0 || operandB == 0)) {
            attempt++;
            continue;
          }
          break;
        case Operator.subtraction:
          if (!quizModifier.subtractionAllowDuplicated && operandA == operandB) {
            attempt++;
            continue;
          } else if (!quizModifier.subtractionAllowZero && (operandA == 0 || operandB == 0)) {
            attempt++;
            continue;
          } else if (!quizModifier.subtractionAllowNegative && (operandA < 0 || operandB < 0)) {
            attempt++;
            continue;
          }
          break;
        case Operator.multiplication:
          if (!quizModifier.multiplicationAllowDuplicated && operandA == operandB) {
            attempt++;
            continue;
          } else if (!quizModifier.multiplicationAllowZero && (operandA == 0 || operandB == 0)) {
            attempt++;
            continue;
          } else if (!quizModifier.multiplicationAllowOne && (operandA == 1 || operandB == 1)) {
            attempt++;
            continue;
          }
          break;
        case Operator.division:
          if (!quizModifier.divisionAllowDuplicated && operandA == operandB) {
            attempt++;
            continue;
          } else if (!quizModifier.divisionAllowZero && (operandA == 0 || operandB == 0)) {
            attempt++;
            continue;
          } else if (!quizModifier.divisionAllowOne && (operandA == 1 || operandB == 1)) {
            attempt++;
            continue;
          }
          break;
      }

      return (operandA, operandB);
    }
    throw StateError("bro we dead");
  }

  int getRandomFromRange(int rangeMin, int rangeMax) {
    return rangeMin + _randomiser.nextInt(rangeMax - rangeMin + 1);
  }
}
