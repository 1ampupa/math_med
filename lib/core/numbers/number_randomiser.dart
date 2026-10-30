import 'dart:math';

import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/quizzes/quiz_control.dart';
import 'package:math_med/core/sessions/session_settings.dart';

class NumberRandomiser {
  final int maxRandomiserAttempt = 100;

  final Random _randomiser = Random();

  final int rangeMin, rangeMax;
  final Operator operator;
  late final (int, int) operands;
  final SessionSettings sessionSettings;
  final List<(int, int)> operandsHistory;

  /// [NumberRandomiser] uses for random two numbers so call [operands].
  ///
  /// Provide [rangeMin], [rangeMax], [Operator], [QuizModifier] and [operandsHistory]
  ///
  /// Depends on [Operator] and [QuizModifier], it would have different behaviour.
  ///
  /// ### Warning
  /// Providing [rangeMin] and [rangeMax] too close to each other might make
  /// the generator exceeds its maximum attempt at 100 and throw [StateError].

  NumberRandomiser({
    required this.rangeMin,
    required this.rangeMax,
    required this.operator,
    required this.sessionSettings,
    required this.operandsHistory,
  }) {
    operands = randomOperands();
  }

  /// Random two operands as a integers record

  (int, int) randomOperands() {
    int operandA, operandB;

    for (int attempt = 0; attempt < maxRandomiserAttempt; attempt++) {
      switch (operator) {
        case Operator.addition:
        // Fall through
        case Operator.multiplication:
          operandA = _getRandomFromRange(
            rangeMin,
            rangeMax,
          ); // [rangeMin, rangeMax]
          operandB = _getRandomFromRange(
            rangeMin,
            rangeMax,
          ); // [rangeMin, rangeMax]
          break;
        case Operator.subtraction:
          operandA = _getRandomFromRange(
            rangeMin,
            rangeMax,
          ); // [rangeMin, rangeMax]
          operandB = _getRandomFromRange(
            rangeMin,
            rangeMax,
          ); // [rangeMin, rangeMax]
          if (operandA < operandB) {
            (operandA, operandB) = (operandB, operandA);
          }
          break;
        case Operator.division:
          int minDivisor = max(1, rangeMin); // Prevent divided by 0
          int divisor = _getRandomFromRange(minDivisor, rangeMax);
          int quotient = _getRandomFromRange(rangeMin, rangeMax);

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
        if (!sessionSettings.masterQuizControls[QuizControl
                .allowCommutative]! &&
            (operandB, operandA) == operands) {
          isRepeating = true;
          break;
        }
      }

      if (isRepeating) continue;

      // Quiz modifiers masters
      if ((!sessionSettings.masterQuizControls[QuizControl.allowDuplicated]! &&
              operandA == operandB) ||
          !sessionSettings.masterQuizControls[QuizControl.allowZero]! &&
              (operandA == 0 || operandB == 0)) {
        continue;
      }

      // Quiz modifiers operands
      switch (operator) {
        case Operator.addition:
          if (!sessionSettings.operatorQuizControls[Operator.addition]![QuizControl
                  .allowDuplicated]! &&
              operandA == operandB) {
            continue;
          } else if (!sessionSettings.operatorQuizControls[Operator.addition]![QuizControl
                  .allowCommutative]! &&
              (operandB, operandA) == operands) {
            continue;
          } else if (!sessionSettings.operatorQuizControls[Operator.addition]![QuizControl
                  .allowZero]! &&
              (operandA == 0 || operandB == 0)) {
            continue;
          }
          break;
        case Operator.subtraction:
          if (!sessionSettings.operatorQuizControls[Operator.subtraction]![QuizControl
                  .allowDuplicated]! &&
              operandA == operandB) {
            continue;
          } else if (!sessionSettings.operatorQuizControls[Operator.subtraction]![QuizControl
                  .allowZero]! &&
              (operandA == 0 || operandB == 0)) {
            continue;
          } else if (!sessionSettings.operatorQuizControls[Operator.subtraction]![QuizControl
                  .allowNegativeAnswer]! &&
              (operandA < 0 || operandB < 0)) {
            continue;
          }
          break;
        case Operator.multiplication:
          if (!sessionSettings.operatorQuizControls[Operator.multiplication]![QuizControl
                  .allowDuplicated]! &&
              operandA == operandB) {
            continue;
          } else if (!sessionSettings.operatorQuizControls[Operator.multiplication]![QuizControl
                  .allowCommutative]! &&
              (operandB, operandA) == operands) {
            continue;
          } else if (!sessionSettings.operatorQuizControls[Operator.multiplication]![QuizControl
                  .allowZero]! &&
              (operandA == 0 || operandB == 0)) {
            continue;
          } else if (!sessionSettings.operatorQuizControls[Operator.multiplication]![QuizControl
                  .allowOne]! &&
              (operandA == 1 || operandB == 1)) {
            continue;
          }
          break;
        case Operator.division:
          if (!sessionSettings.operatorQuizControls[Operator.division]![QuizControl
                  .allowDuplicated]! &&
              operandA == operandB) {
            continue;
          } else if (!sessionSettings.operatorQuizControls[Operator.division]![QuizControl
                  .allowZero]! &&
              (operandA == 0 || operandB == 0)) {
            continue;
          } else if (!sessionSettings.operatorQuizControls[Operator.division]![QuizControl
                  .allowOne]! &&
              (operandA == 1 || operandB == 1)) {
            continue;
          }
          break;
      }

      return (operandA, operandB);
    }
    throw StateError("bro we dead");
  }

  int _getRandomFromRange(int rangeMin, int rangeMax) {
    return rangeMin + _randomiser.nextInt(rangeMax - rangeMin + 1);
  }
}
