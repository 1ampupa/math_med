import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/providers/app_state_data_provider.dart';
import 'package:math_med/core/providers/session_provider.dart';
import 'package:math_med/core/quizzes/quiz_modifier.dart';

import 'package:math_med/gui/widgets/math_med_button.dart';

class LobbyPage extends ConsumerWidget {
  const LobbyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Operator selectedOperator =  ref.watch(appStateDataProvider).selectedOperator;

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                MathMedButton(
                  text: "<",
                  colourFollowsOperator: false,
                  buttonSize: Size(40, 40),
                  function: () => ref.read(appStateDataProvider.notifier).changeState(AppState.inTitle)
                ),
                Text(
                  "LOBBY",
                  style: TextStyle(fontFamily: "Anton", fontSize: 50),
                ),
              ],
            ),
            Expanded(
              child: Column(
                spacing: 5,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      Flexible(
                        child: Container(
                          height: 80,
                          color: selectedOperator.colour,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              spacing: 50,
                              children: [
                                const Text(
                                  "OPERATOR",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight(800)
                                  ),
                                ),
                                Text(
                                  selectedOperator.name.toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: "Anton",
                                    fontSize: 60
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      MathMedButton(
                        text: "Change",
                        function: () {
                          switch (selectedOperator) {                           
                            case Operator.addition:
                              ref.read(appStateDataProvider.notifier).changeOperator(Operator.subtraction);
                              break;
                            case Operator.subtraction:
                              ref.read(appStateDataProvider.notifier).changeOperator(Operator.multiplication);
                              break;
                            case Operator.multiplication:
                              ref.read(appStateDataProvider.notifier).changeOperator(Operator.division);
                              break;
                            case Operator.division:
                              ref.read(appStateDataProvider.notifier).changeOperator(Operator.addition);
                              break;
                          }
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      spacing: 5,
                      children: [
                        Expanded(
                          child: Container(
                            color: selectedOperator.colour.withAlpha(150),
                            child: Center(
                              child: Text(
                                "Quiz Modifier Customisation\nComing soon",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: selectedOperator.colour.withAlpha(150),
                            child: Center(
                              child: Text(
                                "User\nComing soon",
                                textAlign: TextAlign.center,
                              ),
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
              children: [
                MathMedButton(             
                  text: "START",
                  textFontFamily: "Anton",
                  textSize: 30,
                  function: () {
                    ref.read(sessionProvider.notifier).start(selectedOperator, QuizModifier(), 10, 3);
                    ref.read(appStateDataProvider.notifier).changeState(AppState.inGame);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
