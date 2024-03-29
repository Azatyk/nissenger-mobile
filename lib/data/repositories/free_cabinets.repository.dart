import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_cabinet_schedule.dto.dart';
import 'package:nissenger_mobile/data/data_providers/dto/get_free_cabinets.dto.dart';
import 'package:nissenger_mobile/data/data_providers/requests/free_cabinets_requests.dart';
import 'package:nissenger_mobile/data/models/free_cabinet.model.dart';
import 'package:nissenger_mobile/data/models/lesson.model.dart';
import 'package:nissenger_mobile/data/models/school.model.dart';

class FreeCabinetsRepository {
  late Box box;
  late String city;
  late String school;

  FreeCabinetsRepository() {
    box = Hive.box(UserSettingsBox.boxName);
    city = box.get(UserSettingsBox.city);
    school = box.get(UserSettingsBox.school);
  }

  Future<List<FreeCabinet>> getCabinetsList() async {
    Response res = await FreeCabinetsRequests.getFreeCabinets(
      getFreeCabinets: GetFreeCabinetsDto(
        school: School(
          city: city,
          name: school,
        ),
      ),
    );

    return (res.data as List)
        .map((freeCabinetsJson) => FreeCabinet.fromJson(json: freeCabinetsJson))
        .toList();
  }

  Future<List<Lesson>> getCabinetSchedule({required String classroom}) async {
    Response res = await FreeCabinetsRequests.getCabinetSchedule(
      getCabinetSchedule: GetCabinetScheduleDto(
        school: School(
          city: city,
          name: school,
        ),
        classroom: classroom,
      ),
    );

    return (res.data as List)
        .map((lessonsList) => Lesson.fromJson(
              teacherLesson: true,
              json: lessonsList,
            ))
        .toList();
  }
}
