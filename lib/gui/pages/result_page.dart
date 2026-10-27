import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/providers/app_state_data_provider.dart';
import 'package:math_med/core/providers/session_provider.dart';
import 'package:math_med/core/sessions/session.dart';
import 'package:math_med/gui/widgets/math_med_button.dart';

class ResultPage extends ConsumerWidget {
  final Session session;

  const ResultPage({super.key, required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Center(
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "GAME RESULT",
                      style: TextStyle(fontFamily: "Anton", fontSize: 50),
                    ),
                    Divider(),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                spacing: 20,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "ACCURACY",
                                    style: TextStyle(
                                      fontFamily: "Anton",
                                      fontSize: 50,
                                    ),
                                  ),
                                  Stack(
                                    alignment: AlignmentGeometry.center,
                                    children: [
                                      CircularProgressIndicator(
                                        value:
                                            (session.correctAnswer /
                                            session.maxQuiz),
                                        color: const Color(0xFF5FFF5F),
                                        backgroundColor: const Color(
                                          0xFFFF5E49,
                                        ),
                                        strokeWidth: 30,
                                        constraints: BoxConstraints.tight(
                                          Size(200, 200),
                                        ),
                                      ),
                                      Text(
                                        "${((session.correctAnswer / session.maxQuiz) * 100).round().toString()}%",
                                        style: TextStyle(
                                          fontSize: 50,
                                          fontFamily: "Anton",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Flexible(
                                    child: Container(
                                      height: 75,
                                      decoration: BoxDecoration(
                                        color: session.operator.colour,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  session.operator.name
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    fontFamily: "Anton",
                                                    fontSize: 50,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      Icon(
                                        Icons.check,
                                        size: 100,
                                        color: Color(0xFF5FFF5F),
                                      ),
                                      Text(
                                        "${session.correctAnswer}",
                                        textScaler: TextScaler.linear(4),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      Icon(
                                        Icons.close_sharp,
                                        size: 100,
                                        color: Color(0xFFFF5E49),
                                      ),
                                      Text(
                                        "${session.incorrectAnswer}",
                                        textScaler: TextScaler.linear(4),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 15,
                children: [
                  MathMedButton(
                    text: "Return to lobby",
                    textSize: 16,
                    colourFollowsOperator: false,
                    buttonSize: Size(160, 40),
                    function: () {
                      ref
                          .read(appStateDataProvider.notifier)
                          .changeState(AppState.inLobby);
                      ref.read(sessionProvider.notifier).destroySession();
                    },
                  ),
                  MathMedButton(
                    text: "PLAY AGAIN",
                    textSize: 20,
                    fontWeight: const FontWeight(800),
                    buttonSize: Size(175, 50),
                    function: () {
                      ref.read(sessionProvider.notifier).restart();
                    },
                  ),
                  MathMedButton(
                    text: "Return to title",
                    textSize: 16,
                    colourFollowsOperator: false,
                    buttonSize: Size(160, 40),
                    function: () {
                      ref
                          .read(appStateDataProvider.notifier)
                          .changeState(AppState.inTitle);
                      ref.read(sessionProvider.notifier).destroySession();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
