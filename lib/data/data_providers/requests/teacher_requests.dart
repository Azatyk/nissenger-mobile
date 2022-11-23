import 'package:dio/dio.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_teachers.dto.dart';
import 'package:nissenger_mobile/utils/dio.util.dart';

class TeacherRequests {
  static Future getTeachers({required GetTeachersDto getTeachersDto}) async {
    Response res = await DioUtil.getInstance().post(
      "/timetable/teachers",
      data: getTeachersDto.toJson(),
    );

    return res;
  }
}
