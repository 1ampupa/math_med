class QuizModifier {

  /* 
  Master controls
  If false then it'll override its related operands controls
  */

  final bool masterAllowDuplicated;
  final bool masterAllowZero;

  // Operands controls
  final bool additionAllowDuplicated;         // a + a
  final bool additionAllowZero;               // a + 0 || 0 + a || 0 + 0

  final bool subtractionAllowDuplicated;      // a - a
  final bool subtractionAllowZero;            // a - 0
  final bool subtractionAllowNegative;        // a - b | a < b

  final bool multiplicationAllowDuplicated;   // a * a
  final bool multiplicationAllowZero;         // a * 0 || 0 * a || 0 * 0
  final bool multiplicationAllowOne;          // a * 1 || 1 * a || 1 * 1

  final bool divisionAllowDuplicated;         // a / a
  final bool divisionAllowZero;               // 0 / a
  final bool divisionAllowOne;                // a / 1 || 1 / 1

  QuizModifier({
    // Defaults
    this.masterAllowDuplicated = true,
    this.masterAllowZero = true,

    this.additionAllowDuplicated = true,
    this.additionAllowZero = false,   

    this.subtractionAllowDuplicated = false,
    this.subtractionAllowZero = false,         
    this.subtractionAllowNegative = false,  

    this.multiplicationAllowDuplicated = true,
    this.multiplicationAllowZero = false,      
    this.multiplicationAllowOne = false,   

    this.divisionAllowDuplicated = false, 
    this.divisionAllowZero = false,            
    this.divisionAllowOne = false,       
  });
}