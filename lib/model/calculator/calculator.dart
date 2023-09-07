class Calculation {
  final bool shouldAppend;
  final String equation;
  final String result;

  const Calculation({
    this.shouldAppend = true,
    this.equation = '0',
    this.result = '0',
  });

  Calculation copy({
    bool? shouldAppend,
    String? equation,
    String? result,
  }) =>
      Calculation(
        shouldAppend: shouldAppend ?? this.shouldAppend,
        equation: equation ?? this.equation,
        result: result ?? this.result,
      );
}
