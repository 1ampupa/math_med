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
  final List<(int, int)> operandsHistory;

  NumberRandomiser({
    required this.rangeMin,
    required this.rangeMax,
    required this.operator,
    required this.quizModifier,
    required this.operandsHistory,
  }) {
    operands = randomOperands();
  }

  (int, int) randomOperands() {
    int operandA, operandB;

    for (int attempt = 0; attempt < maxRandomiserAttempt; attempt++) {
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

      // Quiz repeating operands
      bool isRepeating = false;
      for ((int, int) operands in operandsHistory) {
        if ((operandA, operandB) == operands) {
          isRepeating = true;
          break;
        }
        if (!quizModifier.masterAllowCommutative &&
        (operandB, operandA) == operands) {
          isRepeating = true;
          break;
        }
      }

      if (isRepeating) continue;

      // Quiz modifiers masters
      if ((!quizModifier.masterAllowDuplicated && operandA == operandB) ||
          !quizModifier.masterAllowZero && (operandA == 0 || operandB == 0)) {
            continue;
      }

      // Quiz modifiers operands
      switch (operator) {
        case Operator.addition:
          if (!quizModifier.additionAllowDuplicated && operandA == operandB) {
            continue;
          } else if (!quizModifier.additionAllowZero && (operandA == 0 || operandB == 0)) {
            continue;
          } else if (!quizModifier.additionAllowCommutative && (operandB, operandA) == operands) {
            continue;
          }
          break;
        case Operator.subtraction:
          if (!quizModifier.subtractionAllowDuplicated && operandA == operandB) {
            continue;
          } else if (!quizModifier.subtractionAllowZero && (operandA == 0 || operandB == 0)) {
            continue;
          } else if (!quizModifier.subtractionAllowNegative && (operandA < 0 || operandB < 0)) {
            continue;
          }
          break;
        case Operator.multiplication:
          if (!quizModifier.multiplicationAllowDuplicated && operandA == operandB) {
            continue;
          } else if (!quizModifier.multiplicationAllowZero && (operandA == 0 || operandB == 0)) {
            continue;
          } else if (!quizModifier.multiplicationAllowOne && (operandA == 1 || operandB == 1)) {
            continue;
          } else if (!quizModifier.multiplicationAllowCommutative && (operandB, operandA) == operands) {
            continue;
          }
          break;
        case Operator.division:
          if (!quizModifier.divisionAllowDuplicated && operandA == operandB) {
            continue;
          } else if (!quizModifier.divisionAllowZero && (operandA == 0 || operandB == 0)) {
            continue;
          } else if (!quizModifier.divisionAllowOne && (operandA == 1 || operandB == 1)) {
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
