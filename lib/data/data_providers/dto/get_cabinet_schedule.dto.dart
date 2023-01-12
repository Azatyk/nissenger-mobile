import 'package:nissenger_mobile/data/models/school.model.dart';

class GetCabinetScheduleDto {
  final School school;
  final String classroom;

  const GetCabinetScheduleDto({
    required this.school,
    required this.classroom,
  });

  Map<String, dynamic> toJson() {
    return {
      "school": school,
      "classroom": classroom,
    };
  }
}
