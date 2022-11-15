import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/helpers/weekday_converter.dart';
import 'package:nissenger_mobile/modules/schedule_display/data/schedule_day_cubit/schedule_day_state.dart';

class ScheduleDayCubit extends Cubit<ScheduleDayState> {
  ScheduleDayCubit()
      : super(
          const ScheduleDayPure(),
        );

  getDayTitle({required int index}) {
    emit(
      ScheduleDayTitle(
        dayTitle: WeekdayConverter.indexToWeekday(index: index),
      ),
    );
  }
}
