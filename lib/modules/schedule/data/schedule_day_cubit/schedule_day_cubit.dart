import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/helpers/weekday_converter.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_day_cubit/schedule_day_state.dart';

class ScheduleDayCubit extends Cubit<ScheduleDayState> {
  ScheduleDayCubit()
      : super(
          const ScheduleDayPure(),
        );

  getDayTitle({required int index, required BuildContext context}) {
    emit(
      ScheduleDayTitle(
        dayTitle:
            WeekdayConverter.indexToWeekday(index: index, context: context),
      ),
    );
  }
}
