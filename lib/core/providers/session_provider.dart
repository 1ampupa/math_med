import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/quizzes/quiz.dart';
import 'package:math_med/core/quizzes/quiz_modifier.dart';
import 'package:math_med/core/sessions/session.dart';

class SessionNotifier extends Notifier<Session> {

  static const int maxOperandsHistory = 5;

  @override
  Session build() {
    final operator = Operator.addition; // hardcoded
    final QuizModifier quizModifier = QuizModifier(); // hardcoded

    return _createSession(
      operator: operator,
      quizModifier: quizModifier,
      maxQuiz: 100,
      maxChoices: 3,
    );
  }

  /// Create new [Session], which you may provide custom [Operator], [QuizModifier],
  /// [maxQuiz] and [maxChoices]
  
  Session _createSession({
    required Operator operator,
    required QuizModifier quizModifier,
    required int maxQuiz,
    required int maxChoices,
  }) {
    final Quiz? quiz = Quiz.generateQuiz(operator, quizModifier, [], maxChoices);

    if (quiz == null) {
      throw StateError("Failed to generate initial quiz");
    }

    return Session(
      operator: operator,
      quizModifier: quizModifier,
      maxQuiz: maxQuiz,
      maxChoices: maxChoices,
      quizCreated: 1,
      currentQuiz: quiz,
      operandsHistory: [(quiz.operandA, quiz.operandB)],
    );
  }

  /// Start the current [Session]

  void start() {
    state = _createSession(
      operator: state.operator,
      quizModifier: state.quizModifier,
      maxQuiz: state.maxQuiz,
      maxChoices: state.maxChoices,
    );
  }

  /// Restart the current [Session]

  void restart() {
    start();
    log("Session restarted", level: 0, name: "SessionProvider");
  }

  /// Generate the next [Quiz]

  void nextQuiz(bool skip, bool correct) {
    state = state.copyWith(
      quizAnswered: !skip ? state.quizAnswered + 1 : state.quizAnswered,
      quizSkipped: skip ? state.quizSkipped + 1 : state.quizSkipped,
      correctAnswer: (!skip && correct)
          ? state.correctAnswer + 1
          : state.correctAnswer,
      incorrectAnswer: (!skip && !correct)
          ? state.incorrectAnswer + 1
          : state.incorrectAnswer,
    );

    log(
      "Answered: ${state.quizAnswered} Skipped: ${state.quizSkipped} C:W = ${state.correctAnswer} : ${state.incorrectAnswer}",
      level: 0,
      name: "SessionProvider.telemetry",
    );

    if (isSessionComplete()) return;

    final Quiz? newQuiz = Quiz.generateQuiz(
      state.operator,
      state.quizModifier,
      state.operandsHistory,
      state.maxChoices
    );

    if (newQuiz == null) {
      destroySession();
      return;
    }

    // Check for repeating operands
    List<(int, int)> newOperandsHistory = [...state.operandsHistory];
    if (newOperandsHistory.length >= maxOperandsHistory) {
      newOperandsHistory.removeAt(0);
    }
    newOperandsHistory.add((newQuiz.operandA, newQuiz.operandB));

    state = state.copyWith(
      quizCreated: state.quizCreated + 1,
      currentQuiz: newQuiz,
      operandsHistory: newOperandsHistory,
    );
  }

  /// Check if wheather the [Session] is completed or not

  bool isSessionComplete() {
    if (state.quizCreated >= state.maxQuiz) {
      state = state.copyWith(isComplete: true, currentQuiz: null);
      log("Session completed", level: 0, name: "SessionProvider");
      return true;
    }
    return false;
  }

  /// Uses when the current [Session] is impossible to continue,
  /// such as cannot generator more quiz due to exceeding generator limit.

  void destroySession() {
    state = Session(
      operator: state.operator,
      quizModifier: state.quizModifier,
      maxQuiz: state.maxQuiz,
      maxChoices: state.maxChoices,
      currentQuiz: null, // :sob:
    );
  }
}

final sessionProvider = NotifierProvider<SessionNotifier, Session>(
  SessionNotifier.new,
);
