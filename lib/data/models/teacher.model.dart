class Teacher {
  final String name;

  const Teacher({required this.name});

  factory Teacher.fromJson({required Map<String, dynamic> json}) {
    return Teacher(
      name: json["name"],
    );
  }
}
