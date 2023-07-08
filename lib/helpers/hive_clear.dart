import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/preset_hive_class.dart';

import '../config/hive_boxes.dart';

void clearBoxData({required String userType}) {
  var userSettingsBox = Hive.box(UserSettingsBox.boxName);

  userSettingsBox.delete(UserSettingsBox.gradeLetter);
  userSettingsBox.delete(UserSettingsBox.gradeNumber);
  userSettingsBox.delete(UserSettingsBox.gradeGroup);
  userSettingsBox.delete(UserSettingsBox.foreignLanguages);
  userSettingsBox.delete(UserSettingsBox.firstMainProfile);
  userSettingsBox.delete(UserSettingsBox.secondMainProfile);
  userSettingsBox.delete(UserSettingsBox.thirdProfile);
  userSettingsBox.delete(UserSettingsBox.firstProfileGroup);
  userSettingsBox.delete(UserSettingsBox.secondProfileGroup);
  userSettingsBox.delete(UserSettingsBox.thirdProfileGroup);
  userSettingsBox.delete(UserSettingsBox.teacherName);

  userSettingsBox.put(UserSettingsBox.userType, userType);
}

void clearActivePreset() {
  var activePresetBox = Hive.box<Preset?>(ActivePresetBox.boxName);
  activePresetBox.deleteAll(activePresetBox.keys);
}
