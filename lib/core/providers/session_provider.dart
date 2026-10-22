import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/quizzes/quiz.dart';
import 'package:math_med/core/sessions/session.dart';

class SessionNotifier extends Notifier<Session> {
  @override
  Session build() {
    const operator = Operator.multiplication;

    return Session(
      operator: operator,
      currentQuiz: Quiz.generateQuiz(operator),
      quizCreated: 1,
    );
  }

  void start() {
    state = Session(
      operator: state.operator,
      maxQuiz: state.maxQuiz,
      maxChoices: state.maxChoices,
      quizCreated: 1,
      currentQuiz: Quiz.generateQuiz(state.operator),
    );
  }

  void restart() {
    state = state.copyWith(
      operator: state.operator,
      quizCreated: 1, // don't use 0 or it'll create one excess quiz!
      quizAnswered: 0,
      quizSkipped: 0,
      correctAnswer: 0,
      incorrectAnswer: 0,
      currentQuiz: Quiz.generateQuiz(state.operator),
      isComplete: false,
    );
    log(
      "Session restarted",
      level: 0,
      name: "SessionProvider"
    );
  }

  void nextQuiz(bool skip, bool correct) {
    state = state.copyWith(
      quizAnswered: !skip ? state.quizAnswered + 1 : state.quizAnswered,
      quizSkipped: skip ? state.quizSkipped + 1 : state.quizSkipped,
      correctAnswer: (!skip && correct) ? state.correctAnswer + 1 : state.correctAnswer,
      incorrectAnswer: (!skip && !correct) ? state.incorrectAnswer + 1 : state.incorrectAnswer,
    );

    log(
      "Answered: ${state.quizAnswered} Skipped: ${state.quizSkipped} C:W = ${state.correctAnswer} : ${state.incorrectAnswer}",
      level: 0,
      name: "SessionProvider.telemetry",
    );

    if (isSessionComplete()) return;

    state = state.copyWith(
      quizCreated: state.quizCreated + 1,
      currentQuiz: Quiz.generateQuiz(state.operator),
    );
  }

  bool isSessionComplete() {
    if (state.quizCreated >= state.maxQuiz) {
      state = state.copyWith(isComplete: true, currentQuiz: null);
      log(
        "Session completed",
        level: 0,
        name: "SessionProvider",
      );
      return true;
    }
    return false;
  }
}

final sessionProvider =
    NotifierProvider<SessionNotifier, Session>(
  SessionNotifier.new,
);