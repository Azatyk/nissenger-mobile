import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/common/constants/app_modes.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_hive_cubit/schedule_hive_state.dart';

class ScheduleHiveCubit extends Cubit<ScheduleHiveState> {
  ScheduleHiveCubit() : super(ScheduleHiveState(userType: UserTypes.pure));

  void getUserType() {
    var box = Hive.box(UserSettingsBox.boxName);
    String userType = box.get(UserSettingsBox.userType);

    emit(ScheduleHiveState(userType: userType));
  }

  void saveActiveMode() {
    var box = Hive.box(UserSettingsBox.boxName);
    box.put(UserSettingsBox.activeAppMode, AppModes.schedule);
  }
}
