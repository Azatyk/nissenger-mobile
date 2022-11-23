class School {
  final String city;
  final String name;

  const School({
    required this.city,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      "city": city,
      "name": name,
    };
  }
}
