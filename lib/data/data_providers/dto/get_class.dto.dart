import 'package:nissenger_mobile/data/models/class.model.dart';
import 'package:nissenger_mobile/data/models/school.model.dart';

class GetClassDto {
  final School school;
  final Class className;

  const GetClassDto({
    required this.school,
    required this.className,
  });

  Map<String, dynamic> toJson() {
    return {
      "school": school.toJson(),
      "class": className.toJson(),
    };
  }
}
