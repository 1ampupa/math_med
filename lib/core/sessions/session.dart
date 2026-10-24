import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/quizzes/quiz.dart';
import 'package:math_med/core/quizzes/quiz_modifier.dart';

class Session {
  static const _unset = Object();

  final Operator operator;
  final QuizModifier quizModifier;
  final int maxQuiz;
  final int maxChoices;

  final int quizCreated;
  final int quizAnswered;
  final int quizSkipped;
  final int correctAnswer;
  final int incorrectAnswer;

  final Quiz? currentQuiz;
  final bool isComplete;

  const Session({
    required this.operator,
    required this.quizModifier,
    this.maxQuiz = 10,
    this.maxChoices = 3,
    this.quizCreated = 0,
    this.quizAnswered = 0,
    this.quizSkipped = 0,
    this.correctAnswer = 0,
    this.incorrectAnswer = 0,
    this.currentQuiz,
    this.isComplete = false,
  });

  Session copyWith({
    Operator? operator,
    QuizModifier? quizModifer,
    int? quizCreated,
    int? quizAnswered,
    int? quizSkipped,
    int? correctAnswer,
    int? incorrectAnswer,
    Quiz? currentQuiz,
    bool? isComplete,
  }) {
    return Session(
      operator: operator ?? this.operator,
      quizModifier: quizModifer ?? quizModifier,
      quizCreated: quizCreated ?? this.quizCreated,
      quizAnswered: quizAnswered ?? this.quizAnswered,
      quizSkipped: quizSkipped ?? this.quizSkipped,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      incorrectAnswer: incorrectAnswer ?? this.incorrectAnswer,
      currentQuiz: identical(currentQuiz, _unset) ? this.currentQuiz : currentQuiz,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}

/*
operator: state.operator,
maxQuiz: state.maxQuiz,
maxChoices: state.maxChoices,
quizCreated: state.quizCreated + 1,
quizAnswered: state.quizAnswered,
quizSkipped: state.quizSkipped,
correctAnswer: state.correctAnswer,
incorrectAnswer: state.incorrectAnswer,
currentQuiz: _generateQuiz(state.operator),
*/