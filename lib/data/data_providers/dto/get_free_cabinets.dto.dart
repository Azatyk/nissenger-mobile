import 'package:nissenger_mobile/data/models/school.model.dart';

class GetFreeCabinetsDto {
  final School school;

  const GetFreeCabinetsDto({required this.school});

  Map<String, dynamic> toJson() {
    return {
      "school": school,
    };
  }
}
