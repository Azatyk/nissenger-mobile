import 'package:dio/dio.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_timetable.dto.dart';
import 'package:nissenger_mobile/utils/dio.util.dart';

class TimetableRequests {
  static Future getTimetable({required GetTimetableDto getTimetableDto}) async {
    Response res = await DioUtil.getInstance().post(
      "/timetable/lessons/",
      data: getTimetableDto.toJson(),
    );

    return res;
  }
}
