import 'package:flutter_test/flutter_test.dart';
import 'package:math_med/core/enums/operator.dart';
import 'package:math_med/core/numbers/number_randomiser.dart';
import 'package:math_med/core/quizzes/quiz_modifier.dart';

void main() {
  const int sampleSize = 100;

  group("Group A: Default Addition", () {
    QuizModifier quizModifier = QuizModifier();

    test("A1: No zero in addition operands", () {
      const Operator operator = Operator.addition;
      final NumberRandomiser nr = NumberRandomiser(
        rangeMin: 1,
        rangeMax: 5,
        operator: operator,
        quizModifier: quizModifier,
      );
      for (int i = 0; i < sampleSize; i++) {
        (int, int) operands = nr.randomOperands();
        expect(operands.$1, isNot(0));
        expect(operands.$2, isNot(0));
      }
    });
  });

  group("Group B: Default Subtraction", () {
    QuizModifier quizModifier = QuizModifier();

    test("B1: No duplicated subtraction operands", () {
      const Operator operator = Operator.subtraction;
      final NumberRandomiser nr = NumberRandomiser(
        rangeMin: 1,
        rangeMax: 5,
        operator: operator,
        quizModifier: quizModifier,
      );
      for (int i = 0; i < sampleSize; i++) {
        (int, int) operands = nr.randomOperands();
        expect(operands.$1, isNot(operands.$2));
      }
    });

    test("B2: No zero in subtraction operands", () {
      const Operator operator = Operator.subtraction;
      final NumberRandomiser nr = NumberRandomiser(
        rangeMin: 1,
        rangeMax: 5,
        operator: operator,
        quizModifier: quizModifier,
      );
      for (int i = 0; i < sampleSize; i++) {
        (int, int) operands = nr.randomOperands();
        expect(operands.$1, isNot(0));
        expect(operands.$2, isNot(0));
      }
    });

    test("B3: No negatives in subtraction operands", () {
      const Operator operator = Operator.subtraction;
      final NumberRandomiser nr = NumberRandomiser(
        rangeMin: 1,
        rangeMax: 5,
        operator: operator,
        quizModifier: quizModifier,
      );
      for (int i = 0; i < sampleSize; i++) {
        (int, int) operands = nr.randomOperands();
        expect(operands.$1, isNonNegative);
        expect(operands.$2, isNonNegative);
      }
    });
  });

  group("Group C: Default Multiplication", () {
      QuizModifier quizModifier = QuizModifier();

      test("C1: No zero in multiplication operands", () {
        const Operator operator = Operator.multiplication;
        final NumberRandomiser nr = NumberRandomiser(
          rangeMin: 1,
          rangeMax: 5,
          operator: operator,
          quizModifier: quizModifier,
        );
        for (int i = 0; i < sampleSize; i++) {
          (int, int) operands = nr.randomOperands();
          expect(operands.$1, isNot(0));
          expect(operands.$2, isNot(0));
        }
      });

      test("C2: No one in multiplication operands", () {
        const Operator operator = Operator.multiplication;
        final NumberRandomiser nr = NumberRandomiser(
          rangeMin: 1,
          rangeMax: 5,
          operator: operator,
          quizModifier: quizModifier,
        );
        for (int i = 0; i < sampleSize; i++) {
          (int, int) operands = nr.randomOperands();
          expect(operands.$1, isNot(1));
          expect(operands.$2, isNot(1));
        }
      });
    });

    group("Group D: Default Division", () {
      QuizModifier quizModifier = QuizModifier();

      test("D1: No duplicated division operands", () {
        const Operator operator = Operator.division;
        final NumberRandomiser nr = NumberRandomiser(
          rangeMin: 1,
          rangeMax: 5,
          operator: operator,
          quizModifier: quizModifier,
        );
        for (int i = 0; i < sampleSize; i++) {
          (int, int) operands = nr.randomOperands();
          expect(operands.$1, isNot(operands.$2));
        }
      });

      test("D2: No zero in division operands", () {
        const Operator operator = Operator.division;
        final NumberRandomiser nr = NumberRandomiser(
          rangeMin: 1,
          rangeMax: 5,
          operator: operator,
          quizModifier: quizModifier,
        );
        for (int i = 0; i < sampleSize; i++) {
          (int, int) operands = nr.randomOperands();
          expect(operands.$1, isNot(0));
          expect(operands.$2, isNot(0));
        }
      });

      test("D3: No one in division operands", () {
        const Operator operator = Operator.division;
        final NumberRandomiser nr = NumberRandomiser(
          rangeMin: 1,
          rangeMax: 5,
          operator: operator,
          quizModifier: quizModifier,
        );
        for (int i = 0; i < sampleSize; i++) {
          (int, int) operands = nr.randomOperands();
          expect(operands.$1, isNot(1));
          expect(operands.$2, isNot(1));
        }
      });
    });
}
