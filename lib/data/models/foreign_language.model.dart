class ForeignLanguage {
  final String name;

  const ForeignLanguage({required this.name});

  factory ForeignLanguage.fromJson({required Map<String, dynamic> json}) {
    return ForeignLanguage(
      name: json["name"],
    );
  }
}
