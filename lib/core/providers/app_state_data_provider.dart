import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:math_med/core/app_state_data/app_state_data.dart';
import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/enums/operator.dart';

class AppStateDataProvider extends Notifier<AppStateData> {

  @override
  AppStateData build() => AppStateData();

  void changeState(AppState appState) {
    state = state.copyWith(appState: appState);
  }

  void setErrorMessage(String message) {
    state = state.copyWith(errorMessage: message);
  }

  void setOperator(Operator operator) {
    state = state.copyWith(selectedOperator: operator);
  }

  void setMaxQuiz(int maxQuiz) {
    state = state.copyWith(maxQuiz: maxQuiz);
  }

  void setMaxChoice(int maxChoice) {
    state = state.copyWith(maxChoice: maxChoice);
  }

}

final appStateDataProvider = NotifierProvider<AppStateDataProvider, AppStateData>(
  AppStateDataProvider.new,
);
