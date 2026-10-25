import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:window_manager/window_manager.dart';

import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/providers/app_state_provider.dart';

import 'package:math_med/gui/pages/title_page.dart';
import 'package:math_med/gui/pages/lobby_page.dart';
import 'package:math_med/gui/pages/game_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    title: "MathMed",
    size: Size(800, 600),
    minimumSize: Size(800, 600),
    center: true,
    skipTaskbar: false,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const ProviderScope(child: MathMedApp()));
}

class MathMedApp extends ConsumerWidget {
  const MathMedApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppState appState = ref.watch(appStateProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MathMed",

      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E), 
        fontFamily: 'IBM Plex Sans Thai',

        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF151515),
          primary: Color(0xFF7555FF),
          primaryContainer: Color(0xFF7555FF),
          onPrimary: Color(0xFFDBE7FF),
          secondary: Color(0xFFDBE7FF),
          secondaryContainer: Color(0xFFDBE7FF),
          onSecondary: Color(0xFF151515),
          tertiary: Color(0xFF202020),
          tertiaryContainer: Color(0xFF202020),
          onTertiary: Color(0xFFDBE7FF),
          onTertiaryContainer: Color(0xFFDBE7FF),
        ),

        tooltipTheme: const TooltipThemeData(
          preferBelow: false,
          waitDuration: Duration(milliseconds: 500),
        )
      ),

      home: switch (appState) {
        AppState.inTitle => TitlePage(), // we dont have it yet :sob:
        AppState.inLobby => LobbyPage(), // same
        AppState.inGame => GamePage(),
      }
    );
  }
}
