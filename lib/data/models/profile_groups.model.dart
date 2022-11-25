class ProfileGroups {
  final String profileLesson;
  final List<String> groups;

  const ProfileGroups({
    required this.profileLesson,
    required this.groups,
  });

  factory ProfileGroups.fromJson({
    required String subject,
    required List json,
  }) {
    return ProfileGroups(
      profileLesson: subject,
      groups: json
          .map(
            (profileGroup) => profileGroup["name"].toString(),
          )
          .toList(),
    );
  }
}
