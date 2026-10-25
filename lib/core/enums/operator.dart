/// [Operator] is an arithmetic operation consist of addition (+), subtraction (-),
/// multiplication (×) and division (÷).
enum Operator {
  addition, subtraction, multiplication, division;

  String get symbol => switch (this) {
    Operator.addition => '+',
    Operator.subtraction => '-',
    Operator.multiplication => '×',
    Operator.division => '÷',
  };
}
