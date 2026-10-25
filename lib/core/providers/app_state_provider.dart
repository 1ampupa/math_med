import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/enums/app_state.dart';

class AppStateProvider extends Notifier<AppState> {

  String errorMessage = "";

  @override
  AppState build() => AppState.inTitle;

  void changeState(AppState appState) {
    state = appState;
  }

}

final appStateProvider = NotifierProvider<AppStateProvider, AppState>(
  AppStateProvider.new,
);
