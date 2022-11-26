import 'package:nissenger_mobile/data/models/school.model.dart';

class GetTeacherTimetableDto {
  final School school;
  final String teacher;

  const GetTeacherTimetableDto({
    required this.school,
    required this.teacher,
  });

  Map<String, dynamic> toJson() {
    return {
      "school": school.toJson(),
      "teacher": teacher,
    };
  }
}
