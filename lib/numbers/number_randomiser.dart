import 'dart:math';

import 'package:math_med/core/enums/operator.dart';

class NumberRandomiser {

  static const int maxRandomiserAttempt = 100;

  static final Random _randomiser = Random();

  final int rangeMin, rangeMax;
  final Operator operator;
  final (int, int) operands;

  NumberRandomiser({
    required this.rangeMin,
    required this.rangeMax,
    required this.operator,
  })
    : operands = randomOperands(rangeMin, rangeMax, operator);

  static (int, int) randomOperands(int rangeMin, int rangeMax, Operator operator) {
    int operandA, operandB;
    switch (operator) {
      case Operator.addition:
        // Fall through
      case Operator.multiplication:
        operandA = getRandomFromRange(rangeMin, rangeMax); // [rangeMin, rangeMax]
        operandB = getRandomFromRange(rangeMin, rangeMax); // [rangeMin, rangeMax]
        break;
      case Operator.subtraction:
        operandA = getRandomFromRange(rangeMin, rangeMax); // [rangeMin, rangeMax]
        operandB = getRandomFromRange(rangeMin, rangeMax); // [rangeMin, rangeMax]
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
    return (operandA, operandB);
  }

  static int getRandomFromRange(int rangeMin, int rangeMax) {
    return rangeMin + _randomiser.nextInt(rangeMax - rangeMin + 1);
  }
}