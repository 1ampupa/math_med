import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_med/core/providers/session_provider.dart';

import 'package:math_med/core/sessions/session.dart';

class ResultPage extends ConsumerWidget {

  const ResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Session session = ref.watch(sessionProvider);
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("GAME RESULT", textScaler: TextScaler.linear(5)),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 50,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Icon(Icons.check, size: 100, color: Color(0xFF00FF00)),
                      Text(
                        "${session.correctAnswer}",
                        textScaler: TextScaler.linear(4),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Icon(Icons.close_sharp, size: 100, color: Color(0xFFFF0000)),
                      Text(
                        "${session.incorrectAnswer}",
                        textScaler: TextScaler.linear(4),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(sessionProvider.notifier).restart();
                },
                child: Text("Play again"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
