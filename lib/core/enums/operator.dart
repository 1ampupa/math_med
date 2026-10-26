import 'package:flutter/material.dart';

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

  Color get colour => switch (this) {
    Operator.addition => Color(0xFF1DA84B),
    Operator.subtraction => Color(0xFF467EC7),
    Operator.multiplication => Color(0xFFC56154),
    Operator.division => Color(0xFF7F6DB3),
  };
}
