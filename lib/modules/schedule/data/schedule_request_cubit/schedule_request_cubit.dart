import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/config/preset_hive_class.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';
import 'package:nissenger_mobile/data/repositories/schedule.repository.dart';
import 'package:nissenger_mobile/helpers/schedule_parser.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_request_cubit/schedule_request_state.dart';

class ScheduleRequestCubit extends Cubit<ScheduleRequestState> {
  ScheduleRepository repository;

  ScheduleRequestCubit({required this.repository})
      : super(
          const ScheduleRequestLoading(),
        ) {
    loadSchedule();
  }

  void loadSchedule() async {
    emit(
      const ScheduleRequestLoading(),
    );

    var box = Hive.box(UserSettingsBox.boxName);
    var activePresetBox = Hive.box<Preset?>(ActivePresetBox.boxName);

    Preset? activePreset = Preset(
      box.get(UserSettingsBox.gradeNumber) ?? 0,
      box.get(UserSettingsBox.gradeLetter) ?? "",
      box.get(UserSettingsBox.gradeGroup) ?? 0,
      box.get(UserSettingsBox.foreignLanguages) ?? [],
      box.get(UserSettingsBox.firstMainProfile) ?? "",
      box.get(UserSettingsBox.secondMainProfile) ?? "",
      box.get(UserSettingsBox.thirdProfile) ?? "",
      box.get(UserSettingsBox.firstProfileGroup) ?? "",
      box.get(UserSettingsBox.secondProfileGroup) ?? "",
      box.get(UserSettingsBox.thirdProfileGroup) ?? "",
      box.get(UserSettingsBox.teacherName) ?? "",
      box.get(UserSettingsBox.presetName) ?? "",
      box.get(UserSettingsBox.userType) ?? "",
    );

    if (activePresetBox.length > 0) {
      activePreset = activePresetBox.getAt(0);
    } else if (activePresetBox.length == 0) {
      activePresetBox.add(activePreset);
    }

    String userType = activePreset!.userType;

    int gradeNumber = activePreset.gradeNumber;
    String gradeLetter = activePreset.gradeLetter;
    int gradeGroup = activePreset.gradeGroup;
    String firstProfileGroup = activePreset.firstProfileGroup;
    String secondProfileGroup = activePreset.secondProfileGroup;
    String thirdProfileGroup = activePreset.thirdProfileGroup;
    List<String> foreignLanguage = activePreset.foreignLanguages;

    String teacher = activePreset.teacherName;

    try {
      late Schedule schedule;

      if (userType == UserTypes.student) {
        schedule = await repository.getStudentSchedule(
          gradeNumber: gradeNumber,
          gradeLetter: gradeLetter,
          gradeGroup: gradeGroup,
          profileGroups: gradeNumber != 10
              ? [
                  firstProfileGroup,
                  secondProfileGroup,
                  thirdProfileGroup,
                ]
              : [
                  firstProfileGroup,
                ],
          foreignLanguage: foreignLanguage,
        );
      } else if (userType == UserTypes.teacher) {
        schedule = await repository.getTeacherSchedule(teacher: teacher);
        schedule = ScheduleParser.joinSameTimeLessons(schedule: schedule);
      }

      emit(
        ScheduleRequestData(
          schedule: ScheduleParser.addWindows(schedule: schedule),
        ),
      );
    } on DioError catch (err) {
      if (err.response?.statusCode == 404) {
        emit(const ScheduleNotFoundError());
      } else {
        emit(const ScheduleUnknownError());
      }
    } catch (err) {
      ConnectivityResult connectionResult =
          await (Connectivity().checkConnectivity());

      if (connectionResult == ConnectivityResult.none) {
        emit(const ScheduleInternetConnectionError());
      } else {
        emit(const ScheduleUnknownError());
      }
    }
  }
}
