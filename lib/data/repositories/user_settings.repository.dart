import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_class.dto.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_foreign_languages.dto.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_profile_groups.dto.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_teachers.dto.dart';
import 'package:nissenger_mobile/data/data_providers/requests/student_requests.dart';
import 'package:nissenger_mobile/data/data_providers/requests/teacher_requests.dart';
import 'package:nissenger_mobile/data/models/class.model.dart';
import 'package:nissenger_mobile/data/models/foreign_language.model.dart';
import 'package:nissenger_mobile/data/models/profile_groups.model.dart';
import 'package:nissenger_mobile/data/models/school.model.dart';
import 'package:nissenger_mobile/data/models/teacher.model.dart';

class UserSettingsRepository {
  late Box box;
  late String city;
  late String school;

  UserSettingsRepository() {
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

  Future<List<ForeignLanguage>> getForeignLanguages() async {
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

  Future<List<ProfileGroups>> getProfileGroups({
    required List<String> subjects,
    required int gradeNumber,
    required String gradeLetter,
  }) async {
    List<ProfileGroups> parsedGroups = [];

    for (int i = 0; i < subjects.length; i++) {
      Response res = await StudentRequests.getProfileGroups(
        getProfileGroupsDto: GetProfileGroupsDto(
          school: School(
            city: city,
            name: school,
          ),
          className: Class(
            letter: gradeLetter,
            number: gradeNumber,
          ),
          subject: subjects[i],
        ),
      );

      parsedGroups.add(
        ProfileGroups.fromJson(
          subject: subjects[i],
          json: res.data,
        ),
      );
    }

    return parsedGroups;
  }

  Future<List<Teacher>> getTeachers() async {
    Response res = await TeacherRequests.getTeachers(
      getTeachersDto: GetTeachersDto(
        school: School(
          city: city,
          name: school,
        ),
      ),
    );

    return (res.data as List)
        .map((teacherJson) => Teacher.fromJson(
              json: teacherJson,
            ))
        .toList();
  }
}
