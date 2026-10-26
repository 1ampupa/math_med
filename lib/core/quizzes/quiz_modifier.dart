class QuizModifier {

  /* 
  Master controls
  If false then it'll override its related operands controls
  */

  final bool masterAllowDuplicated;
  final bool masterAllowCommutative;          
  final bool masterAllowZero;

  // Operands controls
  final bool additionAllowDuplicated;         // a + a
  final bool additionAllowCommutative;        // a + b = b + a
  final bool additionAllowZero;               // a + 0 || 0 + a || 0 + 0

  final bool subtractionAllowDuplicated;      // a - a
  final bool subtractionAllowZero;            // a - 0
  final bool subtractionAllowNegative;        // a - b | a < b

  final bool multiplicationAllowDuplicated;   // a * a
  final bool multiplicationAllowCommutative;  // ab = ba
  final bool multiplicationAllowZero;         // a * 0 || 0 * a || 0 * 0
  final bool multiplicationAllowOne;          // a * 1 || 1 * a || 1 * 1

  final bool divisionAllowDuplicated;         // a / a
  final bool divisionAllowZero;               // 0 / a
  final bool divisionAllowOne;                // a / 1 || 1 / 1

  // Visual controls
  final bool shuffleChoices;

  /// [QuizModifier] allows Quiz to be generated within certain settings.
  /// 
  /// The master controls when setted to false, it can override its related operands settings to false as well.
  /// 
  /// Omitting argument would use its default value.
  QuizModifier({
    // Defaults
    this.masterAllowDuplicated = true,
    this.masterAllowCommutative = false,
    this.masterAllowZero = true,

    this.additionAllowDuplicated = true,
    this.additionAllowCommutative = true,
    this.additionAllowZero = false,   

    this.subtractionAllowDuplicated = false,
    this.subtractionAllowZero = false,         
    this.subtractionAllowNegative = false,  

    this.multiplicationAllowDuplicated = true,
    this.multiplicationAllowCommutative = true,
    this.multiplicationAllowZero = false,      
    this.multiplicationAllowOne = false,   

    this.divisionAllowDuplicated = false, 
    this.divisionAllowZero = false,            
    this.divisionAllowOne = false,       

    this.shuffleChoices = true,
  });
}