import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/providers/app_state_provider.dart';
import 'package:math_med/core/providers/session_provider.dart';
import 'package:math_med/core/quizzes/quiz_modifier.dart';

class CreateSessionPage extends ConsumerWidget{
  
  const CreateSessionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Lobby"),
            ElevatedButton(
              onPressed: () {
                ref.read(sessionProvider.notifier).start(Operator.addition, QuizModifier(), 10, 3);
                ref.read(appStateProvider.notifier).changeState(AppState.inGame);
              },
              child: Text("Start")
            )
          ],
        ),
      ),
    );
  }
}
