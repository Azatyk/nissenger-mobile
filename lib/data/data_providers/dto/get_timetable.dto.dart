import 'package:nissenger_mobile/data/models/class.model.dart';
import 'package:nissenger_mobile/data/models/school.model.dart';

class GetTimetableDto {
  final School school;
  final Class className;
  final int group;
  final List<String>? profileGroups;
  final String? foreignLanguage;

  const GetTimetableDto({
    required this.school,
    required this.className,
    required this.group,
    this.profileGroups,
    this.foreignLanguage,
  });

  Map<String, dynamic> toJson() {
    var map = {
      "school": school.toJson(),
      "class": className.toJson(),
      "group": group,
    };

    if (profileGroups != null) {
      map["profile_groups"] = [
        profileGroups?.map((profileGroup) => profileGroup).toList(),
      ];
    }

    if (foreignLanguage != null) {
      map["foreign_language"] = foreignLanguage!;
    }

    return map;
  }
}
