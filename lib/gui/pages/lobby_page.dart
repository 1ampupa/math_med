import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/providers/app_state_provider.dart';
import 'package:math_med/core/providers/session_provider.dart';
import 'package:math_med/core/quizzes/quiz_modifier.dart';

class LobbyPage extends ConsumerWidget {
  const LobbyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => ref
                      .read(appStateProvider.notifier)
                      .changeState(AppState.inTitle),
                  child: Text("Back"),
                ),
                Text("Lobby"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(sessionProvider.notifier)
                        .start(Operator.addition, QuizModifier(), 10, 3);
                    ref
                        .read(appStateProvider.notifier)
                        .changeState(AppState.inGame);
                  },
                  child: Text("Start (Operator.addition)"),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(sessionProvider.notifier)
                        .start(Operator.subtraction, QuizModifier(), 10, 3);
                    ref
                        .read(appStateProvider.notifier)
                        .changeState(AppState.inGame);
                  },
                  child: Text("Start (Operator.subtraction)"),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(sessionProvider.notifier)
                        .start(Operator.multiplication, QuizModifier(), 10, 3);
                    ref
                        .read(appStateProvider.notifier)
                        .changeState(AppState.inGame);
                  },
                  child: Text("Start (Operator.multiplication)"),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(sessionProvider.notifier)
                        .start(Operator.division, QuizModifier(), 10, 3);
                    ref
                        .read(appStateProvider.notifier)
                        .changeState(AppState.inGame);
                  },
                  child: Text("Start (Operator.division)"),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("(also very temporary trust me)\n"),
                Text(
                  "Server = 192.168.1.0 wait ts doesnt even need internet lmao",
                ),
                Text("MathMed Alpha Beta Pre Pre Demo V10^-9"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
