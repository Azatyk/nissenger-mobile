import 'package:nissenger_mobile/data/models/class.model.dart';
import 'package:nissenger_mobile/data/models/school.model.dart';

class GetProfileGroupsDto {
  final School school;
  final Class className;
  final String subject;

  const GetProfileGroupsDto({
    required this.school,
    required this.className,
    required this.subject,
  });

  Map<String, dynamic> toJson() {
    return {
      "school": school.toJson(),
      "class": className.toJson(),
      "subject": subject,
    };
  }
}
