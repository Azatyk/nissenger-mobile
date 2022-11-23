class Cabinet {
  final String name;

  const Cabinet({required this.name});

  factory Cabinet.fromJson({required Map<String, dynamic> json}) {
    return Cabinet(name: json["classroom"]);
  }
}
