import 'package:math_med/core/enums/app_state.dart';
import 'package:math_med/core/sessions/session_settings.dart';

class AppStateData {
  final AppState appState;
  final String errorMessage;
  final SessionSettings currentSessionSettings;


  AppStateData({
    this.appState = AppState.inTitle,
    this.errorMessage = "",
    SessionSettings? currentSessionSettings,
  }) : currentSessionSettings = currentSessionSettings ?? SessionSettings();

  AppStateData copyWith({
    AppState? appState,
    String? errorMessage,
    SessionSettings? currentSessionSettings,
  }) {
    return AppStateData(
      appState: appState ?? this.appState,
      errorMessage: errorMessage ?? this.errorMessage,
      currentSessionSettings: currentSessionSettings ?? this.currentSessionSettings,
    );
  }
}