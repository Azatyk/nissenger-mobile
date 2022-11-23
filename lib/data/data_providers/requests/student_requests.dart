import 'package:dio/dio.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_class.dto.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_foreign_languages.dto.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_profile_groups.dto.dart';
import 'package:nissenger_mobile/utils/dio.util.dart';

class StudentRequests {
  static Future getClass({required GetClassDto getClassDto}) async {
    Response res = await DioUtil.getInstance().post(
      "/timetable/get-class",
      data: getClassDto.toJson(),
    );

    return res;
  }

  static Future getForeignLanguages({
    required GetForeignLanguagesDto getForeignLanguagesDto,
  }) async {
    Response res = await DioUtil.getInstance().post(
      "/timetable/subjects/foreign-languages",
      data: getForeignLanguagesDto.toJson(),
    );

    return res;
  }

  static Future getProfileGroups(
      {required GetProfileGroupsDto getProfileGroupsDto}) async {
    Response res = await DioUtil.getInstance().post(
      "/timetable/groups/profile",
      data: getProfileGroupsDto.toJson(),
    );

    return res;
  }
}
