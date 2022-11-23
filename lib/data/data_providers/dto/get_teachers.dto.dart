import 'package:nissenger_mobile/data/models/school.model.dart';

class GetTeachersDto {
  final School school;

  const GetTeachersDto({required this.school});

  Map<String, dynamic> toJson() {
    return {
      "school": school,
    };
  }
}
