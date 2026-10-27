import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/providers/app_state_data_provider.dart';

import 'package:math_med/gui/widgets/math_med_button.dart';

class TitlePage extends ConsumerWidget {
  const TitlePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Welcome to"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "MATH",
                        style: TextStyle(
                          fontFamily: "Anton",
                          fontSize: 50,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        "MED",
                        style: TextStyle(
                          fontFamily: "Anton",
                          fontSize: 50,
                        ),
                      ),
                    ],
                  ),
                  Text("A dangerous way to improve your mental math."),
                ],
              ),
              Divider(indent: 200, endIndent: 200),
              Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MathMedButton(
                    text: "NEW GAME",
                    primaryButton: true,
                    textFontFamily: "Anton",
                    textSize: 30,
                    buttonSize: Size(175, 50),
                    colourFollowsOperator: false,
                    function: () => ref
                        .read(appStateDataProvider.notifier)
                        .changeState(AppState.inLobby),
                  ),
                  MathMedButton(                   
                    text: "CONTINUE",
                    textFontFamily: "Anton",
                    textSize: 30,
                    buttonSize: Size(175, 50),
                    colourFollowsOperator: false,
                    function: () => ref
                        .read(appStateDataProvider.notifier)
                        .changeState(AppState.inLobby),
                  ),
                  MathMedButton(
                    text: "SETTINGS",
                    textFontFamily: "Anton",
                    textSize: 30,
                    buttonSize: Size(175, 50),
                    colourFollowsOperator: false,
                    function: () => ref
                        .read(appStateDataProvider.notifier)
                        .changeState(AppState.inLobby),
                  ),
                  MathMedButton(
                    text: "CREDITS",
                    textFontFamily: "Anton",
                    textSize: 30,
                    buttonSize: Size(175, 50),
                    colourFollowsOperator: false,
                    function: () => ref
                        .read(appStateDataProvider.notifier)
                        .changeState(AppState.inLobby),
                  ),
                  Text("All of these button lead to lobby btw."),
                ],
              ),
              Divider(indent: 200, endIndent: 200),
              Text(
                "MathMed Demo 1\nMade with pain and sacrifice by 1ampupa",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
