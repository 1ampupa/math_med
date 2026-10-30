import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/quizzes/quiz.dart';
import 'package:math_med/core/sessions/session_settings.dart';

class Session {
  static const _unset = Object();

  final Operator operator;
  final SessionSettings sessionSettings;
  final int maxQuiz;
  final int maxChoice;

  final int quizCreated;
  final int quizAnswered;
  final int quizSkipped;
  final int correctAnswer;
  final int incorrectAnswer;

  //
  final List<(int, int)> operandsHistory;
  final Quiz? currentQuiz;
  final bool isComplete;

  const Session({
    required this.operator,
    required this.sessionSettings,
    required this.maxQuiz,
    required this.maxChoice,

    this.quizCreated = 0,
    this.quizAnswered = 0,
    this.quizSkipped = 0,
    this.correctAnswer = 0,
    this.incorrectAnswer = 0,

    this.operandsHistory = const [],
    this.currentQuiz,
    this.isComplete = false,
  });

  /// Use when you want to change the [Session] state.
  /// 
  /// Omitting arguments here would preserve the old one.

  Session copyWith({
    Operator? operator,
    SessionSettings? sessionSettings,
    int? maxQuiz,
    int? maxChoice,

    int? quizCreated,
    int? quizAnswered,
    int? quizSkipped,
    int? correctAnswer,
    int? incorrectAnswer,

    List<(int, int)>? operandsHistory,
    Quiz? currentQuiz,
    bool? isComplete,
  }) {
    return Session(
      operator: operator ?? this.operator,
      sessionSettings: sessionSettings ?? this.sessionSettings,
      maxQuiz: maxQuiz ?? this.maxQuiz,
      maxChoice: maxChoice ?? this.maxChoice,

      quizCreated: quizCreated ?? this.quizCreated,
      quizAnswered: quizAnswered ?? this.quizAnswered,
      quizSkipped: quizSkipped ?? this.quizSkipped,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      incorrectAnswer: incorrectAnswer ?? this.incorrectAnswer,

      operandsHistory: operandsHistory ?? this.operandsHistory,
      currentQuiz: identical(currentQuiz, _unset) ? this.currentQuiz : currentQuiz,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
