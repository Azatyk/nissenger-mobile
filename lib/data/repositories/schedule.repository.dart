import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_student_timetable.dto.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_teacher_timetable.dto.dart';
import 'package:nissenger_mobile/data/data_providers/requests/timetable_requests.dart';
import 'package:nissenger_mobile/data/models/class.model.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';
import 'package:nissenger_mobile/data/models/school.model.dart';

class ScheduleRepository {
  late Box box;
  late String city;
  late String school;

  ScheduleRepository() {
    box = Hive.box(UserSettingsBox.boxName);
    city = box.get(UserSettingsBox.city);
    school = box.get(UserSettingsBox.school);
  }

  Future<Schedule> getStudentSchedule({
    required int gradeNumber,
    required String gradeLetter,
    required int gradeGroup,
    required List<String> profileGroups,
  }) async {
    Response res = await TimetableRequests.getStudentTimetable(
      getTimetableDto: GetStudentTimetableDto(
        school: School(
          city: city,
          name: school,
        ),
        className: Class(
          letter: gradeLetter,
          number: gradeNumber,
        ),
        group: gradeGroup,
        profileGroups: profileGroups,
      ),
    );

    return Schedule.fromJson(json: res.data, teacherSchedule: false);
  }

  Future<Schedule> getTeacherSchedule({required String teacher}) async {
    Response res = await TimetableRequests.getTeacherTimetable(
      getTeacherTimetableDto: GetTeacherTimetableDto(
        school: School(
          city: city,
          name: school,
        ),
        teacher: teacher,
      ),
    );

    return Schedule.fromJson(json: res.data, teacherSchedule: true);
  }
}
