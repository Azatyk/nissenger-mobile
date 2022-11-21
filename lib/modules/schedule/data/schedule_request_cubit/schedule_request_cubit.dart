import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/common/mock/mock_schedule.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/data/models/schedule.model.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_request_cubit/schedule_request_state.dart';

class ScheduleRequestCubit extends Cubit<ScheduleRequestState> {
  ScheduleRequestCubit()
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

    try {
      await Future.delayed(const Duration(seconds: 1));

      emit(
        ScheduleRequestData(
          schedule: userType == UserTypes.student
              ? MockSchedule.getMockStudentSchedule()
              : userType == UserTypes.teacher
                  ? MockSchedule.getMockTeacherSchedule()
                  : const Schedule(days: []),
        ),
      );
    } catch (err) {
      // todo: handle error
    }
  }
}
