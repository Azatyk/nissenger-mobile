import 'package:dio/dio.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_class_dto.dart';
import 'package:nissenger_mobile/utils/dio.util.dart';

class StudentRequests {
  static Future getClass({required GetClassDto getClassDto}) async {
    Response res = await DioUtil.getInstance().post(
      "/timetable/get-class",
      data: getClassDto.toJson(),
    );

    return res;
  }
}
