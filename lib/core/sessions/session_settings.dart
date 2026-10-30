import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/quizzes/quiz_control.dart';

class SessionSettings {
  final Operator selectedOperator;
  final int maxQuiz;
  final int maxChoice;

  /* 
  Master controls
  If false then it'll override its related operands controls
  */

  static const defaultMasterQuizControls = {
    QuizControl.allowCommutative: true,
    QuizControl.allowDuplicated: true,
    QuizControl.allowZero: true,
  };

  static const defaultOperatorQuizControls = {
    Operator.addition: {
      QuizControl.allowDuplicated: true,
      QuizControl.allowCommutative: true,
      QuizControl.allowZero: false,
    },
    Operator.subtraction: {
      QuizControl.allowDuplicated: false,
      QuizControl.allowZero: false,
      QuizControl.allowNegativeAnswer: false,
    },
    Operator.multiplication: {
      QuizControl.allowDuplicated: true,
      QuizControl.allowCommutative: true,
      QuizControl.allowZero: false,
      QuizControl.allowOne: false,
    },
    Operator.division: {
      QuizControl.allowDuplicated: false,
      QuizControl.allowZero: false,
      QuizControl.allowOne: false,
    },
  };

  final Map<QuizControl, bool> masterQuizControls;
  final Map<Operator, Map<QuizControl, bool>> operatorQuizControls;

  // Visual controls
  final bool shuffleChoices;

  SessionSettings({
    this.selectedOperator = Operator.addition,
    this.maxQuiz = 10,
    this.maxChoice = 3,
    this.shuffleChoices = true,

    Map<QuizControl, bool>? masterQuizControls,
    Map<Operator, Map<QuizControl, bool>>? operatorQuizControls,
  }) : masterQuizControls = Map<QuizControl, bool>.unmodifiable(
         masterQuizControls ?? defaultMasterQuizControls,
       ),
       operatorQuizControls =
           Map<Operator, Map<QuizControl, bool>>.unmodifiable(
             (operatorQuizControls ?? defaultOperatorQuizControls).map(
               (key, value) =>
                   MapEntry(key, Map<QuizControl, bool>.unmodifiable(value)),
             ),
           );

  SessionSettings copyWith({
    Operator? selectedOperator,
    int? maxQuiz,
    int? maxChoice,
    bool? shuffleChoices,
    Map<QuizControl, bool>? masterQuizControls,
    Map<Operator, Map<QuizControl, bool>>? operatorQuizControls,
  }) {
    return SessionSettings(
      selectedOperator: selectedOperator ?? this.selectedOperator,
      maxQuiz: maxQuiz ?? this.maxQuiz,
      maxChoice: maxChoice ?? this.maxChoice,
      shuffleChoices: shuffleChoices ?? this.shuffleChoices,
      masterQuizControls: masterQuizControls ?? this.masterQuizControls,
      operatorQuizControls: operatorQuizControls ?? this.operatorQuizControls,
    );
  }
}
