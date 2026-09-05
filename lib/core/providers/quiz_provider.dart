import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/quiz/quiz.dart';
import 'package:math_med/numbers/number_randomiser.dart';

class QuizNotifier extends Notifier<Quiz> {

  @override
  Quiz build() {
    return _generateQuiz(1, 5, Operator.addition);
  }

  void nextQuiz() {
    state = _generateQuiz(1, 5, Operator.addition);
  }

  // Generator
  Quiz _generateQuiz(int rangeMin, int rangeMax, Operator operator) {
    (int, int) randomOperands = NumberRandomiser(
      rangeMin: rangeMin,
      rangeMax: rangeMax,
      operator: operator
    ).operands;
    return Quiz(
      operandA: randomOperands.$1, // [1, 5]
      operandB: randomOperands.$2,
      operator: operator,
    );
  }
}

// Provider
final quizProvider = NotifierProvider<QuizNotifier, Quiz>(QuizNotifier.new);
