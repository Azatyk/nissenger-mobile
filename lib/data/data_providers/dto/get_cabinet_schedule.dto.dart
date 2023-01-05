import 'package:nissenger_mobile/data/models/cabinet.model.dart';
import 'package:nissenger_mobile/data/models/school.model.dart';
import 'package:nissenger_mobile/data/plain_data/weekdays.data.dart';

class GetCabinetScheduleDto {
  final School school;
  final Weekday day;
  final Cabinet classroom;

  const GetCabinetScheduleDto(
      {required this.school, required this.day, required this.classroom});

  Map<String, dynamic> toJson() {
    return {
      "school": school,
      "day": day,
      "classroom": classroom,
    };
  }
}
