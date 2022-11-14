import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/mock/mock_schedule.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_request_cubit/schedule_request_state.dart';

class ScheduleRequestCubit extends Cubit<ScheduleRequestState> {
  ScheduleRequestCubit()
      : super(
          const ScheduleRequestLoading(),
        );

  void loadSchedule() async {
    emit(
      const ScheduleRequestLoading(),
    );

    try {
      await Future.delayed(const Duration(seconds: 1));

      emit(
        ScheduleRequestData(
          schedule: MockSchedule.getMockSchedule(),
        ),
      );
    } catch (err) {
      // todo: handle error
    }
  }
}
