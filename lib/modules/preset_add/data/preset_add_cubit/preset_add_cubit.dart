import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/modules/preset_add/data/preset_add_cubit/preset_add_state.dart';
import '../../../../config/hive_boxes.dart';

class PresetsAddCubit extends Cubit<PresetAddState> {
  PresetsAddCubit() : super(const PresetAddPure());

  void savePresetNameChoice({required String presetName}) {
    var box = Hive.box(UserSettingsBox.boxName);
    box.put(UserSettingsBox.presetName, presetName);

    emit(const PresetAddReadyToPush());
  }

  void saveUserType({required bool isStudent}) {
    var box = Hive.box(UserSettingsBox.boxName);

    if (isStudent) {
      box.put(UserSettingsBox.userType, UserTypes.student);
    } else {
      box.put(UserSettingsBox.userType, UserTypes.teacher);
    }
  }
}
