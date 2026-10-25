import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/providers/app_state_provider.dart';

class TitlePage extends ConsumerWidget{
  
  const TitlePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("MathMed"),
            ElevatedButton(
              onPressed: () {
                ref.read(appStateProvider.notifier).changeState(AppState.inLobby);
              },
              child: Text("New game")
            )
          ],
        ),
      ),
    );
  }
}
