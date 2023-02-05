import 'package:flutter/foundation.dart';
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

    Preset presetValue = Preset(
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
      box.get(UserSettingsBox.presetName) ?? "",
    );

    bool contains = false;

    if (boxPresetsList.isNotEmpty) {
      for (var i = 0; i < boxPresetsList.length; i++) {
        if (boxPresetsList.getAt(i)!.gradeNumber == presetValue.gradeNumber &&
            boxPresetsList.getAt(i)!.gradeLetter == presetValue.gradeLetter &&
            boxPresetsList.getAt(i)!.gradeGroup == presetValue.gradeGroup &&
            listEquals(boxPresetsList.getAt(i)!.foreignLanguages,
                presetValue.foreignLanguages) &&
            boxPresetsList.getAt(i)!.firstMainProfile ==
                presetValue.firstMainProfile &&
            boxPresetsList.getAt(i)!.secondMainProfile ==
                presetValue.secondMainProfile &&
            boxPresetsList.getAt(i)!.thirdProfile == presetValue.thirdProfile &&
            boxPresetsList.getAt(i)!.firstProfileGroup ==
                presetValue.firstProfileGroup &&
            boxPresetsList.getAt(i)!.secondProfileGroup ==
                presetValue.secondProfileGroup &&
            boxPresetsList.getAt(i)!.thirdProfileGroup ==
                presetValue.thirdProfileGroup &&
            boxPresetsList.getAt(i)!.teacherName == presetValue.teacherName &&
            boxPresetsList.getAt(i)!.presetName == presetValue.presetName) {
          contains = true;
          break;
        }
      }
    }

    print(contains);

    if (!contains) {
      boxPresetsList.add(presetValue);
    }
  }
}
