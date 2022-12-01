import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
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

    String userType = box.get(UserSettingsBox.userType);

    int gradeNumber = box.get(UserSettingsBox.gradeNumber) ?? 0;
    String gradeLetter = box.get(UserSettingsBox.gradeLetter) ?? "";
    int gradeGroup = box.get(UserSettingsBox.gradeGroup) ?? 0;
    String firstProfileGroup = box.get(UserSettingsBox.firstProfileGroup) ?? "";
    String secondProfileGroup =
        box.get(UserSettingsBox.secondProfileGroup) ?? "";
    String thirdProfileGroup = box.get(UserSettingsBox.thirdProfileGroup) ?? "";

    String teacher = box.get(UserSettingsBox.teacherName) ?? "";

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
