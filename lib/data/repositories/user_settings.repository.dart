import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_class.dto.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_foreign_languages.dto.dart';
import 'package:nissenger_mobile/data/data_providers/requests/student_requests.dart';
import 'package:nissenger_mobile/data/models/class.model.dart';
import 'package:nissenger_mobile/data/models/foreign_language.dart';
import 'package:nissenger_mobile/data/models/school.model.dart';

class UserRepository {
  late Box box;
  late String city;
  late String school;

  UserRepository() {
    box = Hive.box(UserSettingsBox.boxName);
    city = box.get(UserSettingsBox.city);
    school = box.get(UserSettingsBox.school);
  }

  Future checkGradeExisting({
    required int gradeNumber,
    required String gradeLetter,
  }) async {
    Response res = await StudentRequests.getClass(
      getClassDto: GetClassDto(
        gradeNumber: gradeNumber,
        school: School(
          city: city,
          name: school,
        ),
        className: Class(
          letter: gradeLetter,
          number: gradeNumber,
        ),
      ),
    );

    return res;
  }

  Future getForeignLanguages() async {
    Response res = await StudentRequests.getForeignLanguages(
      getForeignLanguagesDto: GetForeignLanguagesDto(
        school: School(
          city: city,
          name: school,
        ),
      ),
    );

    List<ForeignLanguage> parsedList = (res.data as List)
        .map(
          (foreignLanguageJson) => ForeignLanguage.fromJson(
            json: foreignLanguageJson,
          ),
        )
        .toList();

    return parsedList;
  }
}
