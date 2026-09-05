import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/quiz/quiz.dart';

void main() {
  group("Quiz Class Test", () {

    test("calculateAnswer must show the answer correctly.", () {
      expect(Quiz(operandA: 6, operandB: 7, operator: Operator.addition).answer, equals(13));
      expect(Quiz(operandA: 16, operandB: 6, operator: Operator.subtraction).answer, equals(10));
      expect(Quiz(operandA: 2, operandB: 4, operator: Operator.multiplication).answer, equals(8));
      expect(Quiz(operandA: 24, operandB: 2, operator: Operator.division).answer, equals(12));

      expect(Quiz(operandA: 9, operandB: 2, operator: Operator.division).answer, equals(4));
    });

    test("generateChoices creates choices with length of maxChoiceAmount.", () {
      final List<int> choices = Quiz.generateChoices(10, Operator.addition, null);

      expect(choices.length, equals(Quiz.maxChoiceAmount));
    });


    test("generateChoices must have the real answer.", () {
      int answer = 20;
      final List<int> choices = Quiz.generateChoices(answer, Operator.addition, null);

      expect(choices.contains(answer), isTrue); 
    });

    test("generateChoices of two questions with same seed and same answer must be the same.", () {
      final Random random1 = Random(42);
      final Random random2 = Random(42);

      final int answer = 10;

      final choices1 = Quiz.generateChoices(answer, Operator.addition, random1);
      final choices2 = Quiz.generateChoices(answer, Operator.addition, random2);

      expect(choices1, equals(choices2));

    });

    test("Every choice must be a positive integer", () {
      for (int i = 0; i < 10000; i++) {
        final choices = Quiz.generateChoices(1, Operator.multiplication, Random(i));
        for (final choice in choices) {
          expect(choice, greaterThan(0));
        }
      }
    });

    test("Choices must not contain duplicate values", () {
      final choices = Quiz.generateChoices(10, Operator.multiplication, Random(42));
      final uniqueChoices = choices.toSet();

      expect(choices.length, equals(uniqueChoices.length));
    });

    test("Choices should be sorted in ascending order", () {
      final choices = Quiz.generateChoices(15, Operator.division, Random(42));
      final sortedChoices = List<int>.from(choices)..sort();

      expect(choices, equals(sortedChoices));
    });

    test("generateChoices handles boundary answers (1 and 0) without infinite loop", () {
      final choicesForOne = Quiz.generateChoices(1, Operator.multiplication, Random(42));
      final choicesForZero = Quiz.generateChoices(0, Operator.addition, Random(42));

      expect(choicesForOne.length, equals(Quiz.maxChoiceAmount));
      expect(choicesForZero.length, equals(Quiz.maxChoiceAmount));
    });

  });
}
