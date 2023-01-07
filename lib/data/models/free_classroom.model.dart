class FreeClassroom {
  final String name;

  const FreeClassroom({required this.name});

  factory FreeClassroom.fromJson({required Map<String, dynamic> json}) {
    return FreeClassroom(name: json["name"]);
  }
}
