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
    final Session session = ref.watch(sessionProvider);
    
    if (session.currentQuiz == null && !session.isComplete) {
      return ErrorPage(errorText: "There's no quiz available.");
    }

    if (session.isComplete) {
      return ResultPage();
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
                "Quiz #${session.quizCreated}"
              ),
              Text(
                "Which one is correct?",
                textScaler: TextScaler.linear(1.5),
              ),
              Text(
                session.currentQuiz!.equation,
                textScaler: TextScaler.linear(3),
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
