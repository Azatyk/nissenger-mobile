import 'package:dio/dio.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_student_timetable.dto.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_teacher_timetable.dto.dart';
import 'package:nissenger_mobile/utils/dio.util.dart';

class TimetableRequests {
  static Future getStudentTimetable(
      {required GetStudentTimetableDto getTimetableDto}) async {
    Response res = await DioUtil.getInstance().post(
      "/timetable/lessons/",
      data: getTimetableDto.toJson(),
    );

    return res;
  }

  static Future getTeacherTimetable(
      {required GetTeacherTimetableDto getTeacherTimetableDto}) async {
    Response res = await DioUtil.getInstance().post(
      "/timetable/lessons/teachers/",
      data: getTeacherTimetableDto.toJson(),
    );

    return res;
  }
}
