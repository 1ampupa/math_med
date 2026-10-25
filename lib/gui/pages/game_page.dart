import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/providers/session_provider.dart';
import 'package:math_med/core/sessions/session.dart';

import 'package:math_med/gui/pages/error_page.dart';
import 'package:math_med/gui/pages/result_page.dart';
import 'package:math_med/gui/widgets/answer_choices.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final Session? session = ref.watch(sessionProvider);
    
    if (session == null) return ErrorPage(errorText: "Session not found.");

    if (session.currentQuiz == null && !session.isComplete) {
      return ErrorPage(errorText: "There's no quiz available.\nThis might happen if your quiz modifiers settings are too strict!");
    }

    if (session.isComplete) {
      return ResultPage(session: session);
    }

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "#${session.quizCreated}",
                textScaler: TextScaler.linear(2),
                style: TextStyle(
                  fontFamily: "Anton"
                ),
              ),
              Text(
                session.currentQuiz!.equation,
                textScaler: TextScaler.linear(4),
              ),
              Divider(),
              AnswerChoice(),
            ],
          ),
        ),
      ),
    );
  }
}
