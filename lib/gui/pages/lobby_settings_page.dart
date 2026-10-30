import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/providers/app_state_data_provider.dart';

import 'package:math_med/gui/widgets/math_med_button.dart';

class SessionSettingsPage extends ConsumerWidget {
  const SessionSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Center(
          child: Column(
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
                        .changeState(AppState.inLobby),
                  ),
                  Text(
                    "LOBBY SETTINGS",
                    style: TextStyle(fontFamily: "Anton", fontSize: 50),
                  ),
                ],
              ),
              Divider(),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Operands Control
                      Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                "${ref.watch(appStateDataProvider).currentSessionSettings.selectedOperator.name.toString().toUpperCase()} QUIZ",
                                style: TextStyle(
                                  fontFamily: "Anton",
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                          Divider(indent: 50, endIndent: 50),
                          modifier(ref),
                        ],
                      ),
                      // Visual Control
                      Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                "VISUAL",
                                style: TextStyle(
                                  fontFamily: "Anton",
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                          Divider(indent: 50, endIndent: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SwitchListTile(
                                  title: Text("Shuffle Answers"),
                                  value: ref
                                      .watch(appStateDataProvider)
                                      .currentSessionSettings
                                      .shuffleChoices,
                                  onChanged: (value) {
                                    final settings = ref
                                        .watch(appStateDataProvider)
                                        .currentSessionSettings;
                                    ref
                                        .read(appStateDataProvider.notifier)
                                        .updateSessionSettings(
                                          settings.copyWith(
                                            shuffleChoices: value,
                                          ),
                                        );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      MathMedButton(
                        text: "Reset to default",
                        buttonSize: Size(200, 30),
                        colourFollowsOperator: false,
                        backgroundColor: Color(0xFFAF2222),
                        function: () => ref
                            .read(appStateDataProvider.notifier)
                            .changeState(AppState.inLobbyCustomisation),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column modifier(WidgetRef ref) {
    final settings = ref.watch(appStateDataProvider).currentSessionSettings;

    return Column(
      spacing: 5,
      children: [
        for (final entry
            in settings
                .operatorQuizControls[settings.selectedOperator]!
                .entries)
          SwitchListTile(
            title: Text(entry.key.label.toString()),
            value: entry.value,
            onChanged: (value) {
              final updatedOperatorControls = {
                ...settings.operatorQuizControls,
                settings.selectedOperator: {
                  ...settings.operatorQuizControls[settings.selectedOperator]!,
                  entry.key: value,
                },
              };

              final updatedSettings = settings.copyWith(
                operatorQuizControls: updatedOperatorControls,
              );

              ref
                  .read(appStateDataProvider.notifier)
                  .updateSessionSettings(updatedSettings);
            },
          ),
      ],
    );
  }
}
