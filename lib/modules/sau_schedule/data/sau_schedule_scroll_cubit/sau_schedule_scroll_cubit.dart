import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/sau_schedule/data/sau_schedule_scroll_cubit/sau_schedule_scroll_state.dart';

class SauScheduleScrollCubit extends Cubit<SauScheduleScrollState> {
  SauScheduleScrollCubit()
      : super(
          const SauScheduleScrollHideBorder(),
        );

  void scrollToBottom() {
    emit(
      const SauScheduleScrollShowBorder(),
    );
  }

  void reachTop() {
    emit(
      const SauScheduleScrollHideBorder(),
    );
  }
}
