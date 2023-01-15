class Version {
  final int major;
  final int minor;
  final int patch;

  const Version({
    required this.major,
    required this.minor,
    required this.patch,
  });

  factory Version.fromJson({required Map<String, dynamic> json}) {
    return Version(
      major: json["major"],
      minor: json["minor"],
      patch: json["patch"],
    );
  }
}
