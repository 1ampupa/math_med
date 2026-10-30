import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/quizzes/quiz.dart';
import 'package:math_med/core/sessions/session_settings.dart';

void main() {

  const maxChoiceAmount = 3;

  group("Quiz Class Test", () {

    test("calculateAnswer must show the answer correctly.", () {
      expect(Quiz(operandA: 6, operandB: 7, operator: Operator.addition, sessionSettings: SessionSettings(), maxChoiceAmount: maxChoiceAmount).answer, equals(13));
      expect(Quiz(operandA: 16, operandB: 6, operator: Operator.subtraction, sessionSettings: SessionSettings(), maxChoiceAmount: maxChoiceAmount).answer, equals(10));
      expect(Quiz(operandA: 2, operandB: 4, operator: Operator.multiplication, sessionSettings: SessionSettings(), maxChoiceAmount: maxChoiceAmount).answer, equals(8));
      expect(Quiz(operandA: 24, operandB: 2, operator: Operator.division, sessionSettings: SessionSettings(), maxChoiceAmount: maxChoiceAmount).answer, equals(12));

      expect(Quiz(operandA: 9, operandB: 2, operator: Operator.division, sessionSettings: SessionSettings(), maxChoiceAmount: maxChoiceAmount).answer, equals(4));
    });

    test("generateChoices creates choices with length of maxChoiceAmount.", () {
      final List<int> choices = Quiz.generateChoices(10, maxChoiceAmount, Operator.addition, SessionSettings(), null);

      expect(choices.length, equals(maxChoiceAmount));
    });

    test("generateChoices must have the real answer.", () {
      int answer = 20;
      final List<int> choices = Quiz.generateChoices(answer, maxChoiceAmount, Operator.addition, SessionSettings(), null);

      expect(choices.contains(answer), isTrue); 
    });

    test("generateChoices of two questions with same seed must provide the same same answers set.", () {
      final Random random1 = Random(42);
      final Random random2 = Random(42);

      final int answer = 10;

      final choices1 = Quiz.generateChoices(answer, maxChoiceAmount, Operator.addition, SessionSettings(), random1);
      final choices2 = Quiz.generateChoices(answer, maxChoiceAmount, Operator.addition, SessionSettings(), random2);

      expect(choices1, unorderedEquals(choices2));

    });

    test("Every choice must be a positive integer", () {
      for (int i = 0; i < 10000; i++) {
        final choices = Quiz.generateChoices(1, maxChoiceAmount, Operator.multiplication, SessionSettings(), Random(i));
        for (final choice in choices) {
          expect(choice, greaterThan(0));
        }
      }
    });

    test("Choices must not contain duplicate values", () {
      final choices = Quiz.generateChoices(10, maxChoiceAmount, Operator.multiplication, SessionSettings(), Random(42));
      final uniqueChoices = choices.toSet();

      expect(choices.length, equals(uniqueChoices.length));
    });

    test("generateChoices handles boundary answers (1 and 0) without infinite loop", () {
      final choicesForOne = Quiz.generateChoices(1, maxChoiceAmount, Operator.multiplication, SessionSettings(), Random(42));
      final choicesForZero = Quiz.generateChoices(0, maxChoiceAmount, Operator.addition, SessionSettings(), Random(42));

      expect(choicesForOne.length, equals(maxChoiceAmount));
      expect(choicesForZero.length, equals(maxChoiceAmount));
    });

  });
}
