import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_scroll_cubit/schedule_scroll_state.dart';

class ScheduleScrollCubit extends Cubit<ScheduleScrollState> {
  ScheduleScrollCubit()
      : super(
          const ScheduleScrollHideBorder(),
        );

  void scrollToBottom() {
    emit(
      const ScheduleScrollShowBorder(),
    );
  }

  void reachTop() {
    emit(
      const ScheduleScrollHideBorder(),
    );
  }
}
