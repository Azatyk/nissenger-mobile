class Class {
  final String letter;
  final int number;

  const Class({
    required this.letter,
    required this.number,
  });

  Map<String, dynamic> toJson() {
    return {
      "letter": letter,
      "number": number,
    };
  }
}
