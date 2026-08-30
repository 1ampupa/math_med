import 'package:math_med/core/enums/operator.dart';

class Quiz {
  final int operandA, operandB;
  final Operator operator;

  const Quiz({
    required this.operandA,
    required this.operandB,
    required this.operator,
  });

  int get answer => switch (operator) {
    Operator.addition => operandA + operandB,
    Operator.subtraction => operandA - operandB,
    Operator.multiplication => operandA * operandB,
    Operator.division => operandA ~/ operandB,
  };
}
