import 'package:nissenger_mobile/data/models/profile_groups.dart';

class MockProfileGroups {
  static List<ProfileGroups> getProfileGroups() {
    return [
      const ProfileGroups(
        profileLesson: "Физика",
        groups: ["Ф1", "Ф2", "Ф3", "Ф4", "Ф5", "Ф6", "Ф7", "Ф8", "Ф9", "Ф10"],
      ),
      const ProfileGroups(
        profileLesson: "Информатика",
        groups: ["И1", "И2", "И3", "И4", "И5", "И6", "И7", "И8", "И9", "И10"],
      ),
      const ProfileGroups(
        profileLesson: "Экономика",
        groups: ["Э1", "Э2", "Э3"],
      ),
    ];
  }
}
