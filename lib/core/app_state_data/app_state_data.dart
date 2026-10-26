import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/enums/operator.dart';

class AppStateData {
  final AppState appState;
  final String errorMessage;
  final Operator selectedOperator;

  const AppStateData({
    this.appState = AppState.inTitle,
    this.errorMessage = "",
    this.selectedOperator = Operator.addition,
  });

  AppStateData copyWith({
    AppState? appState,
    String? errorMessage,
    Operator? selectedOperator
  }) {
    return AppStateData(
      appState: appState ?? this.appState,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedOperator: selectedOperator ?? this.selectedOperator,
    );
  }
}