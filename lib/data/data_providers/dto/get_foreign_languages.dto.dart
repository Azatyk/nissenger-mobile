import 'package:nissenger_mobile/data/models/school.model.dart';

class GetForeignLanguagesDto {
  final School school;

  const GetForeignLanguagesDto({required this.school});

  Map<String, dynamic> toJson() {
    return {
      "school": school,
    };
  }
}
