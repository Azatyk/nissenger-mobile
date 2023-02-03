import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/common/constants/app_modes.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';
import 'package:nissenger_mobile/modules/schedule/data/schedule_hive_cubit/schedule_hive_state.dart';

import '../../../../config/preset_hive_class.dart';

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

  void savePreset() {
    var box = Hive.box(UserSettingsBox.boxName);
    var boxPresetsList = Hive.box<Preset>(PresetsListBox.boxName);

    boxPresetsList.add(
      Preset(
        box.get(UserSettingsBox.gradeNumber) ?? 0,
        box.get(UserSettingsBox.gradeLetter) ?? "",
        box.get(UserSettingsBox.gradeGroup) ?? 0,
        box.get(UserSettingsBox.foreignLanguages) ?? [],
        box.get(UserSettingsBox.firstMainProfile) ?? "",
        box.get(UserSettingsBox.secondMainProfile) ?? "",
        box.get(UserSettingsBox.thirdProfile) ?? "",
        box.get(UserSettingsBox.firstProfileGroup) ?? "",
        box.get(UserSettingsBox.secondProfileGroup) ?? "",
        box.get(UserSettingsBox.thirdProfileGroup) ?? "",
        box.get(UserSettingsBox.teacherName) ?? "",
        boxPresetsList.length == 0
            ? "Мое расписание"
            : box.get(UserSettingsBox.presetName) ?? "",
      ),
    );

    int len = boxPresetsList.length - 1;

    Preset? person = boxPresetsList.getAt(len);

    print(person!.presetName);
  }
}
