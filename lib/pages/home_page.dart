import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/providers/quiz_provider.dart';

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
              Text("Quiz"),
              Text("${quiz.operandA} ${quiz.operator.symbol} ${quiz.operandB} = ?"),
              Divider(),
              ElevatedButton(
                onPressed: () {
                  ref.read(quizProvider.notifier).nextQuiz();
                },
                child: const Text("Next Quiz"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
