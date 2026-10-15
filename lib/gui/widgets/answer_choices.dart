import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_med/core/providers/quiz_provider.dart';
import 'package:math_med/core/quizzes/quiz.dart';

class AnswerChoice extends ConsumerWidget {
  const AnswerChoice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Quiz quiz = ref.watch(quizProvider);

    return Row(
      mainAxisAlignment: .center,
      spacing: 15,
      children: [
        for (int i = 0; i < quiz.choices.length; i++)
          SizedBox(
            width: 100,
            height: 150,
            child: ElevatedButton(
              onPressed: () {
                log(
                  "${quiz.equation} submitted ${quiz.choices[i]}. correct: ${quiz.submit(quiz.choices[i])}",
                  level: 0,
                  name: "Quiz",
                );
                ref.read(quizProvider.notifier).nextQuiz();
              },
              child: Text(
                "${quiz.choices[i]}",
                textScaler: TextScaler.linear(3),
              ),
            ),
          )
      ]
    );
  }
}
