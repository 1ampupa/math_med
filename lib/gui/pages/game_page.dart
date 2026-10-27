import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/providers/session_provider.dart';
import 'package:math_med/core/sessions/session.dart';
import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/providers/app_state_data_provider.dart';

import 'package:math_med/gui/pages/error_page.dart';
import 'package:math_med/gui/pages/result_page.dart';
import 'package:math_med/gui/widgets/answer_choices.dart';
import 'package:math_med/gui/widgets/math_med_button.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Session? session = ref.watch(sessionProvider);

    if (session == null) return ErrorPage(errorText: "Session not found.");

    if (session.currentQuiz == null && !session.isComplete) {
      return ErrorPage(
        errorText: "There's no quiz available.\nThis might happen if your quiz modifiers settings are too strict!",
      );
    }

    if (session.isComplete) {
      return ResultPage(session: session);
    }

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 10,
                children: [
                  MathMedButton(
                    text: "X",
                    colourFollowsOperator: false,
                    buttonSize: Size(40, 40),
                    function: () {
                      ref
                          .read(appStateDataProvider.notifier)
                          .changeState(AppState.inLobby);
                      ref.read(sessionProvider.notifier).destroySession();
                    }
                  ),
                  Text(
                    session.operator.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      color: ref.read(appStateDataProvider).selectedOperator.colour
                    ),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: ((session.quizAnswered + session.quizSkipped) / session.maxQuiz),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(100),
                      color: ref.read(appStateDataProvider).selectedOperator.colour,
                      backgroundColor: Colors.grey.shade800,
                    ),
                  ),
                  Text(
                    "${session.quizCreated}/${session.maxQuiz}",
                    style: TextStyle(
                      fontSize: 16,
                      color: ref.read(appStateDataProvider).selectedOperator.colour
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "#${session.quizCreated}",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Anton",
                      color: ref.read(appStateDataProvider).selectedOperator.colour
                    ),
                  ),
                  Text(
                    session.currentQuiz!.equation,
                    style: TextStyle(
                      fontSize: 60,
                      color: ref.read(appStateDataProvider).selectedOperator.colour
                    ),
                  ),
                  Divider(
                    color: ref.read(appStateDataProvider).selectedOperator.colour
                  ),
                  AnswerChoice(),
                ],
              ),
              Column(),
            ],
          ),
        ),
      ),
    );
  }
}
