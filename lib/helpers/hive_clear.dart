import 'package:hive/hive.dart';

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

  userSettingsBox.put(UserSettingsBox.userType, userType);
}
