class FreeCabinet {
  final String name;

  const FreeCabinet({required this.name});

  factory FreeCabinet.fromJson({required Map<String, dynamic> json}) {
    return FreeCabinet(name: json["name"]);
  }
}
