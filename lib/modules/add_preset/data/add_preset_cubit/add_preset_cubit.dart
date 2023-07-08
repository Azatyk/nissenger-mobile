import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nissenger_mobile/common/constants/user_types.dart';
import 'package:nissenger_mobile/helpers/hive_clear.dart';
import 'package:nissenger_mobile/modules/add_preset/data/add_preset_cubit/add_preset_state.dart';
import '../../../../config/hive_boxes.dart';

class AddPresetCubit extends Cubit<AddPresetState> {
  AddPresetCubit() : super(const AddPresetPure());

  void saveUserData({required bool isStudent, required String presetName}) {
    var box = Hive.box(UserSettingsBox.boxName);

    box.put(UserSettingsBox.presetName, presetName);

    if (isStudent) {
      box.put(UserSettingsBox.userType, UserTypes.student);
    } else {
      box.put(UserSettingsBox.userType, UserTypes.teacher);
    }
  }

  void clearHiveBoxes() {
    var userSettingsBox = Hive.box(UserSettingsBox.boxName);
    clearBoxData(userType: UserTypes.student);
    userSettingsBox.delete(UserSettingsBox.presetName);
  }
}
