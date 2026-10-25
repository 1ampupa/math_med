import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/providers/app_state_provider.dart';
import 'package:math_med/core/providers/session_provider.dart';
import 'package:math_med/core/sessions/session.dart';

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "GAME RESULT",
                    style: TextStyle(fontFamily: "Anton", fontSize: 50),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 50,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Icon(
                            Icons.check,
                            size: 100,
                            color: Color(0xFF00FF00),
                          ),
                          Text(
                            "${session.correctAnswer}",
                            textScaler: TextScaler.linear(4),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Icon(
                            Icons.close_sharp,
                            size: 100,
                            color: Color(0xFFFF0000),
                          ),
                          Text(
                            "${session.incorrectAnswer}",
                            textScaler: TextScaler.linear(4),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 15,
                children: [                 
                  ElevatedButton(
                    onPressed: () {
                      ref.read(appStateProvider.notifier).changeState(AppState.inLobby);
                      ref.read(sessionProvider.notifier).destroySession();
                    },
                    child: Text("Return to lobby"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(sessionProvider.notifier).restart();
                    },
                    child: Text("Play again"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(appStateProvider.notifier).changeState(AppState.inTitle);
                      ref.read(sessionProvider.notifier).destroySession();
                    },
                    child: Text("Return to title"),
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
