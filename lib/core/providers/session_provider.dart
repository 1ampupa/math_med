import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/quizzes/quiz.dart';
import 'package:math_med/core/quizzes/quiz_modifier.dart';
import 'package:math_med/core/sessions/session.dart';

class SessionNotifier extends Notifier<Session?> {

  static const int maxOperandsHistory = 5;

  @override
  Session? build() => null;

  /// Create new [Session], which you may provide custom [Operator], [QuizModifier],
  /// [maxQuiz] and [maxChoice]
  
  Session _createSession({
    required Operator operator,
    required QuizModifier quizModifier,
    required int maxQuiz,
    required int maxChoice,
  }) {
    final Quiz? quiz = Quiz.generateQuiz(operator, quizModifier, [], maxChoice);

    if (quiz == null) {
      throw StateError("Failed to generate initial quiz");
    }

    return Session(
      operator: operator,
      quizModifier: quizModifier,
      maxQuiz: maxQuiz,
      maxChoice: maxChoice,
      quizCreated: 1,
      currentQuiz: quiz,
      operandsHistory: [(quiz.operandA, quiz.operandB)],
    );
  }

  /// Start the new [Session]

  void start(Operator operator, QuizModifier quizModifier, int maxQuiz, int maxChoice) {
    state = _createSession(
      operator: operator,
      quizModifier: quizModifier,
      maxQuiz: maxQuiz,
      maxChoice: maxChoice,
    );
  }

  /// Restart the current [Session]

  void restart() {
    final currentSession = state;
    if (currentSession == null) throw StateError;

    start(currentSession.operator, currentSession.quizModifier, currentSession.maxQuiz, currentSession.maxChoice);
    log("Session restarted", level: 0, name: "SessionProvider");
  }

  /// Generate the next [Quiz]

  void nextQuiz(bool skip, bool correct) {
    final currentSession = state;
    if (currentSession == null) throw StateError;

    state = currentSession.copyWith(
      quizAnswered: !skip
          ? currentSession.quizAnswered + 1
          : currentSession.quizAnswered,
      quizSkipped: skip
          ? currentSession.quizSkipped + 1 
          : currentSession.quizSkipped,
      correctAnswer: (!skip && correct)
          ? currentSession.correctAnswer + 1
          : currentSession.correctAnswer,
      incorrectAnswer: (!skip && !correct)
          ? currentSession.incorrectAnswer + 1
          : currentSession.incorrectAnswer,
    );

    final updatedSession = state!;

    log(
      "Answered: ${updatedSession.quizAnswered} Skipped: ${updatedSession.quizSkipped} C:W = ${updatedSession.correctAnswer} : ${updatedSession.incorrectAnswer}",
      level: 0,
      name: "SessionProvider.telemetry",
    );

    if (isSessionComplete(updatedSession)) return;

    final Quiz? newQuiz = Quiz.generateQuiz(
      updatedSession.operator,
      updatedSession.quizModifier,
      updatedSession.operandsHistory,
      updatedSession.maxChoice
    );

    if (newQuiz == null) {
      destroySession();
      return;
    }

    // Check for repeating operands
    List<(int, int)> newOperandsHistory = [...updatedSession.operandsHistory];
    if (newOperandsHistory.length >= maxOperandsHistory) {
      newOperandsHistory.removeAt(0);
    }
    newOperandsHistory.add((newQuiz.operandA, newQuiz.operandB));

    state = updatedSession.copyWith(
      quizCreated: updatedSession.quizCreated + 1,
      currentQuiz: newQuiz,
      operandsHistory: newOperandsHistory,
    );
  }

  /// Check if wheather the [Session] is completed or not

  bool isSessionComplete(Session session) {
    if (session.quizCreated >= session.maxQuiz) {
      state = session.copyWith(isComplete: true, currentQuiz: null);
      
      return true;
    }
    return false;
  }

  /// Uses when the current [Session] is completed or impossible to continue,
  /// such as cannot generator more quiz due to exceeding generator limit.

  void destroySession() {
    state = null;
    log("Session abandoned", level: 0, name: "SessionProvider");
  }

}

final sessionProvider = NotifierProvider<SessionNotifier, Session?>(
  SessionNotifier.new,
);
