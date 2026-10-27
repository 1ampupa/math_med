import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/providers/app_state_data_provider.dart';
import 'package:math_med/core/providers/session_provider.dart';
import 'package:math_med/core/quizzes/quiz_modifier.dart';

import 'package:math_med/gui/widgets/math_med_button.dart';

class LobbyPage extends ConsumerStatefulWidget {
  const LobbyPage({super.key});

  @override
  ConsumerState<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends ConsumerState<LobbyPage> {
  late final TextEditingController maxQuizController;

  @override
  void initState() {
    super.initState();
    maxQuizController = TextEditingController(
      text: ref.watch(appStateDataProvider).maxQuiz.toString(),
    );
  }

  @override
  void dispose() {
    maxQuizController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Operator selectedOperator = ref
        .watch(appStateDataProvider)
        .selectedOperator;

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
                  function: () => ref
                      .read(appStateDataProvider.notifier)
                      .changeState(AppState.inTitle),
                ),
                Text(
                  "CUSTOM LOBBY",
                  style: TextStyle(fontFamily: "Anton", fontSize: 50),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: Column(
                spacing: 5,
                children: [
                  Row(
                    spacing: 5,
                    children: [
                      Flexible(
                        child: Container(
                          height: 85,
                          decoration: BoxDecoration(
                            color: selectedOperator.colour,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 50,
                              children: [
                                const Text(
                                  "OPERATOR",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight(800),
                                  ),
                                ),
                                Text(
                                  selectedOperator.name.toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: "Anton",
                                    fontSize: 60,
                                  ),
                                ),
                                MathMedButton(
                                  buttonSize: Size(120, 40),
                                  text: "Change",
                                  textSize: 18,
                                  function: () {
                                    switch (selectedOperator) {
                                      case Operator.addition:
                                        ref
                                            .read(appStateDataProvider.notifier)
                                            .setOperator(Operator.subtraction);
                                        break;
                                      case Operator.subtraction:
                                        ref
                                            .read(appStateDataProvider.notifier)
                                            .setOperator(
                                              Operator.multiplication,
                                            );
                                        break;
                                      case Operator.multiplication:
                                        ref
                                            .read(appStateDataProvider.notifier)
                                            .setOperator(Operator.division);
                                        break;
                                      case Operator.division:
                                        ref
                                            .read(appStateDataProvider.notifier)
                                            .setOperator(Operator.addition);
                                        break;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      spacing: 5,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedOperator.colour.withAlpha(150),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  spacing: 5,
                                  children: [
                                    Text(
                                      "Modifiers",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Text(
                                          "How many quiz do you want?",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            onChanged: (value) {
                                              ref
                                                  .read(
                                                    appStateDataProvider
                                                        .notifier,
                                                  )
                                                  .setMaxQuiz(
                                                    int.tryParse(value) ?? 10,
                                                  );
                                            },
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            controller: maxQuizController,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(100),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedOperator.colour.withAlpha(150),
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                    final int? maxQuiz = int.tryParse(maxQuizController.text);
                    if (maxQuiz == null || maxQuiz == 0) {
                      log(
                        "Please enter a valid max quiz.",
                        level: 0,
                        name: "Lobby",
                      );
                      return;
                    }
                    ref
                        .read(sessionProvider.notifier)
                        .start(selectedOperator, QuizModifier(), maxQuiz, 3);
                    ref
                        .read(appStateDataProvider.notifier)
                        .changeState(AppState.inGame);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
