class MathUtils {
  // Checks if a given text is an operator, optionally including '='
  static bool isOperator(String buttonText, {bool hasEquals = false}) {
    final operators = ['+', '-', '÷', '⨯', '.', if (hasEquals) ...['=']];

    // Returns true if the text is an operator, false otherwise
    return operators.contains(buttonText);
  }

  // Checks if the last character of an equation is an operator
  static bool isOperatorAtEnd(String equation) {
    // Returns true if the last character is an operator, false otherwise
    if (equation.isNotEmpty) {
      return isOperator(equation.substring(equation.length - 1));
    } else {
      // If the equation is empty, there is no operator at the end, so the result is false
      return false;
    }
  }
}
