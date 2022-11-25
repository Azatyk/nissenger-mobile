import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';
import 'package:nissenger_mobile/data/repositories/schedule.repository.dart';
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

    int gradeNumber = box.get(UserSettingsBox.gradeNumber);
    String gradeLetter = box.get(UserSettingsBox.gradeLetter);
    int gradeGroup = box.get(UserSettingsBox.gradeGroup);
    String firstProfileGroup = box.get(UserSettingsBox.firstProfileGroup);
    String secondProfileGroup = box.get(UserSettingsBox.secondProfileGroup);
    String thirdProfileGroup = box.get(UserSettingsBox.thirdProfileGroup);

    try {
      Schedule schedule = await repository.getSchedule(
        gradeNumber: gradeNumber,
        gradeLetter: gradeLetter,
        gradeGroup: gradeGroup,
        profileGroups: [
          firstProfileGroup,
          secondProfileGroup,
          thirdProfileGroup,
        ],
      );

      emit(
        ScheduleRequestData(
          schedule: schedule,
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
