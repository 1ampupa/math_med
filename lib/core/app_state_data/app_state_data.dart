import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/enums/operator.dart';

class AppStateData {
  final AppState appState;
  final String errorMessage;
  final Operator selectedOperator;
  final int maxQuiz;
  final int maxChoice;

  const AppStateData({
    this.appState = AppState.inTitle,
    this.errorMessage = "",
    this.selectedOperator = Operator.addition,
    this.maxQuiz = 10,
    this.maxChoice = 3,
  });

  AppStateData copyWith({
    AppState? appState,
    String? errorMessage,
    Operator? selectedOperator,
    int? maxQuiz,
    int? maxChoice,
    int? animatedTitleCounter,
  }) {
    return AppStateData(
      appState: appState ?? this.appState,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedOperator: selectedOperator ?? this.selectedOperator,
      maxQuiz: maxQuiz ?? this.maxQuiz,
      maxChoice: maxChoice ?? this.maxChoice,
    );
  }
}