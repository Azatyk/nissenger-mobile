import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nissenger_mobile/common/constants/app_modes.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/timer/data/timer_hive_cubit/timer_hive_state.dart';

class TimerHiveCubit extends Cubit<TimerHiveState> {
  TimerHiveCubit() : super(const TimerHiveState());

  void saveActiveMode() {
    var box = Hive.box(UserSettingsBox.boxName);
    box.put(UserSettingsBox.activeAppMode, AppModes.timer);
  }
}
