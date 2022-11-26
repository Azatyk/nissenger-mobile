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
      "grade": number,
    };
  }

  factory Class.fromJson({required Map<String, dynamic> json}) {
    return Class(
      letter: json["letter"],
      number: json["grade"],
    );
  }
}
