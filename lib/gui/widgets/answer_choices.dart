import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/sessions/session.dart';
import 'package:math_med/core/providers/session_provider.dart';

class AnswerChoice extends ConsumerWidget {
  const AnswerChoice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Session? session = ref.watch(sessionProvider);

    if (session == null) throw StateError;

    return Column(
      mainAxisAlignment: .center,
      spacing: 15,
      children: [
        for (int i = 0; i < session.currentQuiz!.choices.length; i++)
          SizedBox(
            width: 300,
            height: 100,
            child: ElevatedButton(
              onPressed: () {
                log(
                  "${session.quizCreated}. ${session.currentQuiz!.equation} submitted ${session.currentQuiz!.choices[i]}. correct: ${session.currentQuiz!.submit(session.currentQuiz!.choices[i])}",
                  level: 0,
                  name: "Quiz",
                );
                ref.read(sessionProvider.notifier).nextQuiz(false, session.currentQuiz!.submit(session.currentQuiz!.choices[i]));
              },
              child: Text(
                "${session.currentQuiz!.choices[i]}",
                textScaler: TextScaler.linear(3),
              ),
            ),
          )
      ]
    );
  }
}
