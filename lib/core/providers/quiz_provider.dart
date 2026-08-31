import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/quiz/quiz.dart';

class QuizNotifier extends Notifier<Quiz> {
  final Random _randomiser = Random();

  @override
  Quiz build() {
    return _generateQuiz();
  }

  void nextQuiz() {
    state = _generateQuiz();
  }

  // Generator
  Quiz _generateQuiz() {
    return Quiz(
      operandA: _randomiser.nextInt(10) + 1, // [1, 10]
      operandB: _randomiser.nextInt(10) + 1,
      operator: Operator.division,
    );
  }
}

// Provider
final quizProvider = NotifierProvider<QuizNotifier, Quiz>(QuizNotifier.new);
