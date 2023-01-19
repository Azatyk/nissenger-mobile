import 'package:dio/dio.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_cabinet_schedule.dto.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_free_cabinets.dto.dart';
import 'package:nissenger_mobile/utils/dio.util.dart';

class FreeCabinetsRequests {
  static Future getFreeCabinets(
      {required GetFreeCabinetsDto getFreeCabinets}) async {
    Response res = await DioUtil.getInstance().post(
      "/timetable/classrooms/empty/",
      data: getFreeCabinets.toJson(),
    );

    return res;
  }

  static Future getCabinetSchedule(
      {required GetCabinetScheduleDto getCabinetSchedule}) async {
    Response res = await DioUtil.getInstance().post(
      "/timetable/classroom/lessons/",
      data: getCabinetSchedule.toJson(),
    );

    return res;
  }
}
