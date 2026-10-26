import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/providers/app_state_data_provider.dart';
import 'package:math_med/core/providers/session_provider.dart';

import 'package:math_med/gui/widgets/math_med_button.dart';

class ErrorPage extends ConsumerWidget {

  final String? errorText;

  const ErrorPage({
    super.key,
    this.errorText
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: EdgeInsetsGeometry.all(90),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Uh oh!",
                  style: TextStyle(fontFamily: "Anton", fontSize: 50),
                ),
                Text(
                  "It seems like we've encountered a problem.\nPlease restart!",
                ),
                Text(
                  "What's wrong: ${errorText ?? "unexpected"}"
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 50,
                  children: [
                    MathMedButton(
                      text: "Restart",
                      textSize: 14,
                      buttonSize: Size(150, 30),
                      function: () =>
                          ref.read(sessionProvider.notifier).restart(),
                    ),
                    MathMedButton(
                      text: "Return to lobby",
                      textSize: 14,
                      buttonSize: Size(150, 30),
                      colourFollowsOperator: false,
                      function: () {
                        ref.read(appStateDataProvider.notifier).changeState(AppState.inLobby);
                      }
                    ),
                    MathMedButton(
                      text: "Return to title",
                      textSize: 14,
                      buttonSize: Size(150, 30),
                      colourFollowsOperator: false,
                      function: () {
                        ref.read(appStateDataProvider.notifier).changeState(AppState.inTitle);
                      }
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
