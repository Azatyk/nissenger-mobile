import 'package:nissenger_mobile/data/models/class.model.dart';
import 'package:nissenger_mobile/data/models/school.model.dart';

class GetClassDto {
  final int gradeNumber;
  final School school;
  final Class className;

  const GetClassDto({
    required this.gradeNumber,
    required this.school,
    required this.className,
  });

  Map<String, dynamic> toJson() {
    return {
      "grade_number": gradeNumber,
      "school": school.toJson(),
      "className": className.toJson(),
    };
  }
}
