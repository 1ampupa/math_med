import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/providers/quiz_provider.dart';
import 'package:math_med/gui/widgets/answer_choices.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quiz = ref.watch(quizProvider);

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Which one is correct?",
                textScaler: TextScaler.linear(1.5),
              ),
              Text(
                quiz.equation,
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
