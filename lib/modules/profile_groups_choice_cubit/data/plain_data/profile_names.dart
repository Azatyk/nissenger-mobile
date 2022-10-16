import 'package:hive/hive.dart';
import 'package:nissenger_mobile/config/hive_boxes.dart';

Map<String, String> profileGroups = {
  "Физика": "физике",
  "Химия": "химии",
  "Биология": "биологии",
  "Информатика": "информатике",
  "Экономика": "экономике",
  "География": "географии",
  "ГИП": "ГИП",
  "Математика 10 Ч.": "математике 10 Ч.",
};

var box = Hive.box(UserSettingsBox.boxName);
final String firstProfile = box.get(UserSettingsBox.mainProfileOne);
final String secondProfile = box.get(UserSettingsBox.mainProfileTwo);
final String thirdProfile = box.get(UserSettingsBox.thirdProfile);