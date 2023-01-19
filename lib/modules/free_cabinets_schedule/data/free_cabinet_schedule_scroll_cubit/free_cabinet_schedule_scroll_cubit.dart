import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/free_cabinets_schedule/data/free_cabinet_schedule_scroll_cubit/free_cabinet_schedule_scroll_state.dart';

class FreeCabinetScheduleScrollCubit
    extends Cubit<FreeCabinetScheduleScrollState> {
  FreeCabinetScheduleScrollCubit()
      : super(
          const FreeCabinetScheduleScrollHideBorder(),
        );

  void scrollToBottom() {
    emit(
      const FreeCabinetScheduleScrollShowBorder(),
    );
  }

  void reachTop() {
    emit(
      const FreeCabinetScheduleScrollHideBorder(),
    );
  }
}
