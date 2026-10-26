import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/providers/app_state_data_provider.dart';

import 'package:math_med/gui/widgets/math_med_button.dart';

class TitlePage extends ConsumerWidget{
  
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
              Text("Welcome to\nMathMed", textAlign: TextAlign.center,),
              MathMedButton(
                text: "PLAY",
                primaryButton: true,
                textFontFamily: "Anton",
                textSize: 30,
                colourFollowsOperator: false,
                function: () => ref.read(appStateDataProvider.notifier).changeState(AppState.inLobby)
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("(very temporary trust me)\n"),
                  Text(
                    "Server = 192.168.1.0 wait ts doesnt even need internet lmao",
                  ),
                  Text("MathMed Alpha Beta Pre Pre Demo V10^-9"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
