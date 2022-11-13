import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_request_cubit/schedule_request_state.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/types/day.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/types/scedule_status.dart';

class ScheduleRequestCubit extends Cubit<ScheduleRequestState> {
  ScheduleRequestCubit()
      : super(
          const ScheduleRequestState(
              status: ScheduleStatus.pure, listOfDays: []),
        );

  void loadSchedule({required List<Day> daysList}) async {
    emit(
      const ScheduleRequestState(
          status: ScheduleStatus.loading, listOfDays: []),
    );

    try {
      await Future.delayed(const Duration(seconds: 1));

      emit(
        ScheduleRequestState(
            status: ScheduleStatus.readyToPush, listOfDays: daysList),
      );
    } catch (err) {
      // todo: handle error
    }
  }
}
