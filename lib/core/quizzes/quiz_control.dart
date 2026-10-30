enum QuizControl {
  allowDuplicated("Allow duplicated operands"),
  allowCommutative("Treat reversed operands as the same question"),
  allowZero("Allow zero"),
  allowOne("Allow one"),
  allowNegativeAnswer("Allow negative answer");

  final String label;

  const QuizControl(this.label);
}
